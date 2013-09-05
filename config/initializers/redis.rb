begin
  redis_url = ENV["REDISTOGO_URL"]
  uri = URI.parse(redis_url)
  $redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
  $redis.get :test
rescue Redis::CannotConnectError, URI::InvalidURIError
  $redis = MockRedis.new if defined?(MockRedis)
end
