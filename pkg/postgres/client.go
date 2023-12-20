package postgres

import (
	"errors"
	"fmt"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type DBClient struct {
	client *gorm.DB
}

func (m *DBClient) Connect() {
	config := getDbConfig()
	dsn := fmt.Sprintf(
		`host=%s
 user=%s 
 password=%s 
 dbname=%s 
 port=%d 
 sslmode=disable 
 TimeZone=Asia/Taipei`,
		config.Addr,
		config.Username,
		config.Password,
		config.DBname,
		config.Port)
	client, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		panic(err)
	}
	m.client = client
	fmt.Println("Connect success")
}

type Entity interface {
	SetIdentity()
}

func (m *DBClient) Insert(entity Entity) error {
	entity.SetIdentity()
	res := m.client.Create(entity)
	if res.Error != nil {
		return res.Error
	}
	fmt.Printf("Insert Success!\n")
	return nil
}

func (u *User) SetIdentity() {
	if u.Name == "ben" {
		u.Identity = 1
	} else {
		u.Identity = 2
	}
}
func (u *Product) SetIdentity() {

}

func (m *DBClient) Get() ([]Player, error) {
	players := []Player{}
	res := m.client.Order("ID").Find(&players)
	if res.Error != nil {
		return nil, res.Error
	}
	return players, nil
}
func (m *DBClient) Find(user User) (bool, error) {
	res := m.client.Where("name=? AND password=?", user.Name, user.Password).First(&user)
	if res.Error != nil {
		if errors.Is(res.Error, gorm.ErrRecordNotFound) {
			return false, nil
		}
		// Other error occurred
		return false, res.Error
	}
	return true, nil
}

func (m *DBClient) Update(play Player) error {
	res := m.client.Save(&play)
	if res.Error != nil {
		return res.Error
	}
	fmt.Println("update success")
	return nil
}

func (m *DBClient) Delete(play Player) error {
	res := m.client.Delete(&play)
	if res.Error != nil {
		return res.Error
	}
	fmt.Println("Remove success")
	return nil
}
