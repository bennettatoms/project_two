class TweetSentiment < ActiveRecord::Base
  belongs_to :user

  validates :search_term, presence: true

  def self.search_tweets(term)
    address = parse_address(term)
    response = get_response(address)

    if response.code == '200'
      parse_tweets(response)
    else
      puts "Could not retrieve tweets! " +
      "Code:#{response.code} Body:#{response.body}"
    end
  end

  def self.parse_address(term)
    term ||= "sally jesse raphael"
    baseurl = "https://api.twitter.com"
    path    = "/1.1/search/tweets.json"
    query   = URI.encode_www_form(
      "q" => term, "count" => 25
    )
    URI("#{baseurl}#{path}?#{query}")
  end

  def self.get_response(address)
    consumer_key = OAuth::Consumer.new(
      "lGrWAf5QhKfAEIHRkiny53yWA",
      "KX83HEMX8BJ3XMQE3x9rY4deYPgMrIqtUklDwdR8qzAyEoigQH")
    access_token = OAuth::Token.new(
      "2861099622-fLEWCan1XLsuV2u58oc48Wwzx4LO2rrNZ40dLPh",
      "aL4ZWzpkrCUKg9OxDo3J0gqGQoFbKRp62SZj0Rs88k8cO")
    request = Net::HTTP::Get.new address.request_uri
    
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request.oauth! http, consumer_key, access_token
    http.start
    http.request request
  end

  def self.parse_tweets(response)
    results  = JSON.parse(response.body)
    results['statuses'].map do |tweet|
      { text: tweet['text'],
        user: tweet['user']['screen_name'],
        created_at: DateTime.parse(tweet['created_at']).strftime('%T, %v'),
        sentiment: AlchemyAPI.search(:sentiment_analysis, text: tweet['text']) }
    end
  end
end

