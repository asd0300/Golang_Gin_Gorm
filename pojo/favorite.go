package pojo

import (
	. "GO_test/database"
	"fmt"

	"gorm.io/gorm"
)

type UserFavorite struct {
	Userid            int `json:"userid" gorm:"primaryKey"`
	Favoriteproductid int `json:"favoriteproductid" gorm:"type:integer"`
}

func (UserFavorite) TableName() string {
	return "userFavorite"
}

// func FindAllUsers() []User {
// 	var users []User
// 	DBClient.Find(&users)
// 	return users
// }

func FavoriteListFindByUserID(userid int) []UserFavorite {
	var userfavorite []UserFavorite
	result := DBClient.Where("userid = ?", userid).Find(&userfavorite)
	if result.Error != nil {
		if result.Error == gorm.ErrRecordNotFound {
			fmt.Println("No records found")
			return []UserFavorite{}
		} else {
			panic("Failed to find user favorites: " + result.Error.Error())
		}
	}
	fmt.Printf("Found %v records\n", result.RowsAffected)
	return userfavorite
}

func AddFavoriteByUserId(userfavorite UserFavorite) bool {
	result := DBClient.Create(&userfavorite)
	if result.Error != nil {
		return false
	}
	return true
}

// func CreateUser(user User) User {
// 	DBClient.Create(&user)
// 	return user
// }

func DeleteFavoriteByUseridAndUid(userId int, productId int) bool {
	var userfavorite = UserFavorite{}
	result := DBClient.Where("userid = ? AND favoriteproductid=?", userId, productId).Delete(&userfavorite)
	if result.RowsAffected == 0 {
		return false
	}
	return true
}

// func UpdateProduct(productId int, product Product) Product {
// 	DBClient.Model(&product).Where("Id=?", productId).Updates(product)
// 	return product
// }
