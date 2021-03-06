start:
	rm -f tmp/pids/server.pid
	docker-compose up -d

from_scratch:
	docker-compose run web rake db:setup db:seed

stop:
	docker-compose down
	rm -f tmp/pids/server.pid

rebuild:
	docker-compose build

rubocop:
	docker-compose run web rubocop -a

routes:
	docker-compose run web rake routes

console:
	docker-compose run web rails console

logs:
	docker-compose logs -tf

staging_deploy:
	heroku maintenance:on --app confy-staging
	git push -ff staging `git rev-parse --abbrev-ref HEAD`:master
	heroku pg:killall --app confy-staging
	#heroku pg:reset --app confy-staging --confirm confy-staging
	heroku run rake db:migrate --app confy-staging
	#heroku run rake db:seed --app confy-staging
	heroku ps:scale web=1 --app confy-staging
	heroku restart --app confy-staging
	heroku maintenance:off --app confy-staging

production_deploy:
	heroku maintenance:on --app confy-wecodeio
	git push production master
	heroku pg:killall --app confy-wecodeio
	heroku run rake db:migrate --app confy-wecodeio
	heroku ps:scale web=1 --app confy-wecodeio
	heroku restart --app confy-wecodeio
	heroku maintenance:off --app confy-wecodeio
