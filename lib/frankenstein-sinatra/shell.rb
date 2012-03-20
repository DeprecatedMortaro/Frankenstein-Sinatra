module FrankensteinSinatra
  class Shell
    def self.git_path *args
      repo = args.first || project
      "git@heroku.com:#{repo}.git"
    end

    def self.project *args
      Dir.pwd.split('/').last.strip
    end

    def self.new *args
      FrankensteinSinatra::TemplateGenerator.new args.first
    end

    def self.clone *args
      system "git clone #{git_path args.first}"
      system "cd #{args.first} && git remote add heroku #{git_path}"
    end

    def self.deploy *args
      setup unless set_up?
      system 'git add .'
      message = args.first || 'Deployed via Sinatra'
      system "git commit -a -m '#{message}'"
      system 'git push heroku master -q'
    end

    def self.console *args
      system 'irb -r ./app.rb'
    end

    def self.server *args
      port = args.first || '6937'
      system "shotgun -I config.ru -p #{port}"
    end

    def self.setup *args
      system "git init"
      system "heroku create" unless system "heroku create #{project}"
      system "heroku addons:add sendgrid:starter"
      system "heroku addons:add memcache"
      system "heroku addons:add custom_domains:basic"
      system "heroku addons:add zerigo_dns:basic"
      fingerprints = "\n#set up via Sinatra"
      File.open("config.ru", 'a+') {|f| f.write(fingerprints)}
      system "bundle install"
    end

    def self.set_up? *args
      IO.readlines("./config.ru")[-1].index "#set"
    end

    def self.help *args
      puts 'sinatra new {projectname} -----------> to generate a new project'
      puts 'sinatra server {optional: port} -----> to run the application server'
      puts 'sinatra console ---------------------> to run the application console'
      puts 'sinatra deploy {optional: message} --> to deploy your application'
    end
  end
end
