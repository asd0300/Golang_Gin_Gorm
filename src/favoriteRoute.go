package src

import (
	"GO_test/middle/jwt"
	"GO_test/service"

	"github.com/gin-gonic/gin"
)

func AddFavoriteRoute(r *gin.RouterGroup) {
	favorite := r.Group("/favorite")
	favorite.Use(jwt.JWTAuthMiddleware())
	favorite.POST("/", service.PostFavorite)
	favorite.GET("/:id", service.FindFavoriteByUserID)
	favorite.POST("/delete", service.DeleteFavorit)
	// favorite.PUT("/:id", service.PutProduct)
}
