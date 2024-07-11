package main

import (
	"GO_test/database"
	postgres "GO_test/pkg/postgres"
	. "GO_test/src"
	"context"
	"fmt"
	"net/http"
	"os"
	"time"

	// _ "GO_test/docs"s

	"github.com/gin-gonic/gin"
	_ "github.com/joho/godotenv/autoload"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

//	@title			Swagger PoYa Site API
//	@version		1.0
//	@license.name	Apache 2.0

func main() {
	database.ConnectRedis()
	// redis := database.GetRedisHelper().Client
	app := setupRouter()
	err2 := app.Run(":4000")
	if err2 != nil {
		panic(err2)
	}
}

func SetLog() *os.File {
	currentDate := time.Now().Format("2006-01-02")
	logDir := "./log"
	logFile := fmt.Sprintf("%s/%s-gin.log", logDir, currentDate)
	if err := os.MkdirAll(logDir, os.ModePerm); err != nil {
		panic(err)
	}
	f, err := os.Create(logFile)
	if err != nil {
		panic(err)
	}
	return f
}

func setupRouter() *gin.Engine {
	// f := SetLog()
	// gin.DefaultWriter = f
	// gin.DefaultErrorWriter = f
	app := gin.Default()
	// app.Use(timeoutMiddleware(5 * time.Second))
	app.Use(corsMiddleware())
	v1 := app.Group("v1")
	AddProductRoute(v1)
	AddUserRoute(v1)
	AddCartRoute(v1)
	AddFavoriteRoute(v1)
	// go func() {
	// 	database.Connect()
	// }()
	database.Connect()
	app.GET("swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	return app
}
func corsMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, userToken")
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(http.StatusOK)
			return
		}
		c.Next()
	}
}

func timeoutMiddleware(timeout time.Duration) gin.HandlerFunc {
	return func(c *gin.Context) {
		// Wrap the request context with a timeout
		ctx, cancel := context.WithTimeout(c.Request.Context(), timeout)
		defer cancel() // Important to avoid a context leak

		// Replace the request with a context-aware request
		c.Request = c.Request.WithContext(ctx)

		// Use a channel to receive a signal when the request is done
		done := make(chan struct{}, 1)
		go func() {
			c.Next() // Process the request
			done <- struct{}{}
		}()

		select {
		case <-ctx.Done():
			c.AbortWithStatusJSON(http.StatusGatewayTimeout, gin.H{"message": "request timed out"})
		case <-done:
		}
	}
}

func ReadAll(client postgres.DBClient) []postgres.Player {
	getPlayer, error := client.Get()
	if error != nil {
		fmt.Print(error)
	}
	for i, v := range getPlayer {
		fmt.Printf("%d is %#v\n", i, v)
	}
	return getPlayer
}

func TestInsert(client postgres.DBClient) {
	// play := postgres.Player{30, "Ben2"}
	// client.Insert(play)
}

func DBConn() postgres.DBClient {
	client := postgres.DBClient{}
	client.Connect()
	return client
}
