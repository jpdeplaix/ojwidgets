(* Copyright Université Paris Diderot.

   Author : Vincent Balat
            Charly Chevalier
*)

class type focusable = object
  inherit Dom_html.element
  method focus : unit Js.meth
end

module type In = sig
  include Button_show_hide_f.In

  type showed_elt_t
  type focus_t

  val to_showed_elt : showed_elt_t -> Dom_html.element Js.t
  val to_focus : focus_t -> focusable Js.t
end

module Make(M : In) = struct

  class button_show_hide_focus
    ?set ?pressed
    ?method_closeable
    ?button_closeable
    ?button
    ?(focused : M.focus_t option)
    (elt : M.showed_elt_t)
    =
  object
    inherit Button_show_hide.button_show_hide
      ?pressed ?set
      ?method_closeable
      ?button_closeable
      ?button:(Internals.opt_coerce M.to_button button)
      (M.to_showed_elt elt)
    as super

    method on_post_press =
      lwt () = super#on_post_press in
      let () = match focused with
         | None -> ()
         | Some e -> (M.to_focus e)##focus()
      in
      Lwt.return ()
  end

end