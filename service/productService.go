package service

import (
	"GO_test/pojo"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

var productList = []pojo.Product{}

// get
func FindAllProducts(c *gin.Context) {
	c.JSON(http.StatusOK, productList)
	return
}

// post
func PostProduct(c *gin.Context) {
	product := pojo.Product{}
	err := c.BindJSON(&product)
	if err != nil {
		c.JSON(http.StatusNotAcceptable, "Error: "+err.Error())
		return
	}
	productList = append(productList, product)
	c.JSON(http.StatusOK, "Successfully posted!")
}

// delete
func DeleteProduct(c *gin.Context) {
	productId, _ := strconv.Atoi(c.Param("Id"))
	for _, product := range productList {
		log.Println(product)
		if product.Id == productId {
			productList = append(productList[:productId], productList[productId+1:]...)
			c.JSON(http.StatusOK, "Successfully delete")
			return
		}
	}
	c.JSON(http.StatusNotFound, "Error")
}

// put
func PutProduct(c *gin.Context) {
	bProduct := pojo.Product{}
	err := c.BindJSON(&bProduct)
	if err != nil {
		c.JSON(http.StatusBadRequest, "Error")
	}
	productId, _ := strconv.Atoi(c.Param("Id"))
	for key, proc := range productList {
		if proc.Id == productId {
			productList[key] = bProduct
			log.Println(productList[key])
			c.JSON(http.StatusOK, "success")
			return
		}
	}
	c.JSON(http.StatusNotFound, "Error")
}
