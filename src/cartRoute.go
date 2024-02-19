package src

import (
	"GO_test/middle/jwt"
	"GO_test/service"

	"github.com/gin-gonic/gin"
)

func AddCartRoute(r *gin.RouterGroup) {
	cart := r.Group("/carts")
	cart.Use(jwt.JWTAuthMiddleware())
	cart.GET("/:userid", service.FindAllCartItemByUID)
	cart.POST("/", service.PostCart)
	cart.POST("/create-payment-intent", service.CreateIntent)
	cart.POST("/delete", service.DeleteCart)
	// product.PUT("/:id", service.PutProduct)
}
