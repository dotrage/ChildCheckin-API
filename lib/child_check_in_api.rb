require 'rubygems'
require 'sinatra/base'
require 'mongo_mapper'
require 'json'
require 'pony'

require 'lib/models/school'

MongoMapper.connection = Mongo::Connection.new('flame.local.mongohq.com', 27057, :pool_size => 5, :timeout => 5)
MongoMapper.database = 'childcheckin'
MongoMapper.database.authenticate('app', 'oWf5_Ly')

module ChildCheckIn
  class API < Sinatra::Base
    set :sessions, false
    
    helpers do
      def send_error_email(subject, html_body)
        Pony.mail(
          :to => 'childcheckin@gmail.com',
          :from => 'childcheckin@gmail.com',
          :subject => subject,
          :body => html_body,
          :via => :smtp,
          :smtp => {
            :host => 'smtp.gmail.com',
            :port => '587',
            :user => 'childcheckin@gmail.com',
            :password => 'nsw3team6',
            :auth => :plain,
            :domain => 'childcheckin.heroku.com',
            :tls => true
          }
        )
      end
    end
    
    error do
      status 500
      
      # email the exception
      ex = request.env['sinatra.error']
      body = "<h3>Exception:</h3><p>#{e}</p><p>#{e.backtrace.join('<br />')}</p>"
      send_error_email('ChildCheckIn API Error: #{ex.message}', body)
    end
    
    get '/' do
      content_type :json
      { :foo => 'bar' }.to_json
      
      send_error_email('test', 'test')
    end
    
    # create school
    post '/school' do
      school = School.create({
        :name => params[:name],
        :location => params[:location],
        :created => Time.now
      })
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