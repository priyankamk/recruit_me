require 'sinatra'
require 'active_record'
require 'sinatra/reloader'
require 'pry' 
require 'pg'

require_relative 'db_config'
require_relative 'models/job'
require_relative 'models/candidate'
require_relative 'models/employer'

# to enable random string - when the user loginIn
enable :sessions # sinatra dealing with storing the session for you

helpers do
  def current_user
    return nil if session[:user_id].nil?

    if session[:role] == "candidate"
      Candidate.find_by(id: session[:user_id])
    elsif session[:role] == "employer"
      Employer.find_by(id: session[:user_id])
    end
  end

  def current_role
    current_user && session[:role]
  end

  def logged_in? # predicate method boolean
    if current_user
      true
    else
      false
    end
  end
end

get '/' do
  erb :job_search
end

get '/jobs/search' do
  @jobs = Job.where(company_name: params[:company_name]).or(Job.where(location: params[:location]))
  erb :job_search
end

get '/about' do
  erb :about
end

get '/jobs/new' do
  if current_role != "employer"
    status 403 # block access if employer hasn't logged in.
  else
    erb :new_job
  end
end

get '/jobs' do
  @jobs = Job.all
  erb :list_job
end

get '/jobs/:id' do
  @job = Job.find(params[:id])
  erb :show_job
end

post '/jobs' do
  @job = Job.create(company_name: params[:company_name], job_title: params[:job_title], about_company: params[:about_company], about_job: params[:about_job], location: params[:location])
  redirect "/jobs/#{@job.id}"
end

get '/jobs/:id/edit' do
  @job = Job.find(params[:id])
  erb :edit_job
end

# show the updated job list
put '/jobs/:id' do
@job = Job.find(params[:id])

@job.update(company_name: params[:company_name], job_title: params[:job_title], about_company: params[:about_company], about_job: params[:about_job], location: params[:location])
@job.save

redirect "/jobs/#{params[:id]}"

end

delete '/jobs/:id' do
  @job = Job.find(params[:id])
  @job.destroy
  redirect '/jobs'
end

# create a link tht opens the page for update resume.
get '/home' do 
 erb :home
end

get '/candidates/new' do
  erb :new_candidate
end

get '/candidates' do
  @candidates = Candidate.all
  erb :list_candidate
end

get '/candidates/:id' do
  @candidate = Candidate.find(params[:id])
  erb :show_candidate_profile
end

post '/candidates' do
  @candidate = Candidate.create(name: params[:name], summary: params[:summary], career_history: params[:career_history], education: params[:education], skills: params[:skills], email: params[:email], password: params[:password])
  
  @candidate.save!
  redirect "/candidates/#{@candidate.id}"
end

get '/candidates/:id/edit' do
  if params[:id].to_i == current_user.id
  @candidate = Candidate.find(params[:id])
  erb :edit_candidate
  else
    # forbidden
    status 403
  end
end

# show the updated candidate list
put '/candidates/:id' do
  @candidate = Candidate.find(params[:id])
  
  @candidate.update(name: params[:name], summary: params[:summary], career_history: params[:career_history], education: params[:education], skills: params[:skills])
  @candidate.save
  
  redirect "/candidates/#{params[:id]}"
  
end

delete '/candidates/:id' do
  @candidate = Candidate.find(params[:id])
  @candidate.destroy
  redirect '/candidates/new'
end

get '/login' do
  redirect '/' if current_user

  erb :login
end

post '/session' do
  user = if params[:role] == "employer"
    Employer.find_by(email: params[:email])
  else
    Candidate.find_by(email: params[:email])
  end

  # check email first
  if user && user.authenticate(params[:password])
    # success
    # create the session - adding items to the session variable - it is hash
    # adding key value pair
    
    session[:user_id] = user.id
    session[:role] = params[:role]

    # redirect to secure place
    redirect '/'
  else
    # kick them out
    # show the login form becus pw or email wrong
    erb :login
  end
end

get '/session' do
  session[:user_id] = nil
  session[:role] = nil
  redirect '/login'
end