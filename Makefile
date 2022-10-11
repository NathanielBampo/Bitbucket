RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

add-migration:
	bundle exec rails g migration $(RUN_ARGS)

# Start Guard
g:
	bundle exec guard

# Migration
dbm:
	bundle exec rake db:migrate
	
# Rollback
dbr:
	bundle exec rake db:rollback
