# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# CONFERENCES
conference = Conference.create({name: 'Big Programming', active: true})

# SESSION CONFIGURATIONS
session_configs = [
	{ name: 'Session 1', start_time: '09:00', end_time: '12:00' },
	{ name: 'Session 2', start_time: '13:00', end_time: '17:00' },
]
SessionConfiguration.create(session_configs)

# PRIORITY CONFIGURATIONS
priority_configs = [
	{ name: 'Distribute sequentially descending' },
	{ name: 'Distribute sequentially ascending' },
]
PriorityConfiguration.create(priority_configs)

# PROPOSALS
proposals = [
	{ name: 'Writing Fast Tests Against Enterprise Rails', duration_minute: 60, conference: conference },
	{ name: 'Overdoing it in Python', duration_minute: 45, conference: conference },
	{ name: 'Lua for the Masses', duration_minute: 30, conference: conference },
	{ name: 'Ruby Errors from Mismatched Gem Versions', duration_minute: 45, conference: conference },
	{ name: 'Common Ruby Errors', duration_minute: 45, conference: conference },
	{ name: 'Rails for Python Developers lightning Communicating Over Distance', duration_minute: 60, conference: conference },
	{ name: 'Accounting-Driven Development', duration_minute: 45, conference: conference },
	{ name: 'Woah', duration_minute: 30, conference: conference },
	{ name: 'Sit Down and Write', duration_minute: 30, conference: conference },
	{ name: 'Pair Programming vs Noise', duration_minute: 45, conference: conference },
	{ name: 'Rails Magic', duration_minute: 60, conference: conference },
	{ name: 'Ruby on Rails: Why We Should Move On', duration_minute: 60, conference: conference },
	{ name: 'Clojure Ate Scala (on my project)', duration_minute: 45, conference: conference },
	{ name: 'Programming in the Boondocks of Seattle', duration_minute: 30, conference: conference },
	{ name: 'Ruby vs. Clojure for Back-End Development', duration_minute: 30, conference: conference },
	{ name: 'Ruby on Rails Legacy App Maintenance', duration_minute: 60, conference: conference },
	{ name: 'A World Without HackerNews', duration_minute: 30, conference: conference },
	{ name: 'User Interface CSS in Rails Apps', duration_minute: 30, conference: conference },
]
Proposal.create(proposals)

# generate talks based on priority configuration 1
priority_config1 = PriorityConfiguration.first
conference.generate_talks(priority_config1.id)