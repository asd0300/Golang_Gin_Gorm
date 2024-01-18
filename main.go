package main

import (
	"GO_test/database"
	postgres "GO_test/pkg/postgres"
	. "GO_test/src"
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	_ "github.com/joho/godotenv/autoload"
)

func main() {
	test := os.Getenv("test")
	test2 := os.Getenv("test2")

	fmt.Println(test)
	fmt.Println(test2)

	app := gin.Default()
	app.Use(corsMiddleware())
	v1 := app.Group("v1")
	AddProductRoute(v1)
	AddUserRoute(v1)
	go func() {
		database.Connect()
	}()
	err2 := app.Run(":4000")
	if err2 != nil {
		panic(err2)
	}

	// client := postgres.DBClient{}
	// client.Connect()
	// // TestInsert(client)
	// // test := postgres.Player{1, 40, "Ben2"}

	// plays := ReadAll(client)
	// // plays[0].Name = "shing2"
	// // client.Update(plays[0])
	// client.Delete(plays[0])
	// ReadAll(client)
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
