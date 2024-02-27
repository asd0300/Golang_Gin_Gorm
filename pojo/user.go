package pojo

import (
	. "GO_test/database"
)

type User struct {
	Id       int    `json:"id" gorm:"primaryKey"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

func FindAllUsers() []User {
	var users []User
	DBClient.Find(&users)
	return users
}

// func FindByProductID(productId int) Product {
// 	var product Product
// 	DBClient.Where("Id = ?", productId).First(&product)
// 	return product
// }

func FindByUserEmail(inputUser User) *User {
	var user User
	result := DBClient.Where("email = ? AND  password = ?", inputUser.Email, inputUser.Password).First(&user)
	if result.Error != nil {
		return nil
	}
	user.Password = ""
	return &user
}

func CreateUser(user User) (User, error) {
	result := DBClient.Create(&user)
	if result.Error != nil {
		return User{}, result.Error
	}
	return user, nil
}

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
