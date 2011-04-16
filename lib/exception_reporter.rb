require 'sinatra/base'

module Sinatra
  module ExceptionReporter
    def report_exception(ex)
      body = "<h3>Error Report</h3>"
      body += "<p>Exception: <strong>#{ex}</strong></p>"
      body += "<h3>Stack Trace:</h3><p>#{ex.backtrace.join('<br />')}</p>"
      
      send_error_email("ChildCheckIn API Error: #{ex.message}", body)
    end
    
    module EmailHelper
      def send_error_email(subject, html_body)
        Pony.mail(
          :to => 'childcheckin@gmail.com',
          :from => 'childcheckin@gmail.com',
          :subject => subject,
          :body => html_body,
          :via => :smtp,
          :headers => {
            'Content-Type' => 'text/html; charset=UTF-8'
          },
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
  end
  
  helpers ExceptionReporter
  helpers ExceptionReporter::EmailHelper
end