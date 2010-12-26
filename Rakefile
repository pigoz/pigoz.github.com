$:.unshift File.expand_path("../lib", __FILE__)

require 'jekyll'
require 'helpers'
require 'fileutils'
require 'pathname'

# mixing in the Helpers methods
self.extend(Helpers)

# initialize Jekyll's engine
options = Jekyll.configuration({})
site = Jekyll::Site.new(options)
site.read_posts('')

# ------------------------------------------------------------------------------
#  TASKS
# ------------------------------------------------------------------------------
namespace :g do
  task :cloud do
    File.open('_includes/tag-cloud.html', 'w+') do |f|
      f.puts tag_cloud(site.tags)
    end
  end
  
  task :tags do
    site.tags.sort.each do |tag, posts|
      begin
        File.open(".#{tag_url(tag)}.html", 'w+') { |f|
          f.puts tag_page(tag, posts)
        }
      rescue Errno::ENOENT
        FileUtils.mkdir_p ".#{tags_url}"
        retry
      end
    end
  end
  
  task :css do
    sass "screen"
  end
end

desc "Build site using Jekyll"
task :build => :cloud do
  jekyll
end

desc "Serve on Localhost with port 4000"
task :default do
  jekyll "--server --auto"
end

desc "Deploy to VPS"
task :deploy do
  rsync "stefanopigozzi.com"
end