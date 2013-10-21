require 'bundler/capistrano'
set :application, 'demo'
set :repo_url, 'git@github.com:Pope99/demo.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :branch, "master"
set :repository,  "git@github.com:Pope99/demo.git"
set :scm, :git
set :user, "Pope99" # 一個伺服器上的帳戶用來放你的應用程式，不需要有sudo權限，但是需要有權限可以讀取Git repository拿到原始碼
set :port, "22"

set :deploy_to, 'home/rails'
set :scm, :git
set :deploy_via, :remote_cache
set :use_sudo, false

role :web, "111.222.333.444"
role :app, "111.222.333.444"
role :db,  "111.222.333.444", :primary => true

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5







namespace :deploy do

  task :copy_config_files, :roles => [:app] do
    db_config = "#{shared_path}/database.yml"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end

  task :update_symlink do
    run "ln -s #{shared_path}/public/system #{current_path}/public/system"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
after "deploy:update_code", "deploy:copy_config_files" # 如果將database.yml放在shared下，請打開
# after "deploy:finalize_update", "deploy:update_symlink" # 如果有實作使用者上傳檔案到public/system，請打開