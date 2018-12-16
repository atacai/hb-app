class ProposalsController < ApplicationController
	before_action :edit, :only => [:update]
	before_action :load_data, :except => [:index]

	def load_data
		@conferences = Conference.all
	end

	def index
		@proposals = Proposal.all
	end

	def new
		@proposal = Proposal.new
	end

	def create
		proposal = Proposal.new(proposal_params)
		if proposal.save
			flash.notice = "New Proposal has been created"
			redirect_to proposals_path
		else
			render 'new'
		end
	end

	def edit
		@proposal = Proposal.find(params[:id])
	end

	def update
		if @proposal.update_attributes(proposal_params)
			flash.notice = "Proposal has been updated"
			redirect_to proposals_path
		else
			render 'edit'
		end
	end

	def destroy
		proposal = Proposal.find(params[:id])
		proposal.destroy
		redirect_to proposals_path
	end

	private
	def proposal_params
		params.require(:proposal).permit(:name, :duration_minute, :conference_id)
	end
end
