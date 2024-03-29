package src

import (
	"GO_test/middle/jwt"
	"GO_test/service"

	"github.com/gin-gonic/gin"
)

func AddUserRoute(r *gin.RouterGroup) {
	// product := r.Group("/products")

	// product.GET("/", service.FindAllProducts)
	// product.GET("/:id", service.FindByProductID)
	// product.POST("/", service.PostProduct)
	// product.DELETE("/:id", service.DeleteProduct)
	// product.PUT("/:id", service.PutProduct)

	reginster := r.Group("/user")
	reginster.POST("/login", service.PostLoginUser)
	reginster.POST("/register", service.PostRegisterUser)
	reginster.Use(jwt.JWTAuthMiddleware())
	// reginster.POST("/login", service.)

}
