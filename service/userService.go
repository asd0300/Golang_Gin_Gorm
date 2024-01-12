package service

import (
	"GO_test/middle/jwt"
	"GO_test/pojo"
	"crypto/sha1"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

// get
// func FindAllProducts(c *gin.Context) {
// 	// c.JSON(http.StatusOK, productList)
// 	products := pojo.FindAllProducts()
// 	c.JSON(http.StatusOK, products)
// 	return
// }

// // get by id
// func FindByProductID(c *gin.Context) {
// 	id, _ := strconv.Atoi(c.Param("id"))
// 	product := pojo.FindByProductID(id)
// 	if product.Id == 0 {
// 		c.JSON(http.StatusNotFound, "Error")
// 		return
// 	}
// 	log.Println("Product-> ", product)
// 	c.JSON(http.StatusOK, product)
// }

// post
func PostRegisterUser(c *gin.Context) {
	user := pojo.User{}
	err := c.ShouldBindJSON(&user)
	if err != nil {
		return
	}
	user.Password = sha1It(user.Password)
	pojo.CreateUser(user)
	c.JSON(http.StatusOK, "success")
}

// post login
func PostLoginUser(c *gin.Context) {
	user := pojo.User{}
	err := c.ShouldBindJSON(&user)
	if err != nil {
		return
	}
	user.Password = sha1It(user.Password)
	result := pojo.FindByUserEmail(user)
	if result {
		loginJWT, _ := jwt.GenerateJWT(user.Email)
		c.JSON(http.StatusOK, gin.H{"jwt": loginJWT})
		return
	}
	c.JSON(http.StatusNotFound, "Login failed")

}

// Encrypt
const EncryptCode = "it"

// sha
func sha1It(password string) string {
	h := sha1.New()
	h.Write([]byte(password))
	bs := h.Sum([]byte(EncryptCode))
	encryptCode := fmt.Sprintf("%x", bs)
	return encryptCode
}

// // delete
// func DeleteProduct(c *gin.Context) {
// 	// productId, _ := strconv.Atoi(c.Param("Id"))
// 	// for _, product := range productList {
// 	// 	log.Println(product)
// 	// 	if product.Id == productId {
// 	// 		productList = append(productList[:productId], productList[productId+1:]...)
// 	// 		c.JSON(http.StatusOK, "Successfully delete")
// 	// 		return
// 	// 	}
// 	// }
// 	// c.JSON(http.StatusNotFound, "Error")
// 	testId, _ := strconv.Atoi(c.Param("id"))
// 	product := pojo.DeleteProduct(testId)
// 	if product == false {
// 		c.JSON(http.StatusNotFound, "Error")
// 		return
// 	}
// 	c.JSON(http.StatusOK, "success")
// }

// // put
// func PutProduct(c *gin.Context) {
// 	bProduct := pojo.Product{}
// 	err := c.BindJSON(&bProduct)
// 	if err != nil {
// 		c.JSON(http.StatusBadRequest, "Error")
// 	}
// 	productId, _ := strconv.Atoi(c.Param("Id"))
// 	product := pojo.UpdateProduct(productId, bProduct)
// 	if product.Id == 0 {
// 		c.JSON(http.StatusNotFound, "Error")
// 		return
// 	}
// 	c.JSON(http.StatusOK, product)
// }
