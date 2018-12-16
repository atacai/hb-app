class Conference < ApplicationRecord
	has_many :tracks
	has_many :proposals
	
	def generate_talks(priority_config)
		assigned_proposal_ids = Array.new
		track_seq 						= 0
		shortest_duration 		= self.proposals.order(duration_minute: 'asc').first.duration_minute
		longest_duration 			= self.proposals.order(duration_minute: 'desc').first.duration_minute

		# get total sessions duration (each track)
		available_duration = 0
		SessionConfiguration.order('start_time').all.each do |session_config|
			available_duration += (session_config.end_time - session_config.start_time) / 60 # in minutes
		end

		while (assigned_proposal_ids.length < self.proposals.length) do
			track_duration = available_duration

			# track loop
			while (track_duration > 0)
				if assigned_proposal_ids.length == self.proposals.length
					break
				end
				track_seq += 1
				track = Track.create(name: 'Track ' + track_seq.to_s, active: true, conference: self)

				# session loop
				SessionConfiguration.order('start_time').all.each do |session_config|
					session = Session.create(name: session_config.name, active: true, track: track)
					session_duration = (session_config.end_time - session_config.start_time) / 60 # in minutes

					# talk loop
					talks = Array.new
					prev_duration = 0
					prev_end_time = session_config.start_time

					# custom variable based on priority config
					if priority_config == '1'
						prev_duration = session_duration
						sorting = 'desc'
						comparison = '<'
						duration_reset_comparison = shortest_duration
						duration_reset = longest_duration
					else
						prev_duration = 0
						sorting = 'asc'
						comparison = '>'
						duration_reset_comparison = longest_duration
						duration_reset = shortest_duration
					end

					while (session_duration > 0)
						# make where script to exclude assigned proposal ids
						assigned_query = ''
						if assigned_proposal_ids.length != 0
							assigned_query = ' and id not in (' + assigned_proposal_ids.join(',') + ')'
						end

						# scenario 1: check if all proposal is assigned
						# if no proposals left exit loop
						if assigned_proposal_ids.length == self.proposals.length
							break
						# scenario 2: check if between range of longest and shortest
						# if between them, direct take
						elsif (session_duration >= shortest_duration && session_duration <= longest_duration)
							proposal = self.proposals
													.where('duration_minute ' + comparison + '= ?' + assigned_query, session_duration)
													.order(duration_minute: sorting)
													.first
						# scenario 3: check if prev_duration already hit limit
						# if yes, then reset to beginning
						elsif (prev_duration == duration_reset_comparison)
							proposal = self.proposals
													.where('duration_minute ' + comparison + '= ?' + assigned_query, duration_reset)
													.order(duration_minute: sorting)
													.first
						# scenario 4: get next record sequentially from prev duration
						# example desc: if prev duration = 60, aim 45 or 30
						else
							proposal = self.proposals
													.where('duration_minute ' + comparison + ' ?' + assigned_query, prev_duration)
													.order(duration_minute: sorting)
													.first
						end

						# check if scenarios above does not return a result
						# if nil then break
						break if proposal.nil?

						# start & end time calculation
						start_time = prev_end_time
						end_time = start_time + proposal.duration_minute.minute						
						talks << { name: proposal.name, duration_minute: proposal.duration_minute, start_time: start_time, end_time: end_time, active: true, session: session, proposal: proposal }

						prev_duration = proposal.duration_minute
						prev_end_time = end_time
						session_duration -= proposal.duration_minute
						track_duration -= proposal.duration_minute
						assigned_proposal_ids << proposal.id
					end

					# create talks
					Talk.create(talks)
				end # end session loop
			end # end track loop
		end # end proposal ids loop

		# update conference priority_configuration
		self.update_attributes(priority_configuration_id: priority_config)
	end
end
