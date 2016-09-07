module NonEmptyList = struct
  type 'a t = 'a * 'a list

  let length (x, l) = 1 + List.length l

  let push x (y, l) = x, (y :: l)
  let pop (x, l) =
    match l with
    | []   -> failwith "Only one element in the list, can not pop"
    | y::l -> x, (y, l)

  let to_list (x, l) = x :: l
  let from_list = function
    | []   -> failwith "Empty list, can not be converted"
    | x::l -> x, l

  let map f (x, l) = (f x, List.map f l)
  let fold f (a, l) b = List.fold_left (fun b a -> f a b) (f a b) l
end

let option_eval f ~default:b = function
  | Some a -> f a
  | None   -> b

let list_2str ?(empty = "") ?(sep = ", ") a_2str = function
  | []   -> empty
  | a::l -> List.fold_left (fun s a -> Printf.sprintf "%s%s%s" s sep (a_2str a)) (a_2str a) l
