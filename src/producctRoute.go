package src

import (
	"GO_test/service"

	"github.com/gin-gonic/gin"
)

func AddProductRoute(r *gin.RouterGroup) {
	product := r.Group("/products")

	product.GET("/", service.FindAllProducts)
	product.GET("/:id", service.FindByProductID)
	product.POST("/", service.PostProduct)
	product.DELETE("/:id", service.DeleteProduct)
	product.PUT("/:id", service.PutProduct)
}
