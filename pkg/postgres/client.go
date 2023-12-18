package postgres

import (
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

func (m *DBClient) Insert(user User) error {
	res := m.client.Create(user)
	if res.Error != nil {
		return res.Error
	}
	fmt.Printf("Insert Success!")
	return nil
}

func (m *DBClient) Get() ([]Player, error) {
	players := []Player{}
	res := m.client.Order("ID").Find(&players)
	if res.Error != nil {
		return nil, res.Error
	}
	return players, nil
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
