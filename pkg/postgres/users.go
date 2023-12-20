package postgres

type User struct {
	Name     string `json:"name"`
	Password string `json:"password"`
	Identity int    `json:"identity" gorm:"default:0"`
}
