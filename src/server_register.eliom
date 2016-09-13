open Server_services
open Templates

let _ =
  GeneHub_app.register
    ~service:main_service
    (fun () () -> Lwt.return (genehub_main_page ()))
