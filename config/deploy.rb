# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.19.2'

# Capistranoのログの表示に利用する
set :application, 'furima-45700'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:kazuki-0707/furima-45700.git'
set :branch, 'main'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '3.2.0' #カリキュラム通りに進めた場合、’3.2.0’ です

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                                  keys: ['~/.ssh/my-key-pair.pem'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

# bundle の設定を永続化
set :bundle_flags, '--deployment'
set :bundle_path, -> { shared_path.join('bundle') }

# デプロイ時に bundle config を設定
before 'bundler:install', :set_bundle_config

task :set_bundle_config do
  on roles(:app) do
    within shared_path do
      execute :bundle, 'config', 'set', 'force_ruby_platform', 'true'
    end
  end
end