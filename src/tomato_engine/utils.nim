import math

## Utils
proc acos*(x: float): float =
  ## Acos function because math's module does not work.
  # Check for valid input
  if x < -1.0 or x > 1.0:
    raise newException(ValueError, "Input must be between -1 and 1")
  
  # Set initial guess (for acos(x), initial guess is usually x)
  var guess = x
  var diff = 1.0
  let epsilon = 1e-10  # Define the tolerance
  
  # Newton's method iteration to approximate acos
  while diff > epsilon:
    # Update guess using Newton's method
    let newGuess = guess - (cos(guess) - x) / (-sin(guess))
    diff = abs(newGuess - guess)  # Compute the difference
    guess = newGuess  # Update guess
    
  return guess