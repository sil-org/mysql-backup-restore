test: restore backup

db:
	docker compose up -d db adminer

restore: bucket
	docker compose run --rm app bash -c "aws s3 cp /root/world* \$$S3_BUCKET"
	docker compose run --rm --env MODE=restore app

backup: bucket
	docker compose run --rm --env MODE=backup app

bucket:
	-docker compose run --rm app bash -c "aws s3 mb \$$S3_BUCKET"

clean:
	docker compose kill
	docker compose rm -f
