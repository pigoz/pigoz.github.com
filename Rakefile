$:.unshift File.expand_path("../_lib", __FILE__)

require 'jekyll'
require 'helpers'

# mixing in the Helpers methods
self.extend(Helpers)

# initialize Jekyll's engine
options = Jekyll.configuration({})
site = Jekyll::Site.new(options)
site.read_posts('')

# ------------------------------------------------------------------------------
#  TASKS
# ------------------------------------------------------------------------------
task :cloud do
  require 'helpers'
   
  File.open('_includes/tag-cloud.html', 'w+') do |f|
    f.puts tag_cloud(site.tags)
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