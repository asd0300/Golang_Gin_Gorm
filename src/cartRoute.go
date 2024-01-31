package src

import (
	"GO_test/middle/jwt"
	"GO_test/service"

	"github.com/gin-gonic/gin"
)

func AddCartRoute(r *gin.RouterGroup) {
	product := r.Group("/carts")
	product.Use(jwt.JWTAuthMiddleware())
	// product.GET("/:id", service.FindByProductID)
	product.POST("/", service.PostCart)
	// product.DELETE("/:id", service.DeleteProduct)
	// product.PUT("/:id", service.PutProduct)
}
