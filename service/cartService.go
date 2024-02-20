package service

import (
	"GO_test/pojo"
	"net/http"
	"os"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/stripe/stripe-go/v72"
	"github.com/stripe/stripe-go/v72/paymentintent"
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

// get
func FindAllCartItemByUID(c *gin.Context) {
	userId, _ := strconv.Atoi(c.Param("userid"))
	cartItems := pojo.FindByUserId(userId)
	c.JSON(http.StatusOK, cartItems)
	return
}

// post
func PostCart(c *gin.Context) {
	cart := pojo.Cart{}
	userid, _ := strconv.Atoi(c.PostForm("userid"))
	productid, _ := strconv.Atoi(c.PostForm("productid"))
	numberbuy, _ := strconv.Atoi(c.PostForm("numberbuy"))
	spec := c.PostForm("spec")

	cart.Userid = userid
	cart.Productid = productid
	cart.Numberbuy = numberbuy
	cart.Spec = spec
	cart.Createtime = time.Now()

	// err := c.BindJSON(&product)
	// if err != nil {
	// 	c.JSON(http.StatusNotAcceptable, "Error: "+err.Error())
	// 	return
	// }
	err := pojo.CreateCart(cart)
	if err == nil {
		c.JSON(http.StatusOK, "Success")
		return
	}
	// productList = append(productList, product)
	c.JSON(http.StatusNotAcceptable, "Cart CreateFail")
}

// post CreateIntent
func CreateIntent(c *gin.Context) {
	stripe.Key = os.Getenv("StripeSK")
	var request struct {
		Amount int64 `json:"amount"`
	}
	if err := c.BindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	params := &stripe.PaymentIntentParams{
		Amount:   stripe.Int64(request.Amount * 100),
		Currency: stripe.String(string(stripe.CurrencyTWD)),
	}
	//創造付款意圖
	pi, err := paymentintent.New(params)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"clientSecret": pi.ClientSecret})
}

// delete
func DeleteCart(c *gin.Context) {
	userid, _ := strconv.Atoi(c.PostForm("userid"))
	cartid, _ := strconv.Atoi(c.PostForm("cartid"))
	result := pojo.DeleteCart(userid, cartid)
	if result == false {
		c.JSON(http.StatusNotFound, "Error")
		return
	}
	c.JSON(http.StatusOK, "success")
}

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
