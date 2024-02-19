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

type ProductResponse struct {
	Product       pojo.Product        `json:"product"`
	ProductDetial pojo.Productdetails `json:"productDetail"`
}

// post create project/ projectDetail
func CreateProducts(c *gin.Context) {

}

// get
func FindAllProducts(c *gin.Context) {
	// c.JSON(http.StatusOK, productList)
	products := pojo.FindAllProducts()
	c.JSON(http.StatusOK, products)
	return
}

func FindByProductID(c *gin.Context) {
	id, _ := strconv.Atoi(c.Param("id"))
	product := pojo.FindByProductID(id)
	productDetail := pojo.FindByProductDetialID(id)
	if product.Id == 0 {
		c.JSON(http.StatusNotFound, "Error can't find Product")
		return
	}
	if productDetail.Id == 0 {
		c.JSON(http.StatusNotFound, "Error can't find ProductDetail")
		return
	}
	log.Println("Product-> ", product)

	c.JSON(http.StatusOK, ProductResponse{Product: product, ProductDetial: productDetail})
}

// get by title
func FindByProductTitle(c *gin.Context) {
	title := c.PostForm("title")
	filter := c.PostForm("filter")
	product := pojo.FindByProductTitle(title, filter)
	// if product.Id == 0 {
	// 	c.JSON(http.StatusNotFound, "Error")
	// 	return
	// }
	c.JSON(http.StatusOK, product)
	return
}

// post
func PostProduct(c *gin.Context) {
	product := pojo.Product{}
	productdetail := pojo.Productdetails{}
	title := c.PostForm("title")
	price, _ := strconv.Atoi(c.PostForm("price"))
	newprice, _ := strconv.Atoi(c.PostForm("newprice"))
	titlepic := c.PostForm("titlepic")
	otherpic := c.PostForm("otherpic")

	product.Title = title
	product.Price = price
	product.Newprice = newprice
	product.Titlepic = titlepic
	product.Otherpic = otherpic
	product.CreateDate = time.Now()

	option := c.PostForm("option")
	feature := c.PostForm("feature")
	content := c.PostForm("content")
	spec := c.PostForm("spec")
	productdetail.Option = option
	productdetail.Feature = feature
	productdetail.Content = content
	productdetail.Spec = spec

	err, productId := pojo.CreateProduct(product)
	//使用create後的 id
	if err == nil {
		productdetail.Id = productId
	}
	err2 := pojo.CreateProductDetail(productdetail)
	if err == nil && err2 == nil {
		c.JSON(http.StatusOK, "Success")
		return
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
