require 'active_support'
class User
  Cache = ActiveSupport::Cache::MemCacheStore.new("localhost")

  CACHE_LENGTH = 60

  def self.fetch(u, p)

    usr = {'lucaslpena@gmail.com' => '391907bb-5cc8-468b-8f97-81aab3d17dd4'}[u] if p == 'mySuperSecureP@ssword'
    if usr
      token = Digest::SHA256.hexdigest(SecureRandom.hex)
      puts "writing key: #{token} with value: #{usr}"
      Cache.write(token, usr, expires_in: CACHE_LENGTH.seconds)
    end
    token
  end

  def self.cached(token)
    Cache.read(token)
  end

  def self.uuid_validate(uuid)
    {'391907bb-5cc8-468b-8f97-81aab3d17dd4' => 'lucaslpena@gmail.com'}[uuid]
  end


end