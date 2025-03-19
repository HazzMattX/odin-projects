package main
import "core:fmt"
import "core:math/rand"
import "core:os"
import "core:strings"
import "core:strconv"
main :: proc() {
    fmt.println("Time to play a guessing game! Guess a number between 1 and 100.")
    number_to_guess := rand.int31_max(100)
    attempts := 0
    buf: [256]byte
    fmt.print("Enter difficulty (easy, medium, hard): ")
    i, _ := os.read(os.stdin, buf[:])
    difficulty := strings.trim_space(string(buf[:i-1]))
    if difficulty == "easy" {
        attempts = 10
    } else if difficulty == "medium" {
        attempts = 5
    } else if difficulty == "hard" {
        attempts = 3
    }
    for attempts > 0 {
        fmt.println("You have", attempts, "attempts left to guess the number.")
        fmt.print("Your guess: ")
        n, _ := os.read(os.stdin, buf[:])
        guess_str := string(buf[:n])
        guess_str = strings.trim_space(guess_str) // remove extra spaces
        guess := i32(strconv.atoi(guess_str))
        if guess < number_to_guess {
            fmt.println("Too low!")
            attempts -= 1
        } else if guess > number_to_guess {
            fmt.println("Too high!")
            attempts -= 1
        } else if guess == number_to_guess {
            fmt.println("You guessed it!")
            break
        }
    }
    if attempts == 0 {
        fmt.println("You ran out of attempts! The number was", number_to_guess)
    }
}
