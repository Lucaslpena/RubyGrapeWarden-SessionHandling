require File.expand_path('../config/environment', __FILE__)

require 'goliath'
require'warden'

require 'active_support'

require 'dalli'
require 'rack/session/dalli'

require 'app/models/user'

class Application < Goliath::API

  use Rack::Session::Dalli, cache: Dalli::Client.new

  use Warden::Manager do |manager|
    manager.default_strategies :token, :password
    manager.failure_app = -> (env) { [401, {}, ["Not authorized"]] }
  end

  Warden::Strategies.add(:token) do
    def valid?
      puts 'testing validity of... token'
      puts env['HTTP_X_AUTH_TOKEN']
      env['HTTP_X_AUTH_TOKEN']
    end
    def authenticate!
      puts 'passed validity check... on token'
      usr = User.cached(env['HTTP_X_AUTH_TOKEN'])
      usr.nil? ? fail!("Unknown Session") : success!(usr)
    end
  end

  Warden::Strategies.add(:password) do
    def valid?
      puts 'testing validity of... username and password'
      puts env['HTTP_X_AUTH_EMAIL']
      puts env['HTTP_X_AUTH_CRED']
      env['HTTP_X_AUTH_EMAIL'] && env['HTTP_X_AUTH_CRED']
    end
    def authenticate!
      puts 'passed validity check... on username and password'
      usr = User.fetch(env['HTTP_X_AUTH_EMAIL'], env['HTTP_X_AUTH_CRED'])
      usr.nil? ? fail!("Unknown Credentials") : success!(usr)
    end
  end

  def response(env)
    ProtectedService.call(env)
  end

end
