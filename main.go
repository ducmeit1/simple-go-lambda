package main

import (
	"fmt"
	"simple-go-lambda/pkg"
)

func main() {
	print, err := pkg.PrintName("World")
	if err != nil {
		panic(err)
	}
	fmt.Println(print)
}
