set :rails_env, 'production'
set :rack_env, 'production'

#ssh_options[:forward_agent] = true
#WM - no reason for this I can see? Staging should always deploy from Develop
#allocate_branch = ENV['branch'].nil? ? 'develop' : ENV['branch']
set :branch, "master"

role :app, 'deploy@megan.geek.nz'
role :web, 'deploy@megan.geek.nz'
role :db, 'deploy@megan.geek.nz', :primary => true
