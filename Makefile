test: restore backup

restore: bucket
	docker compose run --rm app bash -c "aws s3 cp /root/world* s3://\$$S3_BUCKET"
	docker compose run --rm --env MODE=restore app

backup: bucket
	docker compose run --rm --env MODE=backup app

bucket:
	-docker compose run --rm app bash -c "aws s3 mb s3://\$$S3_BUCKET"

clean:
	docker compose kill
	docker compose rm -f
