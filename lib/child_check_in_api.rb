require 'ruby-debug'
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
        request.env['HTTP_X_USER_TOKEN']
      end
      
      def get_api_key
        request.env['HTTP_X_API_KEY']
      end
      
      def require_user_token
        user_token = get_user_token
        
        if user_token
          halt 402, "Access denied. Invalid or expired user token." unless validate_user_token(user_token)
        else
          halt 405, "Access denied. Missing required user token header (X-User-Token)."
        end
      end
      
      def require_api_key
        api_key = get_api_key
        
        if api_key
          halt 400, "Access denied. Invalid API key." unless validate_api_key(api_key)
        else
          halt 401, "Access denied. Missing required API key (X-API-Key)."
        end
      end
      
      def validate_user_token(user_token)
        UserToken.first({ :user_token => user_token }) != nil
      end
      
      def validate_api_key(api_key)
        #APIKey.find(api_key) != nil
        api_key == 'f1db1a24794120734e5ff2c6f2f2833f19f0c20f'
      end
    end
    
    before do
      require_api_key
      require_user_token if request.path =~ /[^\/authenticate]/
      
      token = UserToken.first({ :user_token => get_user_token })
      
      if token
        @user = token.person
      else
        debugger
        halt 403, "Access denied. Invalid user token."
      end
    end
    
    post '/authenticate' do
      
    end
    
    get '/' do
      content_type :json
      
      "authenticated [#{@user.first_name}]."
    end
    
    get '/status' do
      [200, 'OK.']
    end
    
    get '/error' do
      i_dont_exist
    end
    
    # create school
    post '/schools' do
      school = School.create({
        :name => params[:name],
        :location => params[:location]
      })
      
      content_type :json
      [201, { 'Location' => "/schools/#{school.id}" }, school.to_json]
    end
    
    get '/schools/:id' do
      School.find(params[:id]).to_json
    end
    
    # get teacher representation
    get '/teachers/*' do
      if params[:splat]
        teacher_id = params[:splat][0]
      else
        teacher_id = @user[:id]
      end
      
      Teacher.first(teacher_id).to_json
    end
    
    # create a class
    post '/teachers/*/classes/:id' do
      
      
      # respond w/ Location: classroom uri
    end
    
    get '/teachers/*/classes' do
    end
    
    get '/teachers/*/classes/:id' do
      if params[:splat]
        teacher_id = params[:splat][0]
      else
        teacher_id = @user[:id]
      end
      
      classroom_id = Teacher.first(teacher_id).classrooms
      
      ClassRoom.first(classroom_id).to_json
    end
    
    # create today's attendance record
    # ...if you call this more than once a day, it errors out
    # because you can't have more than one attendance record
    # a day per class
    post '/classes/:id/attendances' do
    end
    
    # student attendance history
    get '/students/:id/history' do
    end
    
    # add student to class
    post '/classes/:id/students/:id' do
    end
    
    # remove student from class
    delete '/classes/:id/students/:id' do
    end
  end
end