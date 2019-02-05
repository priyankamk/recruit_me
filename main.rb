require 'sinatra'
require 'active_record'
require 'sinatra/reloader'
require 'pry' 
require 'pg'

require_relative 'db_config'
require_relative 'models/job'
require_relative 'models/candidate'

get '/' do
  erb :index
end

# get '/home' do
#   erb :home
# end

get '/jobs/new' do
  erb :new_job
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

# #
# create a link tht opens the page for update resume.
get '/home' do 
 erb :home
end

get '/candidates/new' do
  erb :new_candidate
end

get '/candidates' do
  @candidate = Candidate.all
  erb :show_candidate_profile
end
get '/candidates/:id' do
  @candidate = Candidate.find(params[:id])
  erb :show_candidate_profile
end



post '/candidates' do
  candidate = Candidate.new
  candidate.name = params[:name]
  candidate.summary = params[:summary]
  candidate.career_history = params[:career_history]
  candidate.education = params[:education]
  candidate.skills = params[:skills]
  candidate.save
  redirect "/candidates/#{@candidate.id}"
end
