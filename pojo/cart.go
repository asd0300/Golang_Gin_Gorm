package pojo

import (
	. "GO_test/database"
	"time"
)

type Cart struct {
	Userid     int       `json:"userid"`
	Productid  int       `json:"productid"`
	Numberbuy  int       `json:"numberbuy"`
	Spec       string    `json:"spec"`
	Createtime time.Time `json:"createtime"`
	Cartid     int       `json:"cartid"`
	Ispay      bool      `json:"ispay"`
}

type ResultCart struct {
	Cart
	Product
}

// func FindAllProducts() []Product {
// 	var products []Product
// 	DBClient.Find(&products)
// 	return products
// }

// func FindByProductID(productId int) Product {
// 	var product Product
// 	DBClient.Where("Id = ?", productId).First(&product)
// 	return product
// }

func FindByUserId(userid int) []ResultCart {
	var resultcart []ResultCart
	DBClient.Table("carts").Select("carts.*,products.newprice,products.price, products.title, products.titlepic").
		Joins("join products on  carts.productid = products.id").Where("carts.userid = ?", userid).Scan(&resultcart)
	return resultcart
}

// func FindByProductTitle(productTitle string) []Product {
// 	var product []Product
// 	if productTitle == "*" || productTitle == "" {
// 		product = FindAllProducts()
// 		return product
// 	}
// 	DBClient.Where("Title LIKE ?", "%"+productTitle+"%").Find(&product)
// 	return product
// }

func CreateCart(cart Cart) error {
	result := DBClient.Select("Userid", "Productid", "Numberbuy", "Spec", "Createtime", "Ispay").Create(&cart)
	return result.Error
}

func DeleteCart(userid int, cartid int) bool {
	var cart = Cart{}
	result := DBClient.Where("userid = ? AND cartid = ?", userid, cartid).Delete(&cart)
	if result.RowsAffected == 0 {
		return false
	}
	return true
}

// func UpdateProduct(productId int, product Product) Product {
// 	DBClient.Model(&product).Where("Id=?", productId).Updates(product)
// 	return product
// }
