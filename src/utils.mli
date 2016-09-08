module NonEmptyList: sig
  type 'a t = 'a * 'a list

  val length: 'a t -> int

  val push: 'a -> 'a t -> 'a t
  val pop: 'a t -> 'a * 'a t

  val to_list: 'a t -> 'a list
  val from_list: 'a list -> 'a t

  val map: ('a -> 'b) -> 'a t -> 'b t
  val fold: ('a -> 'b -> 'b) -> 'a t -> 'b -> 'b
end

val option_eval: ('a -> 'b) -> default:'b -> 'a option -> 'b

val list_2str: ?empty:string -> ?sep:string -> ('a -> string) -> 'a list -> string
