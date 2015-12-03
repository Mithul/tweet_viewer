class VisitorsController < ApplicationController
	
	caches_action :index,
	expires_in: 20.minute
	def index
		response.headers['Cache-Control'] = 'public, max-age=300'
		@tweets = @@client.search("#string -rt").first 100
		@client=@@client
	end
end
