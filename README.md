# README

Technical Requirements:
1. Ruby 2.5.1
2. Rails 5.2.1
3. Posgresql 9.6.x

Do 'bundle install' before starting up rails server
Do changes on 'config/database.yml' to change your database configuration

Run following command to install data (provided on pdf file)
$ RAILS_ENV=production rake db:create db:migrate db:seed

Start server using command below
$ rails s -e production


root_path / localhost:3000
This page is showing generated track, session, and talk based on proposal
From seed data, it is configured as "sequentially descending" by default
You can re-generate using different method on selection box on top right corner
Available method are "sequentially descending" and "sequentially ascending"

"sequentially descending" is method to priorize longest duration proposal
Example, if we have 60 min, 60 min, 45 min, 45 min, 30 min
System will generate talk to be
Track 1
	Session 1
		60 min
		45 min
		30 min
	Session 2
		60 min
		45 min

"sequentially ascending" is method to priorize shortest duration proposal
It is will work same as descending but in reverse
Example like above
System will generate talk to be
Track 1
	Session 1
		30 min
		45 min
		60 min
	Session 2
		30 min
		45 min

conferences_path / localhost:3000/conferences
This page is showing all conferences
You can do creation, updating, deletion of conference on this page

proposals_path / localhost:3000/proposals
This page is showing all proposals
You can do creation, updating, deletion of proposal on this page

session_configurations_path / localhost:3000/session_configurations
This page is showing all configurations which will be used on generating talks
You can only do updating of configuration on this page