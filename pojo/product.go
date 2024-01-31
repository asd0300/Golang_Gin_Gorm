package pojo

import (
	. "GO_test/database"
	"time"
)

type Product struct {
	Id         int       `json:"id" gorm:"primaryKey"`
	Title      string    `json:"title"`
	Price      int       `json:"price"`
	Newprice   int       `json:"newprice"`
	Titlepic   string    `json:"titlepic"`
	Otherpic   string    `json:"otherpic"`
	CreateDate time.Time `json:"createdate" gorm:"column:createDate"`
}
type Productdetails struct {
	Id      int    `json:"id" gorm:"primaryKey"`
	Option  string `json:"option"`
	Feature string `json:"feature"`
	Content string `json:"content"`
	Spec    string `json:"spec"`
}

func FindAllProducts() []Product {
	var products []Product
	DBClient.Find(&products)
	return products
}

func FindByProductID(productId int) Product {
	var product Product
	DBClient.Where("Id = ?", productId).First(&product)
	return product
}

func FindByProductDetialID(productId int) Productdetails {
	var productDetail Productdetails
	DBClient.Where("Id = ?", productId).First(&productDetail)
	return productDetail
}

func FindByProductTitle(productTitle string) []Product {
	var product []Product
	if productTitle == "*" || productTitle == "" {
		product = FindAllProducts()
		return product
	}
	DBClient.Where("Title LIKE ?", "%"+productTitle+"%").Find(&product)
	return product
}

func CreateProduct(product Product) error {
	result := DBClient.Create(&product)
	return result.Error
}

func DeleteProduct(productId int) bool {
	var product = Product{}
	result := DBClient.Where("Id = ?", productId).Delete(&product)
	if result.RowsAffected == 0 {
		return false
	}
	return true
}

func UpdateProduct(productId int, product Product) Product {
	DBClient.Model(&product).Where("Id=?", productId).Updates(product)
	return product
}
