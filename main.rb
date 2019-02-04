require 'sinatra'
require 'active_record'
require 'sinatra/reloader'
require 'pry' 
require 'pg'
require_relative 'db_config'
require_relative 'models/job'


get '/' do
  erb :index
end

get '/jobs' do
  @jobs = Job.all
  erb :list_job
end

get '/jobs/new' do
  erb :new_job
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
  
@job = Job.find(company_name: params[:company_name], job_title: params[:job_title], about_company: params[:about_company], about_job: params[:about_job], location: params[:location])

@job.update
redirect "/jobs/#{params[:id]}"
end

delete '/jobs/:id' do
  @job = Job.find(params[:id])
  @job.destroy
  redirect '/jobs'
end

