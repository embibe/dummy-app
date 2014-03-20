require 'capistrano/rbenv'
require 'capistrano/bundler'
#require 'capistrano/puma'
# require 'capistrano/puma/jungle' #if you need the jungle tasks

set :application, 'dummy'
set :repo_url, 'git@github.com:embibe/dummy-app.git'

set :branch, "redis"
set :deploy_to, '/home/deploy/dummy-app'
# set :scm, :git

set :rbenv_type, :system # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.0'
set :rbenv_path, "/opt/rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RUBY_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value


set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml config/puma.rb }
set :linked_dirs, %w{tmp log node_modules }

set :bundle_bins, fetch(:bundle_bins, [])
set :bundle_roles, :all
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_path, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment'
set :bundle_without, %w{development test}.join(' ')

set :migration_role, 'db'

set :default_env, {   'PATH' => "/opt/rbenv/shims:/opt/rbenv/bin:$PATH" }


set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_role, :app
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 0

# set :keep_releases, 5




namespace :deploy do


  after :finishing, 'deploy:cleanup'

end

task :foo do
  on roles(:app) do
    execute "gem env"
    execute "ls /home/deploy/stats/releases/20140108044856"
    execute "RBENV_ROOT=/opt/rbenv RUBY_VERSION=2.1.0-p0 /opt/rbenv/bin/rbenv exec bundle exec bundle --gemfile /home/deploy/stats/releases/20140108044856/Gemfile --path  --deployment --quiet --binstubs /home/deploy/stats/shared/bin --without development test"
  end
end
