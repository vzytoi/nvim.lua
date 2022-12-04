let rec pow a = function
  | 0 -> 1
  | n -> a * pow a (n - 1)
