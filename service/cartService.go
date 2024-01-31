package service

import (
	"GO_test/pojo"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
)

// type ProductResponse struct {
// 	Product       pojo.Product        `json:"product"`
// 	ProductDetial pojo.Productdetails `json:"productDetail"`
// }

// get
// func FindAllProducts(c *gin.Context) {
// 	// c.JSON(http.StatusOK, productList)
// 	products := pojo.FindAllProducts()
// 	c.JSON(http.StatusOK, products)
// 	return
// }

// post
func PostCart(c *gin.Context) {
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
		return
	}
	// productList = append(productList, product)
	c.JSON(http.StatusNotAcceptable, "Product CreateFail")
}

// // delete
// func DeleteProduct(c *gin.Context) {
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
