class Tweet < ActiveRecord::Base

  def self.search_tweets(term)
    term ||= "left shark"
    consumer_key = OAuth::Consumer.new(
      "lGrWAf5QhKfAEIHRkiny53yWA",
      "KX83HEMX8BJ3XMQE3x9rY4deYPgMrIqtUklDwdR8qzAyEoigQH")
    access_token = OAuth::Token.new(
      "2861099622-fLEWCan1XLsuV2u58oc48Wwzx4LO2rrNZ40dLPh",
      "aL4ZWzpkrCUKg9OxDo3J0gqGQoFbKRp62SZj0Rs88k8cO")

    baseurl = "https://api.twitter.com"
    path    = "/1.1/search/tweets.json"
    query   = URI.encode_www_form(
      "q" => term
    )

    address = URI("#{baseurl}#{path}?#{query}&count=30")
    request = Net::HTTP::Get.new address.request_uri
    
    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

    # Parse and print the Tweet if the response code was 200
    tweet = nil
    if response.code == '200'
      tweet  = JSON.parse(response.body)
      
      display = tweet["statuses"].map do |tweet|
        { text: tweet['text'],
          created_at: DateTime.parse(tweet['created_at']).strftime('%T, %v') }
      end
    else
      puts "Could not retrieve tweets! " +
      "Code:#{response.code} Body:#{response.body}"
    end
  end
end
