module Helpers
  def jekyll(opts="", path="")
    sh "rm -rf _site"
    sh path + "jekyll " + opts
  end
  
  def sass(input)
    sh "cd css && sass #{input}.scss:#{input}.css" if input.kind_of? String
    input.each {|i| sh "cd css && sass #{i}.scss:#{i}.css"} if input.kind_of? Array
  end
  
  def rsync(domain)
    sh "rsync -rtz --delete _site/ pigoz.fastsh.it:~/www/#{domain}/"
  end
  
  def tag_link(tag)
    %[<a href="/tags/#{tag}">#{tag}</a>]
  end
  
  def tag_cloud(tags, from=1, unto=6)
    return @tag_cloud if defined?(@tag_cloud)
  
    tag_counts = tags.map {|tag,posts| [tag, posts.length] }
                     .sort_by {|tag, count| tag.downcase }
    min = tag_counts.min { |a,b| a.last <=> b.last }.last
    max = tag_counts.max { |a,b| a.last <=> b.last }.last
    tag_counts_sizes = tag_counts.map { |tag, count|
      # http://blogs.dekoh.com/dev/2007/10/29/
      # choosing-a-good-font-size-variation-algorithm-for-your-tag-cloud/
      weight = (Math.log(count)-Math.log(min))/(Math.log(max)-Math.log(min))
      size = from + ((unto-from)*weight).round
      [tag, count, size]
    }
  
    @tag_cloud = ['<ol id="tag-cloud">',
        tag_counts_sizes.map {|t,c,s|
          title = c == 1 ? "1 post" : "#{c} posts"
          %{<li class="tier-#{s}" title="#{title}">#{tag_link(t)}</li>}
        }.join(' '),
      '</ol>'
    ].join
  end
end