set :application, "missionclick"
set :repository,  "git@github.com:skwp/missiondog.git"
set :user, "missionclick"
set :password, "m1ss10nd0g"
set :use_sudo, true
set :branch, ENV["BRANCH"] || 'master'

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "173.203.214.104" 
role :app, "173.203.214.104"
role :db,  "173.203.214.104", :primary => true

after "deploy:setup", "deploy:permissions"
if ENV["FIRST_TIME"] 
  before "deploy:migrate", "deploy:setup_db"
end

# For nginx/passenger
namespace :deploy do
  task :permissions do
    sudo  "chown -R missionclick /u"
  end

  task :setup_db do
    run "cd #{release_path} && rake RAILS_ENV=production db:setup"
  end

  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "rm -rf #{current_release}/tmp/cache/*" # cleanup cache
    run "touch #{current_release}/tmp/restart.txt"
  end
  
  desc "Create asset packages for production" 
  task :after_update_code, :roles => :app do
    run %{ cd #{release_path} && rake asset:packager:build_all }
  end

end

