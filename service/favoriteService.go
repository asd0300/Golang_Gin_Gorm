package service

import (
	"GO_test/pojo"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// get
// func FindAllProducts(c *gin.Context) {
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

// // get by title
// func FindByProductTitle(c *gin.Context) {
// 	title := c.Param("title")
// 	product := pojo.FindByProductTitle(title)
// 	// if product.Id == 0 {
// 	// 	c.JSON(http.StatusNotFound, "Error")
// 	// 	return
// 	// }
// 	c.JSON(http.StatusOK, product)
// 	return
// }

// post
func PostFavorite(c *gin.Context) {
	favorite := pojo.Favorite{}
	userid := c.PostForm("userId")
	favoriteId := c.PostForm("favoriteId")
	userIdInt, _ := strconv.Atoi(userid)
	favoritedIdInt, _ := strconv.Atoi(favoriteId)
	favorite.UserId = userIdInt
	favorite.FavoriteProductID = append(favorite.FavoriteProductID, favoritedIdInt)
	result := pojo.AddFavoriteByUserId(favorite)
	if result == true {
		c.JSON(http.StatusOK, "Success")
		return
	}
	c.JSON(http.StatusNotAcceptable, "Product CreateFail")
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
