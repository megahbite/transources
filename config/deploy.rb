# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'transources'
set :repo_url, 'https://github.com/megahbite/transources'
set :branch, "master"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/srv/http/transources.megan.geek.nz'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/local_env.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, { path: '/home/megan/.rbenv/shims:/home/megan/.rbenv/bin:$PATH' }

# Default value for keep_releases is 5
set :keep_releases, 3

set :bundle_without, %w{development test}.join(" ")

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end

  task :start do
    on roles(:app) do
      within release_path do
        execute :bundle, "exec passenger start -d -e production"
      end
    end
  end

  task :stop do
    on roles(:app) do
      within release_path do
        execute :bundle, "exec passenger stop"
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :updated, :cleanup

  before :starting, 'git:commit_check'
end

require "./config/boot"