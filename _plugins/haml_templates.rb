module Jekyll
  begin
    require 'haml'
  rescue LoadError
    STDERR.puts 'You are missing a library required for Haml. Please run:'
    STDERR.puts ' $ [sudo] gem install haml'
    raise FatalException.new("Missing dependency: haml")
  end
  class HamlConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /haml/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      engine = Haml::Engine.new(content)
      engine.render
    end
  end

  begin
    require 'sass'
  rescue LoadError
    STDERR.puts 'You are missing a library required for Sass. Please run:'
    STDERR.puts ' $ [sudo] gem install haml'
    raise FatalException.new("Missing dependency: haml")
  end
  class SassConverter < Converter
    safe true
    priority :low

     def matches(ext)
      ext =~ /sass/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      engine = Sass::Engine.new(content)
      engine.render
    end
  end
end

