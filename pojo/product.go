package pojo

import (
	. "GO_test/database"
	"errors"
	"fmt"
	"time"

	"gorm.io/gorm"
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

// FindAllProducts godoc
// @Summary      Show an account
// @Description  get string by ID
// @Id         	 id
// @Title        title
// @Price        int
// @Success      200  {object}  pojo.Product
// @Router       /v1/products/ [get]
func FindAllProducts() []Product {
	var products []Product
	DBClient.Find(&products)
	return products
}

func FindAllAndOrderProducts(filter string) []Product {
	var products []Product
	DBClient.Order(filter + " DESC").Find(&products)
	return products
}

func FindByProductID(productId int) Product {
	var product Product
	DBClient.Where("Id = ?", productId).First(&product)
	return product
}

func FindByProductDetialID(productId int) Productdetails {
	var productDetail Productdetails
	result := DBClient.Where("Id = ?", productId).First(&productDetail)
	if errors.Is(result.Error, gorm.ErrRecordNotFound) {
		fmt.Print("123")
	} else if result.Error != nil {
		fmt.Print("456")
	}

	return productDetail
}

func FindByProductTitle(productTitle string, filter string) []Product {
	var product []Product
	if productTitle == "*" || productTitle == "" {
		product = FindAllAndOrderProducts(filter)
		return product
	}
	DBClient.Order(filter+" DESC").Where("title ILIKE ?", "%"+productTitle+"%").Find(&product)
	return product
}

func CreateProduct(product Product) (error, int) {
	result := DBClient.Create(&product)
	return result.Error, product.Id
}

func CreateProductDetail(projectDetail Productdetails) error {
	result := DBClient.Create(&projectDetail)
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
