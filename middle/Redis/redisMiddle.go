package redis

import (
	"bytes"
	"context"
	"io/ioutil"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
)

func RedisMiddleware(client *redis.Client) gin.HandlerFunc {
	return func(c *gin.Context) {
		ctx := context.Background()
		// 獲取路由的唯一標識符，這裡假設使用路由的完整路徑作為唯一標識符
		routeKey := c.FullPath()

		// 嘗試從 Redis 中獲取數據
		val, err := client.Get(ctx, routeKey).Result()
		if err == nil {
			// 如果 Redis 中存在數據，直接返回給用戶
			c.JSON(http.StatusOK, gin.H{
				"data": val,
			})
			return
		} else if err != redis.Nil {
			// 如果 Redis 發生其他錯誤，返回錯誤信息
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			c.Abort()
			return
		}

		// 如果 Redis 中不存在數據，繼續執行路由處理程序
		c.Next()

		// 處理完路由處理程序後，檢查是否有生成 JSON 數據
		if c.Writer.Status() == http.StatusOK {
			rawBody, err := ioutil.ReadAll(c.Request.Body)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to read request body"})
				c.Abort()
				return
			}
			// 重設 c.Request.Body，使其可以重新讀取
			c.Request.Body = ioutil.NopCloser(bytes.NewBuffer(rawBody))

			// 如果路由處理程序成功且返回了 JSON 數據，則存入 Redis
			jsonBytes, err := c.GetRawData()
			if err != nil {
				// 處理錯誤情況
				c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
				return
			}

			// 將 JSON 數據存入 Redis，設置適當的過期時間
			err = client.Set(ctx, routeKey, jsonBytes, 0).Err()
			if err != nil {
				// 處理錯誤情況
				c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
				return
			}
		}
	}
}
