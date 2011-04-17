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
      
      content_type :json
      { :error => 'Internal server error occurred.' }.to_json
    end
    
    helpers do
      def get_user_token
        headers['X-User-Token'] || params[:ut]
      end
      
      def get_api_key
        headers['X-API-Key'] || params[:api]
      end
      
      def require_user_token
        if !header.has_key?('X-User-Token')
          halt 403, "Access denied. Missing required user token header (X-User-Token)."
        elseif validate_user_token(headers['X-User-Token']) == nil
          halt 403, "Access denied. Invalid or expired user token."
        end
      end
      
      def require_api_key
        if !headers.has_key?('X-API-Key')
          halt 403, "Access denied. Missing required API key (X-API-Key)."
        elseif validate_api_key(headers['X-API-Key']) == false
          halt 403, "Access denied. Invalid API key."
        end
      end
      
      def validate_user_token(user_token)
        UserToken.find({ :user_token => user_token })
      end
      
      def validate_api_key(api_key)
        #APIKey.all({ :api_key => api_key}).empty? == false
        api_key == 'f1db1a24794120734e5ff2c6f2f2833f19f0c20f'
      end
    end
    
    before do
      #require_api_key
      require_user_token if request.path =~ /[^\/auth]/
      
      token = UserToken.first({ :user_token => get_user_token })
      
      if token
        @user = token.person
      else
        halt 403, "Access denied. Invalid user token."
      end
    end
    
    post '/auth' do
      
    end
    
    get '/' do
      content_type :json
      
      "authenticated [#{@user.first_name}]."
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