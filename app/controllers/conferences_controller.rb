class ConferencesController < ApplicationController
	before_action :edit, :only => [:update]

	def index
		@conferences = Conference.where(active: true)
	end

	def new
		@conference = Conference.new
	end

	def create
		conference = Conference.new(conference_params)
		conference.active = true
		if conference.save
			flash.notice = "New Conference has been created"
			redirect_to conferences_path
		else
			render 'new'
		end
	end

	def edit
		@conference = Conference.find(params[:id])
	end

	def update
		if @conference.update_attributes(conference_params)
			flash.notice = "Conference has been updated"
			redirect_to conferences_path
		else
			render 'edit'
		end
	end

	def destroy
		conference = Conference.find(params[:id])
		conference.update_attributes(:updated_at => Time.now)

		if conference.update_attributes(active: false)
			flash.notice = "Conference has been deleted"
		end
		redirect_to conferences_path
	end

	def change_priority
		conference = Conference.find(params[:id])

		# set to inactive
		conference.tracks.each do |track|
			track.update_attributes(active: false)
			track.sessions.each do |session|
				session.update_attributes(active: false)
				session.talks.update_all(active: false)
			end
		end

		# re-create record based on priority config
		conference.generate_talks(params[:config])
		redirect_to root_path
	end

	private
	def conference_params
		params.require(:conference).permit(:name)
	end
end
