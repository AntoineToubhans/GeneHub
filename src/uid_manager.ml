type uid = int
type t = int ref

let init () = ref 0

let generate x = x := !x + 1; !x -1
let free i x =
  if i +1 = !x then x := i
