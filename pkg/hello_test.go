package pkg

import (
	"testing"
)

func TestValidateName(t *testing.T) {
	input := []string{"   ", "World"}
	expected := []bool{false, true}
	for i := range input {
		actual := IsValidName(input[i])
		if actual != expected[i] {
			t.Fatalf("Actual: %v, Expected: %v", actual, expected[i])
		}
	}
}

func TestPrintNameWithValidCase(t *testing.T) {
	input := "World"
	expected := "Hello World"
	actual, err := PrintName(input)
	if err != nil {
		t.Fatal(err)
	}
	if actual != expected {
		t.Fatalf("Actual: %v, Expected: %v", actual, expected)
	}
}

func TestPrintNameWithInvalidCase(t *testing.T) {
	input := "  "
	expected := ""
	actual, err := PrintName(input)
	if err == nil {
		t.Fatalf("Error must be appeared")
	}
	if actual != expected {
		t.Fatalf("Actual: %v, Expected: %v", actual, expected)
	}
}
