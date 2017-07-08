up:
	docker-compose up --build

down:
	docker-compose down

clean:
	docker-compose down --rmi local --volumes

test:
	docker-compose exec app bundle exec rake test:all

test-services:
	docker-compose exec app bundle exec rake test:services

test-integration:
	docker-compose exec app bundle exec rake test:integration

test-features:
	docker-compose exec app bundle exec rake test:features

test-health:
	docker-compose exec app bundle exec rake test:health

test-end2end:
	docker-compose exec app bundle exec rake test:end2end

logs:
	docker-compose logs -f