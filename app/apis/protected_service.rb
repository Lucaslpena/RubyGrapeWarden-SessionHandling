require 'grape'
require 'grape_logging'
require 'rack/cors'
require 'json'

class ProtectedService < Grape::API

  format :json

  helpers do

    def current_user
      User.uuid_validate(env['warden'].user)
    end

    def authenticate!
      env['warden'].authenticate!
    end

  end

  resource 'user' do

    # GET /user/session HTTP/1.1
    # X-Auth-Email: lucaslpena@gmail.com
    # X-Auth-Cred: mySuperSecureP@ssword
    # Content-Type: application/json
    # Host: localhost:9000

    get "/session" do
      passed_params = declared(params, include_missing: false)
      given_name = passed_params[:name]
      authenticate!
      {token: env['warden'].user}
    end


    # GET /user/value HTTP/1.1
    # X-Auth-Token: [TOKEN returned from previous request!]
    # Content-Type: application/json
    # Host: localhost:9000

    get "/value" do
      authenticate!
      {email: current_user}
    end

  end

end