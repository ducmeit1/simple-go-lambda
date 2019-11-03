package pkg

import (
	"fmt"
	"strings"
)

func PrintName(name string) (string, error) {
	if !IsValidName(name) {
		return "", fmt.Errorf("Invalid Name")
	}
	return fmt.Sprintf("Hello %s", name), nil
}

func IsValidName(name string) bool {
	if strings.Trim(name, " ") == "" {
		return false
	}
	return true
}
