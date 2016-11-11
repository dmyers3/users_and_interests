require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

# # Home page
# -redirects to users page
 
# # Users page
# - lists all users and each one is link to individual page
 
# # Individual user page
# - display email address
# - display comma separated interests
# - display links to others users pages (not including current user)
 
# # create generic layout
#   - each page should have number of users and number of total interests
#   - displayed at bottom of each page
#   - these numbers are dynamically generated based off of yaml file
#   - user helper method 'count_interests' to count these
#   - verify it works by adding new user to yaml file

before do
  @users = YAML.load_file("users.yaml")
end

get '/' do
  redirect '/users'
end

get '/users' do
  @title = 'Users'
  
  erb :users
end

get '/user/:name' do
  @name = params[:name].to_sym
  @title = params[:name].capitalize
  @user = @users[@name]
  
  erb :user
end

helpers do
  def count_interests
    total_interests = 0
    @users.each do |name, info|
      total_interests += info[:interests].size
    end
    total_interests
  end
end

not_found do 
  redirect '/users'
end

