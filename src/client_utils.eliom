[%%client

  open Lwt.Infix

  let bind_event ev elem handler =
    let handler evt _ = handler evt in
    Lwt_js_events.(async @@ (fun () -> ev elem handler))

]
