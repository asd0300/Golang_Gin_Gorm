package pojo

import (
	. "GO_test/database"
)

type Product struct {
	Id            int           `json:"id" gorm:"primaryKey"`
	Title         string        `json:"title"`
	Price         int           `json:"price"`
	Newprice      int           `json:"newprice"`
	Productdetail Productdetail `json:"productdetail" gorm:"foreignKey:Id;references:Id" gorm:"delete:CASCADE"`
}
type Productdetail struct {
	Id       int    `json:"id" gorm:"primaryKey"`
	Titlepic string `json:"titlepic"`
	Otherpic string `json:"otherpic"`
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

func CreateProduct(product Product) Product {
	DBClient.Create(&product.Productdetail)
	DBClient.Create(&product)
	return product
}

func DeleteProduct(productId int) Product {
	productdetail := Productdetail{}
	product := Product{}
	DBClient.Where("Id = ?", productId).Delete(&productdetail)
	DBClient.Where("Id = ?", productId).Delete(&product)
	return product
}

func UpdateProduct(productId int, product Product) Product {
	DBClient.Model(&product).Where("Id=?", productId).Updates(product)
	return product
}
