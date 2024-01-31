package pojo

import (
	. "GO_test/database"
)

type Favorite struct {
	UserId            int   `json:"userid" gorm:"primaryKey"`
	FavoriteProductID []int `json:"favoriteproductid"`
}

// func FindAllUsers() []User {
// 	var users []User
// 	DBClient.Find(&users)
// 	return users
// }

// func FindByProductID(productId int) Product {
// 	var product Product
// 	DBClient.Where("Id = ?", productId).First(&product)
// 	return product
// }

func AddFavoriteByUserId(userfavorite Favorite) bool {
	result := DBClient.Where(userfavorite.UserId).FirstOrCreate(&userfavorite)
	if result.Error != nil {
		return false
	}
	return true
}

// func CreateUser(user User) User {
// 	DBClient.Create(&user)
// 	return user
// }

// func DeleteProduct(productId int) bool {
// 	var product = Product{}
// 	result := DBClient.Where("Id = ?", productId).Delete(&product)
// 	if result.RowsAffected == 0 {
// 		return false
// 	}
// 	return true
// }

// func UpdateProduct(productId int, product Product) Product {
// 	DBClient.Model(&product).Where("Id=?", productId).Updates(product)
// 	return product
// }
