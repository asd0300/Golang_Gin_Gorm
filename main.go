package main

import (
	"GO_test/database"
	postgres "GO_test/pkg/postgres"
	. "GO_test/src"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	app := gin.Default()
	app.Use(corsMiddleware())
	v1 := app.Group("v1")
	AddProductRoute(v1)
	go func() {
		database.Connect()
	}()
	database.Connect()
	// app.GET("/user", jwt.JWTAuthMiddleware(), func(c *gin.Context) {
	// 	c.String(200, "/user")
	// })
	// app.GET("hello/:name", func(c *gin.Context) {
	// 	fmt.Println(c.FullPath())
	// 	name := c.Param("name")
	// 	c.JSON(200, gin.H{
	// 		"message": "hello " + name,
	// 	})
	// 	c.String(http.StatusOK, "\n123")
	// })
	// app.GET("/go/:name/*action", func(c *gin.Context) {
	// 	name := c.Param("name")
	// 	action := c.Param("action")
	// 	message := name + " is " + action
	// 	c.String(http.StatusOK, message)
	// })
	// app.POST("/user/create", func(c *gin.Context) {
	// 	var user postgres.User
	// 	err := c.ShouldBind(&user)
	// 	if err != nil {
	// 		log.Println(err)
	// 		c.JSON(400, gin.H{
	// 			"error": err.Error(),
	// 		})
	// 		return
	// 	}
	// 	client := postgres.DBClient{}
	// 	client.Connect()
	// 	err = client.Insert(&user)
	// 	if err != nil {
	// 		c.JSON(400, gin.H{
	// 			"error": err.Error(),
	// 		})
	// 		return
	// 	}
	// 	c.JSON(200, gin.H{
	// 		"message": "Create data ok",
	// 	})

	// })
	// app.POST("/product/create", func(c *gin.Context) {
	// 	var product postgres.Product
	// 	err := c.ShouldBindJSON(&product)
	// 	if err != nil {
	// 		log.Println(err)
	// 		c.JSON(400, gin.H{
	// 			"error": err.Error(),
	// 		})
	// 		return
	// 	}
	// 	client := postgres.DBClient{}
	// 	client.Connect()
	// 	err = client.Insert(&product)
	// 	if err != nil {
	// 		c.JSON(400, gin.H{
	// 			"error": err.Error(),
	// 		})
	// 		return
	// 	}
	// 	c.JSON(200, gin.H{
	// 		"message": "Create data ok",
	// 	})
	// })
	// app.POST("user/login", func(c *gin.Context) {
	// 	var user postgres.User
	// 	err := c.ShouldBind(&user)
	// 	if err != nil {
	// 		log.Println(err)
	// 		c.JSON(400, gin.H{
	// 			"error": err.Error(),
	// 		})
	// 		return
	// 	}
	// 	client := DBConn()
	// 	IsFind, err2 := client.Find(user)
	// 	if err2 != nil {
	// 		log.Println(err)
	// 		c.JSON(400, gin.H{
	// 			"error": err.Error(),
	// 		})
	// 		return
	// 	}
	// 	if IsFind {
	// 		s, err := jwt.GenerateJWT(user.Name)
	// 		if err != nil {
	// 			fmt.Println("generate jwt failed, ", err)
	// 			os.Exit(1)
	// 		}
	// 		fmt.Printf("GenereateJWT:%s\n", s)

	// 		// claim, err := jwt.ParseJwt(s, secretKey)
	// 		// if err != nil {
	// 		// 	fmt.Printf("parse fail")
	// 		// 	os.Exit(1)
	// 		// }
	// 		// fmt.Printf("ParseJWT:%v\n", claim)
	// 		token := s
	// 		// c.SetCookie("site token", token, 3600, "/", "localhost", false, true)
	// 		c.JSON(http.StatusOK, gin.H{
	// 			"code": 0,
	// 			"msg":  "Success",
	// 			"data": gin.H{"token": token},
	// 		})
	// 		c.Redirect(http.StatusSeeOther, "/")
	// 	} else {
	// 		c.JSON(400, gin.H{
	// 			"message": "login fail, user/ password error",
	// 		})
	// 		// c.Redirect(http.StatusSeeOther, "/login")
	// 	}
	// 	// 	c.JSON(200, gin.H{
	// 	// 		"message": "Create data ok",
	// 	// 	})
	// })
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
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")
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
