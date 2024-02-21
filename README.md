//sample code
psql -h localhost -U postgres -d postgres -a -f C:\VS\G\scripts\postgres\initialize.sql
docker build -t nuxtapp . --no-cache
docker-compose  -f '.\docker-compose_test.yaml' up

//backup
pg_dump -U postgres -f 20240205.sql postgres
//restore
psql -U postgres -f /database.sql
//stripe test
卡號
4242 4242 4242 4242 
日期
12 / 34
ccv
567
zip-code
12345

//docker postsql restore example
docker exec -it 1741fa1923ac psql -U postgres -d postgres -f /tmp/20240220.sql