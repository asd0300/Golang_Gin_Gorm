package pojo

type Product struct {
	Id            int           `json:"id" gorm:"primaryKey"`
	Title         string        `json:"title"`
	Price         int           `json:"price"`
	Newprice      int           `json:"newprice"`
	Productdetail Productdetail `json:"productdetail" gorm:"foreignKey:Id;references:Id"`
}
type Productdetail struct {
	Id       int    `json:"id" gorm:"primaryKey"`
	Titlepic string `json:"titlepic"`
	Otherpic string `json:"otherpic"`
}
