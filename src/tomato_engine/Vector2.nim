import math, strutils
import utils

type 
  Vector2* = tuple[x:float, y:float];

## # Vector2
## Utils for managing 2D positions and using them
## For everything in this document you need to import the tomato_engine library (only the Vector2 if you want)
## ```
## import tomato_engine # whole library
## import tomato_engine # only the Vector2
## ```
## You don't need to import both, because in the whole library, the Vector2 comes included
## 
## # Create a Vector2
## ```
## const a: Vector2 = (1,1) # X: 1, Y:1
## ```

# Operations
proc Add*(a: Vector2, b: Vector2): Vector2 =
  ## Add two Vector2
  ## ```
  ## const a: Vector2 = (0,1)
  ## const b: Vector2 = (1,0)  
  ## echo a.Add(b) # (1,1)
  ## ```
  (x: a.x + b.x, y: a.y + b.y)

proc Divide*(a: Vector2, n: float): Vector2 = 
  ## Divide a Vector2 by a number
  ## ```
  ## const a: Vector2 = (4,4)
  ## echo a.Divide(2) # (2,2)
  ## ```
  if n==0:
    return a;
  (a.x/n, a.y/n);

proc Multiply*(a: Vector2, n: float): Vector2 = 
  ## Multiply a Vector2 by a number
  ## ```
  ## const a: Vector2 = (2,2)
  ## echo a.Multiply(2) # (4,4)
  ## ```
  return (a.x*n, a.y*n);

proc Subtract*(a: Vector2, b: Vector2): Vector2 =
  ## Subtract two Vector2
  ## ```
  ## const a: Vector2 = (4,4)
  ## const b: Vector2 = (3,3)
  ## echo a.Subtract(b) # (1,1)
  ## ```
  return (a.x-b.x, a.y-b.y);

proc Equals*(a: Vector2, b: Vector2): bool =
  ## Check if two Vector2 are identic
  ## ```
  ## const a: Vector2 = (4,4)
  ## const b: Vector2 = (3,3)
  ## echo a.Equals(b) # false
  ## ```
  ## or
  ## ```
  ## const a: Vector2 = (4,4)
  ## const b: Vector2 = (4,4)
  ## echo a.Equals(b) # true
  ## ```
  if (a.x == b.x) and (a.y==b.y):
    return true;
  else:
    return false;

proc Dot*(a: Vector2, b: Vector2): float = 
  ## Returns the Dot product between two Vector2
  ## ```
  ## const a: Vector2 = (4,4)
  ## const b: Vector2 = (3,3)
  ## echo a.Dot(b) # 24.0
  ## ```
  return (a.x * b.x) + (a.y * b.y);

# Static properties
proc down*(): Vector2 =
  (0,-1)

proc left*(): Vector2 = 
  (-1,0)

proc right*(): Vector2 = 
  (1,0)

proc up*(): Vector2 = 
  (0,1)

proc one*(): Vector2 = 
  (1,1)

proc zero*(): Vector2 = 
  (0,0)

proc negativeInfinity*(): Vector2 = 
  (low(float), low(float))

proc positiveInfinity*(): Vector2 = 
  (high(float), high(float))

# Properties
proc magnitude*(a: Vector2): float = 
  ## Returns the magnitude/lenght of the Vector2
  ## ```
  ## const a: Vector2 = (4,4)
  ## echo a.magnitude() # 5.656854249492381
  ## ```
  sqrt(a.x * a.x + a.y * a.y)

proc normalized*(a: Vector2): Vector2 = 
  ## Returns a Vector2 with a magnitude of 1 but with the same direction
  ## ```
  ## const a: Vector2 = (6,2)
  ## const b: Vector2 = a.normalized() 
  ## echo b # (x: 0.9486832980505138, y: 0.3162277660168379)
  ## echo b.magnitude() # 0.99999999 = 1
  ## ```
  let mag: float = a.magnitude();
  return a.Divide(mag);

proc this*(a: Vector2): array[2, float] = 
  ## Get the vector as an array of \[x,y\]
  ## ```
  ## const a: Vector2 = (2,4);
  ## echo a.this()[0] # 2
  ## echo a.this()[1] # 4
  ## ```
  [a.x, a.y];

# Public methods
proc ToString*(a: Vector2): string = 
  ## Returns a formatted string with the values
  ## ```
  ## const a: Vector2 = (3,4);
  ## echo a.ToString() # "x: 3, y: 4"
  ## ```
  "x: a.x, y: a.y".replace("a.x", $a.x).replace("a.y",$a.y);

# Static methods
proc unsignedAngle*(a: Vector2, b: Vector2): float = 
  ## Gets the unsigned angle in degrees between from and to.
  let magFrom = a.magnitude();
  let magTo = b.magnitude();
  
  # Avoid division by zero if vectors are zero-length
  if magFrom == 0 or magTo == 0:
    return 0.0  # Return 0 for degenerate case
  
  # Dot product of from and to vectors
  let dotProd = a.Dot(b);
  
  # Compute the cosine of the angle between the vectors
  let cosTheta = dotProd / (magFrom * magTo)
  
  # Clamp the value of cosTheta to avoid numerical issues leading to NaN
  let clampedCosTheta = cosTheta.clamp(-1.0, 1.0)
  
  # Compute the angle in radians
  let angleRad = acos(clampedCosTheta)
  
  # Convert the angle to degrees
  return angleRad * 180.0 / PI

proc Distance*(a: Vector2, b: Vector2): float =
  ## Returns the distance between a and b.
  ## ```
  ## const a: Vector2 = (1,1);
  ## const b: Vector2 = (3,3);
  ## echo a.Distance(b) # 2.82842712474619
  ## ```
  let c: Vector2 = a.Subtract(b);
  return c.magnitude();

proc Max*(a: Vector2, b: Vector2): Vector2 = 
  ## Returns a vector that is made from the largest components of two vectors.
  ## ```
  ## const a: Vector2 = (1,3);
  ## const b: Vector2 = (3,1);
  ## echo a.Max(b) # (3,3);
  ## ```
  var x: float = 0;
  var y: float = 0;
  if a.x > b.x:
    x = a.x;
  else: 
    x = b.x;
  if a.y > b.y:
    y = a.y;
  else: 
    y = b.y;
  return (x, y);

proc Min*(a: Vector2, b: Vector2): Vector2 = 
  ## Returns a vector that is made from the smallest components of two vectors.
  ## ```
  ## const a: Vector2 = (1,3);
  ## const b: Vector2 = (3,1);
  ## echo a.Min(b) # (1,1);
  ## ```
  var x: float = 0;
  var y: float = 0;
  if a.x < b.x:
    x = a.x;
  else: 
    x = b.x;
  if a.y < b.y:
    y = a.y;
  else: 
    y = b.y;
  return (x, y);

