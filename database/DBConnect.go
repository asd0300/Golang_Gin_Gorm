package database

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// type DBClient struct {
// 	client *gorm.DB
// }

var DBClient *gorm.DB
var err error

func Connect() {
	config := GetDbConfig()
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
	DBClient, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		panic(err)
	}
	fmt.Println("Connect success")
}

func GetDbConfig() *dbConfig {
	config := dbConfig{}
	cur, _ := os.Getwd()
	file := "/config/postgres/config.json"
	final := filepath.Join(cur, file)
	data, err := os.ReadFile(final)
	err = json.Unmarshal(data, &config)
	if err != nil {
		panic(err)
	}
	return &config
}

type dbConfig struct {
	DBname   string
	Addr     string
	Port     int
	Username string
	Name     string
	Password string
}
