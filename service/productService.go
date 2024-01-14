package service

import (
	"GO_test/pojo"
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
)

var productList = []pojo.Product{}

// get
func FindAllProducts(c *gin.Context) {
	// c.JSON(http.StatusOK, productList)
	products := pojo.FindAllProducts()
	c.JSON(http.StatusOK, products)
	return
}

// get by id
func FindByProductID(c *gin.Context) {
	id, _ := strconv.Atoi(c.Param("id"))
	product := pojo.FindByProductID(id)
	if product.Id == 0 {
		c.JSON(http.StatusNotFound, "Error")
		return
	}
	log.Println("Product-> ", product)
	c.JSON(http.StatusOK, product)
}

// post
func PostProduct(c *gin.Context) {
	product := pojo.Product{}
	title := c.PostForm("title")
	price, _ := strconv.Atoi(c.PostForm("price"))
	newprice, _ := strconv.Atoi(c.PostForm("newprice"))
	titlepic := c.PostForm("titlePic")

	product.Title = title
	product.Price = price
	product.Newprice = newprice
	product.Titlepic = titlepic
	product.CreateDate = time.Now()

	// err := c.BindJSON(&product)
	// if err != nil {
	// 	c.JSON(http.StatusNotAcceptable, "Error: "+err.Error())
	// 	return
	// }
	err := pojo.CreateProduct(product)
	if err == nil {
		c.JSON(http.StatusOK, "Success")
	}
	// productList = append(productList, product)
	c.JSON(http.StatusNotAcceptable, "Product CreateFail")
}

// delete
func DeleteProduct(c *gin.Context) {
	// productId, _ := strconv.Atoi(c.Param("Id"))
	// for _, product := range productList {
	// 	log.Println(product)
	// 	if product.Id == productId {
	// 		productList = append(productList[:productId], productList[productId+1:]...)
	// 		c.JSON(http.StatusOK, "Successfully delete")
	// 		return
	// 	}
	// }
	// c.JSON(http.StatusNotFound, "Error")
	testId, _ := strconv.Atoi(c.Param("id"))
	product := pojo.DeleteProduct(testId)
	if product == false {
		c.JSON(http.StatusNotFound, "Error")
		return
	}
	c.JSON(http.StatusOK, "success")
}

// put
func PutProduct(c *gin.Context) {
	bProduct := pojo.Product{}
	err := c.BindJSON(&bProduct)
	if err != nil {
		c.JSON(http.StatusBadRequest, "Error")
	}
	productId, _ := strconv.Atoi(c.Param("Id"))
	product := pojo.UpdateProduct(productId, bProduct)
	if product.Id == 0 {
		c.JSON(http.StatusNotFound, "Error")
		return
	}
	c.JSON(http.StatusOK, product)
}
