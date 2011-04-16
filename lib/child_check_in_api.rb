require 'rubygems'
require 'sinatra/base'

module ChildCheckIn
  class API < Sinatra::Base
    set :sessions, false
    
    get '/' do
      "Hello NSW!"
    end
  end
end