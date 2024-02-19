package service

import (
	"GO_test/pojo"
	"fmt"
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
func FindFavoriteByUserID(c *gin.Context) {
	id, _ := strconv.Atoi(c.Param("id"))
	product := pojo.FavoriteListFindByUserID(id)
	// if product.Id == 0 {
	// 	c.JSON(http.StatusNotFound, "Error")
	// 	return
	// }
	// log.Println("Product-> ", product)
	c.JSON(http.StatusOK, product)
}

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
	favorite := pojo.UserFavorite{}
	userid, _ := strconv.Atoi(c.PostForm("userid"))
	favoriteId, _ := strconv.Atoi(c.PostForm("addproductid"))
	//查看是否有對應userid下的list
	fList := pojo.FavoriteListFindByUserID(userid)
	for _, item := range fList {
		//確認選取item 是否已存在
		if item.Favoriteproductid == favoriteId {
			//存在的情況
			fmt.Println("Item already exists")
			return
		}
	}
	//如不存在則新增
	favorite.Userid = userid
	// favoriteProductIDs := favoriteId
	// templist := append(favorite.Favoriteproductid, favoriteId)
	// uniqueIDs := unique(templist)
	// favorite.Favoriteproductid = uniqueIDs
	favorite.Favoriteproductid = favoriteId
	result := pojo.AddFavoriteByUserId(favorite)
	if result == true {
		c.JSON(http.StatusOK, "Success")
		return
	}
	c.JSON(http.StatusNotAcceptable, "Product CreateFail")
}

// delete
func DeleteFavorit(c *gin.Context) {
	userid, _ := strconv.Atoi(c.PostForm("userid"))
	favoid, _ := strconv.Atoi(c.PostForm("favoid"))
	product := pojo.DeleteFavoriteByUseridAndUid(userid, favoid)
	if product == false {
		c.JSON(http.StatusNotFound, "Error")
		return
	}
	c.JSON(http.StatusOK, "success")
}

// // put
//
//	func PutProduct(c *gin.Context) {
//		bProduct := pojo.Product{}
//		err := c.BindJSON(&bProduct)
//		if err != nil {
//			c.JSON(http.StatusBadRequest, "Error")
//		}
//		productId, _ := strconv.Atoi(c.Param("Id"))
//		product := pojo.UpdateProduct(productId, bProduct)
//		if product.Id == 0 {
//			c.JSON(http.StatusNotFound, "Error")
//			return
//		}
//		c.JSON(http.StatusOK, product)
//	}
func unique(intSlice []int) []int {
	keys := make(map[int]bool)
	list := []int{} // 创建一个新的切片用于存储唯一元素
	for _, entry := range intSlice {
		if _, value := keys[entry]; !value {
			keys[entry] = true
			list = append(list, entry) // 只有当 entry 在 keys 中不存在时才添加到 list
		}
	}
	return list
}
