package src

import (
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
	reginster.POST("/register", service.PostRegisterUser)
	reginster.POST("/login", service.PostLoginUser)
	// reginster.POST("/login", service.)

}
