package main

// import (
// 	"fmt"
// )

// type Human struct {
// 	name  string
// 	age   int
// 	phone string
// }
// type Student struct {
// 	Human
// 	school string
// }
// type Employee struct {
// 	Human
// 	company string
// }

// type Men interface {
// 	SayHi()
// 	Sing(lyrics string)
// 	Guzzle(beerStein string)
// }
// type YoungChap interface {
// 	SayHi()
// 	Sing(song string)
// 	BorrowMoney(amount float32)
// }
// type ElderlyGent interface {
// 	SayHi()
// 	Sing(song string)
// 	SpendSalary(amount float32)
// }

// func (h *Human) SayHi() {
// 	fmt.Printf("Hi, I am %s you can call me on %s\n", h.name, h.phone)
// }

// // Human 物件實現 Sing 方法
// func (h *Human) Sing(lyrics string) {
// 	fmt.Println("La la, la la la, la la la la la...", lyrics)
// }

// // Human 物件實現 Guzzle 方法
// func (h *Human) Guzzle(beerStein string) {
// 	fmt.Println("Guzzle Guzzle Guzzle...", beerStein)
// }
// func (e *Employee) SayHi() {
// 	fmt.Printf("Hi, I am %s, I work at %s. Call me on %s\n", e.name, e.company, e.phone)
// }

// func main() {
// 	mark := Student{Human{"mark", 20, "123"}, "333"}
// 	steve := Employee{Human{name: "steve", age: 30, phone: "456"}, "MIT"}

// 	mark.SayHi()
// 	steve.SayHi()
// }
