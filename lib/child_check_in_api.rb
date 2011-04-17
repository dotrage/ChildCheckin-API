require 'rubygems'
require 'sinatra/base'
require 'mongo_mapper'
require 'json'
require 'pony'
require 'lib/data_model'
require 'lib/exception_reporter'

module ChildCheckIn
  class API < Sinatra::Base
    include Sinatra::ExceptionReporter
    helpers Sinatra::ExceptionReporter::EmailHelper
    
    set :sessions, false
    set :raise_errors, Proc.new { false }
    set :show_exceptions, false
        
    error do
      status 500
      # email the exception
      report_exception(request.env['sinatra.error'])
    end
    
    get '/' do
      content_type :json
      School.first.teachers.to_json
    end
    
    get '/error' do
      i_dont_exist
    end
    
    # create school
    post '/school' do
      school = School.create({
        :name => params[:name],
        :location => params[:location],
        :created => Time.now
      })
    end
    
    get '/school/:id' do
      School.find(param[:id]).first.to_json
    end
    
    # get teacher representation
    get '/teacher/:id' do
      
    end
    
    get '/class/:id' do
      # requires a teacher id
    end
    
    # create a class
    post '/class/:id' do
    end
    
    # create today's attendance record
    # ...if you call this more than once a day, it errors out
    # because you can't have more than one attendance record
    # a day per class
    post '/class/:id/attendance' do
    end
    
    # create a student
    post '/student' do
    end
    
    # update a student
    put '/student/:id' do
    end
    
    # delete a student
    delete '/student/:id' do
    end
    
    # get student representation
    get '/student/:id' do
    end
    
    # student attendance history
    get '/student/:id/history' do
    end
    
    # add student to class
    post '/class/:id/student/:id' do
    end
    
    # remove student from class
    delete '/class/:id/student/:id' do
    end
  end
end