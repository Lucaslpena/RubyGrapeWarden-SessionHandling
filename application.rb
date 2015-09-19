require './config/environment.rb'

class Application < Goliath::API

  def response(env)
    ProtectedService.call(env)
  end

end
