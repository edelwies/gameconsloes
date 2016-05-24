set :application, 'bazaar'
set :repo_url, 'git@github.com:edelwies/gameconsloes.git'
set :shell, '/bin/bash'

set :rbenv_type, :system
set :rbenv_path, "/home/iranmosafer/.rbenv"
set :rbenv_ruby, '2.1.2'
set :rbenv_ruby_version, '2.1.2'
set :rbenv_custom_path, "/home/iranmosafer/.rbenv"

#set :user, "demo"
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

#set :deploy_to, '/home/demo/iranmosafer/'
set :scm, :git

set :format, :pretty
# set :log_level, :debug
# set :pty, true


set :stages, ["production"]
set :default_stage, "production"

#set :bundle_cmd, "/usr/local/rbenv/bin:/usr/local/rbenv/versions/2.0.0-p247/bin/bundle"
set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"

# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_environment, {
  "PATH" => "/home/iranmosafer/.rbenv/bin:/usr/local/rbenv/versions/2.1.2/bin/:$PATH",
  "RBENV_ROOT" => "/home/iranmosafer/.rbenv",
}

# set :keep_releases, 5
Rake::Task["deploy:compile_assets"].clear

namespace :deploy do
  after :updated, "assets:precompile"

  desc "reload the database with seed data"
  task :seed do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{current_path}; /usr/bin/env bundle exec rake db:seed RAILS_ENV=production"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :mkdir, "-p", current_path.join('tmp')
      execute :touch, current_path.join('tmp/restart.txt')
    end
  end


  desc "Precompile assets locally and then rsync to web servers"
  task :compile_assets do
    on roles(:web) do
      rsync_host = host.to_s

      run_locally do
        #with rails_env: :production do ## Set your env accordingly.
        #  execute :bundle, "exec rake assets:precompile"
        #end
        #execute "rsync -av --delete ./public/assets/ demo@#{rsync_host}:#{shared_path}/public/assets/"
        #execute "rm -rf public/assets"
        # execute "rm -rf tmp/cache/assets" # in case you are not seeing changes
      end
    end
  end




  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      #within release_path do
      #  execute :rake, 'cache:clear'
      #end
    end
  end

  after :finishing, 'deploy:cleanup'
end


desc 'Runs rake db:seed'
task :seed  do
  on primary fetch(:migration_role) do
    within release_path do
      with rails_env: fetch(:rails_env) do
        execute :rake, "db:seed"
      end
    end
  end
end

desc 'Runs rake db:seed'
task :import  do
  on primary fetch(:migration_role) do
    within release_path do
      with rails_env: fetch(:rails_env) do
        execute :rake, "import"
      end
    end
  end
end
