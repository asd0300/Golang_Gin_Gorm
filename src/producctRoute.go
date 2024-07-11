package src

import (
	// . "GO_test/middle/Redis"
	"GO_test/middle/jwt"
	"GO_test/service"

	"github.com/gin-gonic/gin"
)

func AddProductRoute(r *gin.RouterGroup) {
	product := r.Group("/products")
	// product.GET("/", RedisMiddleware(database.GetRedisHelper().Client), service.FindAllProducts)
	product.GET("/", service.FindAllProducts)
	product.GET("/search/:title", service.FindByProductTitle)
	product.POST("/search", service.FindByProductTitle)
	product.GET("/:id", service.FindByProductID)
	product.Use(jwt.JWTAuthMiddleware())
	product.POST("/", service.PostProduct)
	product.DELETE("/:id", service.DeleteProduct)
	product.PUT("/:id", service.PutProduct)
}
