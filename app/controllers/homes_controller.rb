class HomesController < ApplicationController
	def index
		@priority_configs = PriorityConfiguration.all
		@conferences = Conference.where(active: true)
	end
end
