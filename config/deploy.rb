
#load "deploy/assets"
require "bundler/capistrano"
require 'capistrano/maintenance'

set :application, "fox_apps"
set :repository,  "https://sparknet_admin:spn16058@bitbucket.org/sparknettech/fox-apps-rails"
set :keep_releases, 4
set :rvm_type, :root

default_run_options[:pty] = true

set :scm, :mercurial
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`cap

set :scm_username, "sparknet_admin" #scm user
set :scm_passphrase, "spn16058" #scm user password
set :scm_password, "spn16058" #scm user password

desc "Deploy to Staging"
task :staging do
  set :user, "root"
  set :password, "Spn16058!"

  set :default_environment, {
    'PATH' => "/usr/local/bin:/bin:/usr/bin:/bin:/usr/local/rvm/bin:/usr/local/rvm/gems/ruby-2.2.5/bin",
    'RUBY_VERSION' => 'ruby 2.1.5p273',
    'GEM_HOME'     => '/usr/local/rvm/gems/ruby-2.2.5',
    'GEM_PATH'     => '/usr/local/rvm/gems/ruby-2.2.5',
  }
  set :deploy_to, "/var/www/fox_apps/"
  set :shared_path_nfs, "/data/fox_apps/"
  set :rails_env, "staging"
 
  role :maint, "10.1.2.63"
  role :web, "10.1.2.63"
  role :app, "10.1.2.63"
  role :db,  "10.1.2.63", :primary => true
end

desc "Deploy to production"
task :production do
  set :user, "root"
  set :password, "Spn16058!"
  
  set :default_environment, {
    'PATH' => "/usr/local/bin:/bin:/usr/bin:/bin:/usr/local/rvm/bin:/usr/local/rvm/rubies/ruby-2.2.5/bin",
    'RUBY_VERSION' => 'ruby 2.1.5p273',
    'GEM_HOME'     => '/usr/local/rvm/gems/ruby-2.2.5',
    'GEM_PATH'     => '/usr/local/rvm/gems/ruby-2.2.5',
  }
  
  set :deploy_to, "/var/www/fox_apps/"
  set :shared_path_nfs, "/data/fox_apps/"
  set :rails_env, "production"
 
  role :maint, "li652-215.members.linode.com"
  role :web, "li652-215.members.linode.com"
  role :app, "li652-215.members.linode.com"
  role :db,  "li652-215.members.linode.com", :primary => true
end

namespace :rake do
  task :show_tasks, :roles => [:db] do
    run("cd #{deploy_to}current && bundle exec rake db:migrate RAILS_ENV=#{rails_env}")
  end
end

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
   	 run "chown -R www-data:www-data #{deploy_to}"
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   task :bundle_gems do
    run("cd #{deploy_to}current && bundle install")
   end
   task :setup_log, :roles => :db do
     run "mkdir -p #{shared_path_nfs}log/"
     #run "touch #{shared_path_nfs}log/#{rails_env}.log"
     #run "chmod 0666 #{shared_path_nfs}log/#{rails_env}.log"
   end 
   
   task :pipeline_precompile, :roles => :web do
     run("cd #{deploy_to}current && RAILS_ENV=#{rails_env} RAILS_GROUPS=assets bundle exec rake assets:precompile")
   end

   task :nfs_symlinks do
     run "rm -rf #{deploy_to}shared/system"
     run "mkdir -p #{shared_path_nfs}system"
     run "ln -nfs #{shared_path_nfs}system #{deploy_to}shared/system"
  
     run "rm -rf #{deploy_to}shared/log"
     run "ln -nfs #{shared_path_nfs}log #{deploy_to}shared/log"
   end

   namespace :web do
    task :disable, :roles => :maint do
      require 'erb'
      on_rollback { run "rm #{shared_path_nfs}/system/maintenance.html" }

      reason = ENV['REASON']
      deadline = ENV['UNTIL']      
      template = File.read('app/views/admin/maintenance.html.erb')
      page = ERB.new(template).result(binding)

      put page, "#{shared_path_nfs}/system/maintenance.html", :mode => 0644
    end
  end
end

after "deploy:create_symlink", "deploy:setup_log" 
after "deploy:setup_log", "deploy:nfs_symlinks" 

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:pipeline_precompile"
after "deploy:pipeline_precompile", "rake:show_tasks"
after "rake:show_tasks", "deploy:restart"

after "deploy", "deploy:cleanup"

require "rvm/capistrano"

#before "deploy", "deploy:web:disable"  
#after "deploy", "deploy:web:enable" 