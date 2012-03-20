module FrankensteinSinatra
  class TemplateGenerator

    def initialize project
      @project = project
      Dir.mkdir dir rescue nil
      Dir.mkdir dir('views') rescue nil
      Dir.mkdir dir('views/partials') rescue nil
      Dir.mkdir dir('views/javascripts') rescue nil
      Dir.mkdir dir('views/stylesheets') rescue nil
      Dir.mkdir dir('public') rescue nil
      Dir.mkdir dir('public/js') rescue nil
      Dir.mkdir dir('public/stylesheets') rescue nil
      Dir.mkdir dir('public/images') rescue nil
      Dir.mkdir dir('models') rescue nil
      Dir.mkdir dir('controllers') rescue nil
      Dir.mkdir dir('locales') rescue nil
      Dir.mkdir dir('configs') rescue nil
      app_rb
      config_ru
      gemfile
      layout
      index
      app_sass
      app_coffee
      partial_head
      helpers_rb
      jquery
      gitignore
    end

    def app_rb
      code  = "#coding: utf-8 \n"
      code += "require 'sinatra'\n"
      code += "require 'frankenstein-sinatra'\n\n"
      code += "get '/' do\n"
      code += "  haml :index\n"
      code += "end"
      write dir('app.rb'), code
    end

    def config_ru
      code  = "require ./app\n"
      code +=  "run Sinatra::Application"
      write dir('config.ru'), code
    end

    def helpers_rb
      code  = "helpers do\n"
      code += "end"
      write dir('helpers.rb'), code
    end

    def gemfile
      code  = "source :rubygems \n"
      code += "gem 'frankenstein-sinatra'\n"
      code += "group :production do\n"
      code += "  gem 'therubyracer'\n"
      code += "end"
      write dir('Gemfile'), code
    end

    def layout
      code  = "!!!\n"
      code += "%html\n"
      code += "  %head\n"
      code += "    = partial :head\n"
      code += "  %body\n"
      code += "    #top\n"
      code += "      .wrapper\n"
      code += "    #middle\n"
      code += "      .wrapper\n"
      code += "        = yield\n"
      code += "    #bottom\n"
      code += "      .wrapper\n"
      write dir('views/layout.haml'), code
    end

    def index
      songs = [
        "Saturday Night",
        "I've Got a Crush on You",
        "Oh, What it Seemed to Be",
        "Nancy (With the Laughing Face)",
        "The Coffee Song",
        "The House I Live in",
        "Someone to Watch Over Me",
        "Five Minutes More"
      ]
      code = "%h1 Frankstein sinatra is singing \"#{songs.sample}\""
      write dir('views/index.haml'), code
    end

    def app_sass
      code  = "@import compass/reset\n"
      code += "@import compass/css3\n\n"
      code += "$wrapper: 940px\n\n"
      code += ".wrapper\n"
      code += "  :width $wrapper\n"
      code += "  :margin 0 auto\n"
      code += "#top, #middle, #bottom\n"
      code += "  :float left\n"
      code += "  :width 100%"
      write dir('views/stylesheets/app.sass'), code
    end

    def app_coffee
      code = "$ ->"
      write dir('views/javascripts/app.coffee'), code
    end

    def partial_head
      code  = "%title #{@project}\n"
      code += "%meta{:'http-equiv' => 'Content-Type', :content => 'text/html', :charset => 'utf-8'}\n"
      code += "%link{rel: 'stylesheet', type: 'text/css', href: '/stylesheets/app.css'}\n"
      code += "%link{rel: 'shortcut icon', type: 'image/x-icon', href: '/images/favicon.png'}\n"
      code += "%script{src: '/js/jquery.js'}\n"
      code += "%script{src: '/js/app.js'}"
      write dir('views/partials/_head.haml'), code
    end

    def jquery
      Net::HTTP.start("code.jquery.com"){|http| @code = http.get('/jquery.min.js').body} rescue nil
      write dir('public/js/jquery.js'), @code
    end

    def gitignore
      code  = "*.swp\n"
      code += "*.swo\n"
      code += ".bundle/\n"
      code += ".sass-cache/"
      write dir('.gitignore'), code
    end

    def write file, content
      File.open("#{file}", 'w') {|f| f.write(content) }
    end

    def dir file=''
      "#{@project}/#{file}"
    end

  end
end
