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

func GetRedisHelper() *RedisHelper {
	return redisHelper
}

func ConnectRedis() *redis.Client {
	rdb := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "",
		DB:       0,
	})

	redisOnce.Do(func() {
		rdh := new(RedisHelper)
		rdh.Client = rdb
		redisHelper = rdh
	})
	return rdb
}
