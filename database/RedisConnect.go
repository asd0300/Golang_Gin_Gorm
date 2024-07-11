package database

import (
	"sync"

	"github.com/go-redis/redis/v8"
)

type RedisHelper struct {
	*redis.Client
}

var redisOnce sync.Once
var redisHelper *RedisHelper
var rdb *redis.Client

func GetRedisHelper() *RedisHelper {
	return redisHelper
}

func ConnectRedis() {
	rdb = redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "",
		DB:       0,
	})

	redisOnce.Do(func() {
		rdh := new(RedisHelper)
		rdh.Client = rdb
		redisHelper = rdh
	})
}
