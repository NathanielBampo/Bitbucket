RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

add-migration:
	bundle exec rails g migration $(RUN_ARGS)

# Start Guard
g:
	bundle exec guard

# Seed
seed:
	bundle exec rake db:seed

# Migration
dbm:
	bundle exec rake db:migrate
	
# Rollback
dbr:
	bundle exec rake db:rollback

# Reset
reset:
	bundle exec rake db:migrate:reset

# Drop
drop:
	bundle exec rake db:drop db:create db:migrate
