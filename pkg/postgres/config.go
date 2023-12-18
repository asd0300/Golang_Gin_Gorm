package postgres

import (
	"encoding/json"
	"os"
)

type dbConfig struct {
	DBname   string
	Addr     string
	Port     int
	Username string
	Name     string
	Password string
}

func getDbConfig() *dbConfig {
	config := dbConfig{}
	file := "./config/postgres/config.json"
	data, err := os.ReadFile(file)
	err = json.Unmarshal(data, &config)
	if err != nil {
		panic(err)
	}
	return &config
}
