import gleam/io
import gleam/int
import gleam/string
import gleam/erlang
import gleam/order

pub fn main() {
  io.println("Guess the secret number!")
  let number = int.random(101)
  guess(number, 0)
}

fn guess(number, tries) {
  let try = {
    // just panic if not able to get the input
    let assert Ok(input) = erlang.get_line("What's your guess?\n")

    // parse pipeline
    input
    |> string.trim
    |> int.parse
  }

  case try {
    Ok(try) -> {
      case int.compare(try, number) {
        order.Eq -> {
          io.println(
            "Wow! You guessed it in " <> int.to_string(tries) <> " tries!",
          )
        }
        order.Gt -> {
          io.println("The secret number is lower than your guess")
          guess(number, tries + 1)
        }
        order.Lt -> {
          io.println("The secret number is greater than your guess")
          guess(number, tries + 1)
        }
      }
    }
    Error(_) -> {
      // ps: not really validating if the number is on bounds 
      io.println("Input should be an integer between 0 and 100")
      guess(number, tries)
    }
  }
}
