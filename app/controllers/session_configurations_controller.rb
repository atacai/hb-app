class SessionConfigurationsController < ApplicationController
	before_action :edit, :only => [:update]

	def index
		@configs = SessionConfiguration.all
	end

	def edit
		@config = SessionConfiguration.find(params[:id])
		# @config.update_attributes(start_time: '10')
		# p asdf
	end

	def update
		if @config.update_attributes(config_params)
			flash.notice = "Configuration has been updated"
			redirect_to session_configurations_path
		else
			render 'edit'
		end
	end

	private
	def config_params
		params.require(:session_configuration).permit(:name, :start_time, :end_time)
	end
end
