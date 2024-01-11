package service

import (
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
	// product := pojo.Product{}
	// title := c.PostForm("title")
	// price, _ := strconv.Atoi(c.PostForm("price"))
	// newprice, _ := strconv.Atoi(c.PostForm("newprice"))
	// println("title:", title)
	// product.Title = title
	// product.Price = price
	// product.Newprice = newprice
	// newProduct := pojo.CreateProduct(product)
	// // productList = append(productList, product)
	user := pojo.User{}
	form, err := c.MultipartForm()
	fmt.Printf("%+v, %+v\n", form, err)
	user.Email = c.PostForm("email")
	user.Password = sha1It(c.PostForm("password"))
	newUser := pojo.CreateUser(user)
	c.JSON(http.StatusOK, newUser)
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
