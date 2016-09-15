[%%client
  open Lwt.Infix

  (* Application data *)
  module Model = struct

    type user = {
      lastname:  string;
      firstname: string;
    } [@@deriving json]

    type t =
      | Logged of user
      | Not_logged
      [@@deriving json]

    let initial: t = Not_logged

    let from_json s =
      Deriving_Json.from_string [%derive.json: t] s

    let to_json m =
      Deriving_Json.to_string [%derive.json: t] m
  end

  type rs = Model.t React.signal
  type rf = ?step:React.step -> Model.t -> unit
  type rp = rs * rf

  (* User interface actions *)
  module Action = struct

    type login = {
      email:  string;
      password:  string;
    }

    type action =
      | Login of login
      | Logout
  end

  (* Manage actions, refresh view if needed and save the state in local storage *)
  module Controller = struct

    let update a ((r, f) : rp) =
      let m: Model.t =
        match a with
        | Action.Logout   -> Model.Not_logged
        | Action.Login lg ->
          if lg.Action.password = "ahahahah" && lg.Action.email = "antoine@genehub.io" then
            let user: Model.user = {
              Model.firstname = "Antoine" ;
              Model.lastname  = "Toubhans" ;
            } in
            Model.Logged user
          else Model.Not_logged
      in f m
  end

  (* Build HTML and send user actions *)
  module View = struct

    open Model
    open Action
    open Tyxml_js

    let make_logger_input (input_type: string) =
      Html5.(input ~a:[
          a_input_type `Text ;
          a_class [Printf.sprintf "login-%s" input_type] ;
          a_placeholder input_type ;
        ] ())

    let logger_email = make_logger_input "email"
    let logger_password = make_logger_input "password"

    let logger =
      Html5.(
        div
          ~a:[a_class ["login"]]
          [
            logger_email;
            logger_password;
            button [pcdata "Login"];
          ]
      )

    let welcome_message (user: Model.user) =
      Html5.(
        div
          ~a:[a_class ["welcome"]]
          [pcdata (Printf.sprintf "Hello %s %s !" user.Model.firstname user.Model.lastname)]
      )

    let view (r, f) = logger

  end

  let main _ =
    let doc = Dom_html.document in
    let parent =
      Js.Opt.get (doc##getElementById (Js.string "genehub-main"))
        (fun () -> assert false)
    in
    let m = Model.initial in
    let rp = React.S.create m in
    Dom.appendChild parent (Tyxml_js.To_dom.of_div (View.view rp)) ;
    Lwt.return ()

  let _ = Lwt_js_events.onload () >>= main
]
