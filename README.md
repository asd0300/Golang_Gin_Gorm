//sample code
psql -h localhost -U postgres -d postgres -a -f C:\VS\G\scripts\postgres\initialize.sql
docker build -t nuxtapp . --no-cache
docker-compose  -f '.\docker-compose_test.yaml' up

//backup
pg_dump -U postgres -f 20240205.sql postgres
