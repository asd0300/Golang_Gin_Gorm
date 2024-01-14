package src

import (
	"GO_test/service"

	"github.com/gin-gonic/gin"
)

func staticRoute(r *gin.RouterGroup) {
	reginster := r.Group("/user")
	reginster.POST("/register", service.PostRegisterUser)
	reginster.POST("/login", service.PostLoginUser)
	// reginster.POST("/login", service.)

}
