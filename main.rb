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

get '/jobs/new' do
  erb :new_job
end

get '/jobs/:id' do
  @job = Job.find(params[:id])
  # raise @job.inspect
  erb :show_job
end

post '/jobs' do
  # raise params.inspect
  @job = Job.create(company_name: params[:company_name], job_title: params[:job_title], about_company: params[:about_company], about_job: params[:about_job], location: params[:location])
  redirect "/jobs/#{@job.id}"
end


