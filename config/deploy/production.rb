server '3.113.111.83', user: 'ec2-user', roles: %w[app db web]
set :rails_env, 'production'
set :unicorn_rack_env, 'production'

set ssh_options: {
  keys: [File.expand_path('~/.ssh/kossy_key.pem)')]
}
