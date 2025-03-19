package main
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
main :: proc() {
	fmt.println("Hello world!")
	buf: [256]byte
	n1 := get_input("Enter the first number: ")
	num1 := strconv.atof(n1)
	fmt.println("Enter the operation (+, -, *, /): ")
	operation, _ := os.read(os.stdin, buf[:])
	n2 := get_input("Enter the second number: ")
	num2 := strconv.atof(n2)
	result: f64
	switch strings.trim_space(string(buf[:operation-1])) {
	case "+":
		result = add(num1, num2)
	case "-":
		result = subtract(num1, num2)
	case "*":
		result = multiply(num1, num2)
	case "/":
		result = divide(num1, num2)
	case:
		fmt.println("Invalid operation")
	}
	fmt.println("The result is", result)
}
get_input :: proc(prompt: string) -> string {
	fmt.print(prompt)
	buf: [256]byte
	bytes_read, _ := os.read(os.stdin, buf[:])
	return string(buf[:bytes_read])
}
add :: proc(a, b: f64) -> f64 {
	return a + b
}
subtract :: proc(a, b: f64) -> f64 {
	return a - b
}
multiply :: proc(a, b: f64) -> f64 {
	return a * b
}
divide :: proc(a, b: f64) -> f64 {
	return a / b
}
