set :application, "mobilesnoop"
#set :domain, "eliteguard.in" #webmax2.searchamerica.net
set :domain, "54.163.50.195"
set :user, "circar"
set :password, "circar123#"
set :scm_username, "circar"
set :rails_env, "production"
set :scm, :git
set :repository, "git@ezwebguru.unfuddle.com:ezwebguru/mobilesnoop.git"
set :deploy_to, "/home/circar/rails_app/#{application}" 
set :use_sudo, false
set :chmod755, "app config db vendor public"
set :keep_releases, 5 # number of deployed releases to keep
default_run_options[:pty] = true
ssh_options[:keys] = %w(~/.ssh/id_rsa)
ssh_options[:forward_agent] = true
role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :restart, :roles => :app do    
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"  
    run "ln -nfs #{shared_path}/assets  #{release_path}/public/assets"
    
    run "cd #{current_path} && bundle install --path /home/circar/.gem/ruby/2.1.0"

    run "cd #{current_path} && bundle exec rake assets:clean RAILS_ENV=#{rails_env}"
    run "cd #{current_path} && bundle exec rake assets:precompile RAILS_ENV=#{rails_env}"
    run "cd #{current_path} && chmod -R 755 #{chmod755}"
    
    run "touch #{current_path}/tmp/restart.txt"
    
    
    #    run "cd #{current_path} && bundle install --path /home/circar/.gem/ruby/2.1.0"
    #    run "cd #{current_path} && chmod -R 755 #{chmod755}"    
    #    run "touch #{current_path}/tmp/restart.txt"    
  end      
  
  #  namespace :assets do
  #    task :precompile, :roles => [:app, :web], :except => { :no_release => true } do
  #      from = source.next_revision(current_revision)
  #      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
  #        run %Q{rm -rf #{shared_path}/assets && mkdir -p #{shared_path}/assets && rm -rf #{latest_release}/public/assets && ln -s #{shared_path}/assets #{latest_release}/public/assets}
  #        run %Q{cd #{latest_release} && bundle exec rake assets:precompile RAILS_ENV=#{rails_env}}
  #      else
  #        logger.info "Skipping asset pre-compilation because there were no asset changes"
  #      end
  #    end
  #  end
  
end
after "deploy", "deploy:cleanup"
