package main

// import "fmt"

// const (
// 	WHITE = iota
// 	BLACK
// 	BLUE
// 	RED
// 	YELLOW
// )

// type Color byte
// type Box struct {
// 	width  float64
// 	height float64
// 	depth  float64
// 	color  Color
// }
// type BoxList []Box

// func (b Box) Volumn() float64 {
// 	return b.depth * b.width * b.height
// }

// func (bi BoxList) BiggestColor() Color {
// 	cur := 0.00
// 	var curColor Color
// 	for _, v := range bi {
// 		bv := v.Volumn()
// 		if bv > cur {
// 			cur = bv
// 			curColor = v.color
// 		}
// 	}
// 	return curColor
// }

// func (b *Box) SetColor(c Color) {
// 	b.color = c
// }

// func (bl BoxList) PaintAllBlack() {
// 	for i := range bl {
// 		bl[i].SetColor(BLACK)
// 	}
// }
// func (c Color) String() string {
// 	strings := []string{"WHITE", "BLACK", "BLUE", "RED", "YELLOW"}
// 	return strings[c]
// }
// func main() {
// 	boxes := BoxList{
// 		Box{4, 4, 4, RED},
// 		Box{10, 10, 1, YELLOW},
// 		Box{1, 1, 20, BLACK},
// 		Box{10, 10, 1, BLUE},
// 		Box{10, 30, 1, WHITE},
// 		Box{20, 20, 20, YELLOW},
// 	}

// 	fmt.Printf("we have %d boxes\n", len(boxes))
// 	fmt.Printf("we also have 6 boxes")
// }

import (
	postgres "GO_test/pkg/postgres"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

// func main() {
// 	r := gin.Default()
// 	r.GET("/", func(c *gin.Context) {
// 		c.JSON(200, gin.H{
// 			"message": "Welcom to your frist GIN Web!!!",
// 		})
// 	})
// 		r.Run() // listen and serve on 0.0.0.0:8080
// 	}

func main() {
	app := gin.Default()
	app.GET("/user", func(c *gin.Context) {
		c.String(200, "/user")
	})
	app.GET("hello/:name", func(c *gin.Context) {
		fmt.Println(c.FullPath())
		name := c.Param("name")
		c.JSON(200, gin.H{
			"message": "hello " + name,
		})
		c.String(http.StatusOK, "\n123")
	})
	app.GET("/go/:name/*action", func(c *gin.Context) {
		name := c.Param("name")
		action := c.Param("action")
		message := name + " is " + action
		c.String(http.StatusOK, message)
	})
	app.POST("/user/create", func(c *gin.Context) {
		var user postgres.User
		err := c.ShouldBind(&user)
		if err != nil {
			log.Println(err)
			c.JSON(400, gin.H{
				"error": err.Error(),
			})
			return
		}
		client := postgres.DBClient{}
		client.Connect()
		err = client.Insert(user)
		if err != nil {
			c.JSON(400, gin.H{
				"error": err.Error(),
			})
			return
		}
		c.JSON(200, gin.H{
			"message": "Create data ok",
		})

	})
	app.POST("user/login", func(c *gin.Context) {
		var user postgres.User
		err := c.ShouldBind(&user)
		if err != nil {
			log.Println(err)
			c.JSON(400, gin.H{
				"error": err.Error(),
			})
			return
		}

	})
	err := app.Run(":3000")
	if err != nil {
		panic(err)
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

func Read() {
	var client = DBConn()
}
func DBConn() postgres.DBClient {
	client := postgres.DBClient{}
	client.Connect()
	return client
}
