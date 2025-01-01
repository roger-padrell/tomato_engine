import math, strutils

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
  return (a.x*n, a.y*n);

proc Subtract*(a: Vector2, b: Vector2): Vector2 =
  return (a.x-b.x, a.y-b.y);

proc Equals*(a: Vector2, b: Vector2): bool =
  if (a.x == b.x) and (a.y==b.y):
    return true;
  else:
    return false;

proc Dot*(a: Vector2, b: Vector2): float = 
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
  sqrt(a.x * a.x + a.y * a.y)

proc normalized*(a: Vector2): Vector2 = 
  let mag: float = a.magnitude();
  return a.Divide(mag);

proc this*(a: Vector2): array[2, float] = 
  [a.x, a.y];

# Public methods
proc ToString*(a: Vector2): string = 
  "x: a.x, y: a.y".replace("a.x", $a.x).replace("a.y",$a.y);

# Static methods
#[proc unsignedAngle*(a: Vector2, b: Vector2): float = 
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
  #let angleRad = acos(clampedCosTheta)
  
  # Convert the angle to degrees
  #return angleRad * 180.0 / PI]#