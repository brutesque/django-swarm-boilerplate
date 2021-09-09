docker-build:
	docker build \
		--tag localhost/djangoapp:latest \
		djangoapp/.

docker-prepare:
	touch djangoapp/db.sqlite3
	docker run \
		-it --rm \
		--publish 8000:8000 \
		-v "$(PWD)/djangoapp/db.sqlite3":"/opt/services/app/src/db.sqlite3" \
		localhost/djangoapp:latest \
		migrate
	docker run \
		-it --rm \
		--publish 8000:8000 \
		-v "$(PWD)/djangoapp/db.sqlite3":"/opt/services/app/src/db.sqlite3" \
		-v "$(PWD)/secrets/fixtures-admin.json":"/opt/services/app/src/fixtures/admin.json" \
		localhost/djangoapp:latest \
		loaddata fixtures/admin.json

docker-run:
	touch djangoapp/db.sqlite3
	docker run \
		-it --rm \
		--publish 8000:8000 \
		-v "$(PWD)/djangoapp/db.sqlite3":"/opt/services/app/src/db.sqlite3" \
		localhost/djangoapp:latest

docker-deploy: docker-build docker-prepare docker-run
