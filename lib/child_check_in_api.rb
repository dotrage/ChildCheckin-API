require 'rubygems'
require 'sinatra/base'

module ChildCheckIn
  class API < Sinatra::Base
    set :sessions, false
    
    get '/' do
      "Hello NSW!"
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