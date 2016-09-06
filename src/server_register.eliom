open Server_services
open Templates

let _ =
  GeneHub_app.register
    ~service:main_service
    (fun () () -> Lwt.return (make_page main_body))
