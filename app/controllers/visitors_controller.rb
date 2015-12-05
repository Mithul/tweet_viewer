class VisitorsController < ApplicationController
	
	caches_action :get_tweets,
	expires_in: 1.minute

	before_filter :get_tweets
	def index
		response.headers['Cache-Control'] = 'public, max-age=300'
		@client=@@client
		@now = Time.now
	end

	private
	def get_tweets
		
		@tweets1 = Rails.cache.fetch("tweets", expires_in: 1.minute) do 
				@@client.search("#chennaiFloods -rt").first 100
			end
		@tweets=[]
		@tweets1.each do |tweet|
			if !tweet.media.empty? and tweet.media[0].is_a? Twitter::Media::Photo
				m=Media.find_by_url(tweet.media[0].media_url.to_s)
				if !m
					m=Media.new
					puts "url "+tweet.media[0].media_url.to_s
					Rails.logger.info "url "+tweet.media[0].media_url.to_s
					Rails.logger.info tweet.media[0].media_url.to_s
					m.url=tweet.media[0].media_url.to_s
					m.picture_from_url tweet.media[0].media_url.to_s
					m.save
				end
			else
				m=nil
			end
			t={tweet: tweet,media: m}
			@tweets << t
		end
	end
end
