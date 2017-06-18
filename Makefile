up:
	docker-compose up --build

down:
	docker-compose down

clean:
	docker-compose down --rmi local --volumes

test:
	docker-compose exec app bundle exec rake test:all

logs:
	docker-compose logs -f