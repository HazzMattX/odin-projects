package main
import "core:fmt"
import "core:math/rand"
import "core:os"
import "core:mem"
import "core:strings"
Suit :: enum {
    Hearts,
    Diamonds,
    Spades,
    Clubs,
}
Rank :: enum {
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Ten,
    Jack,
    Queen,
    King,
    Ace,
}
Card :: struct {
    rank: Rank,
    suit: Suit,
}
create_card :: proc(card: ^Card) -> Card {
    return Card{card.rank, card.suit}
}
new_deck :: proc() -> [dynamic]Card {
    deck := make([dynamic]Card)
    card: Card
    for suit in Suit {
        for rank in Rank {
            card = Card{rank, suit}
            append(&deck, create_card(&card))
        }
    }
    return deck
}
deck := new_deck();
play :: proc() {
    fmt.println("Welcome to Blackjack!")
    user_cards := make([dynamic]Card)
    dealer_cards := make([dynamic]Card)
    user_score: int
    dealer_score: int
    playing := true
    for i := 0; i < 2; i += 1 {
        append(&user_cards, deal_card())
        append(&dealer_cards, deal_card())
    }
    for playing {
        user_score = calculate_score(user_cards[:])
        dealer_score = calculate_score(dealer_cards[:])
        fmt.println("Your cards:", user_cards, "Your score:", user_score)
        fmt.println("Dealer's first card:", dealer_cards[0])
        if user_score > 21 || user_score == 0 || dealer_score == 0 {
            playing = false
        } else {
            fmt.println("Type 'yes' to get another card, type 'no' to pass:")
            buf: [256]byte
            i, _ := os.read(os.stdin, buf[:])
            hit_or_stand := strings.trim_space(string(buf[:i]))
            if hit_or_stand == "yes" {
                append(&user_cards, deal_card())
                user_score = calculate_score(user_cards[:])
            } else {
                playing = false
            }
        }
        for dealer_score <= 16 && dealer_score != 0 {
            append(&dealer_cards, deal_card())
            dealer_score = calculate_score(dealer_cards[:])
        }
    }
    fmt.println("Your final hand:", user_cards, "Your final score:", user_score)
    fmt.println("Dealer's final hand:", dealer_cards, "Dealer's final score:", dealer_score)
    fmt.println(compare(user_score, dealer_score))
    fmt.println("Do you want to play again? Type 'yes' or 'no':")
    buf: [256]byte
    i, _ := os.read(os.stdin, buf[:])
    play_again := strings.trim_space(string(buf[:i-1]))
    if play_again == "yes" {
        play()
    }
}
deal_card :: proc() -> Card {
    card := pop(&deck)

    return card
}
get_card_value :: proc(card: ^Card) -> int {
    switch card.rank {
        case Rank.Two:
            return 2
        case Rank.Three:
            return 3
        case Rank.Four:
            return 4
        case Rank.Five:
            return 5
        case Rank.Six:
            return 6
        case Rank.Seven:
            return 7
        case Rank.Eight:
            return 8
        case Rank.Nine:
            return 9
        case Rank.Ten, Rank.Jack, Rank.Queen, Rank.King:
            return 10
        case Rank.Ace:
            return 11
        case:
            return 0
    }
}
calculate_score :: proc(cards: []Card) -> int {
    sum: int
    card_value: int
    for i := 0; i < len(cards); i += 1 {
        card_value = get_card_value(&cards[i])
        sum += card_value
    }
    if sum == 21 && len(cards) == 2 {
        return 0
    }
    for &card in cards {
        card_value = get_card_value(&card)
        if card_value == 11 && sum > 21 {
        sum -= 10
        }
    }
    return sum
}
compare :: proc(ys, hs: int) -> string {
    switch {
        case ys == hs:
            return "Draw"
        case ys == 0:
            return "You win with a Blackjack!"
        case hs == 0:
            return "You lose, dealer has a Blackjack!"
        case ys > 21:
            return "You went over. You lose!"
        case hs > 21:
            return "Dealer went over. You win!"
        case ys > hs:
            return "You win!"
        case:
            return "You lose!"
    }
}

main :: proc() {
    fmt.println("Do you want to play Blackjack?")
    buf: [256]byte
    i, _ := os.read(os.stdin, buf[:])
    play_game := strings.trim_space(string(buf[:i-1]))
    if play_game == "yes" || play_game == "y" {
        play()
    }
}
