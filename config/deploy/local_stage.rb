require 'bundler/capistrano'
#service sshd start
#rvm info
set :default_environment, { 
    'PATH'=>         "/home/david/.rvm/gems/ruby-1.9.3-p448@spree_abc/bin:/home/david/.rvm/gems/ruby-1.9.3-p448@global/bin:/home/david/.rvm/rubies/ruby-1.9.3-p448/bin:/home/david/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/david/bin",
    'RUBY_VERSION' => 'ruby 1.9.3',
    'GEM_HOME' =>     "/home/david/.rvm/gems/ruby-1.9.3-p448@spree_abc",
    'GEM_PATH' =>     "/home/david/.rvm/gems/ruby-1.9.3-p448@spree_abc:/home/david/.rvm/gems/ruby-1.9.3-p448@global",
    'BUNDLE_PATH'  => "/home/david/.rvm/gems/ruby-1.9.3-p448@spree_abc"  
}

set :user, 'david'
set :password, '123456'
set :use_sudo, false

set :application, "SpreeABC"

default_run_options[:pty] = true
set :scm, :git
set :scm_user, "qinghe"
set :scm_passphrase, "a12345z"
set :repository,  "git@github.com:RuanShan/spree_abc.git"
set :repository_cache, "cached_copy" #create this folder 
set :branch, "2-0-stable"
#set :git_shallow_clone, 1
set :scm_verbose, true 

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# should allow sshd, add 'sshd:127.0.0.1' >> /etc/hosts.allow 
server "127.0.0.1", :app, :web, :db, :primary => true

set :deploy_to, "/var/www/deployed_apps/spree_abc"
#set :deploy_via, :copy
set :deploy_via, :remote_cache
set :copy_exclude, [ '.git' ]
set :rails_env, 'local_stage'
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
 namespace :rvm do
   task :trust_rvmrc do
     run "rvm rvmrc trust #{release_path}"
   end
 end