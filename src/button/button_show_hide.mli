(* Copyright Université Paris Diderot.

   Author : Vincent Balat
            Charly Chevalier
*)

module In_button_show_hide_m
  : Button_show_hide_f.In
    with type button_t = Dom_html.element Js.t
    with type showed_elt_t = Dom_html.element Js.t


(** show_hide shows or hides a box when pressed/unpressed.
    Set style property "display: none" for unpressed elements if
    you do not want them to appear shortly when the page is displayed.
*)
class show_hide :
     ?set:(unit -> unit Lwt.t) ref
  -> ?pressed:bool
  -> ?closeable_by_method:bool
  -> ?closeable_by_button:bool
  -> ?button:Dom_html.element Js.t
  -> Dom_html.element Js.t
  ->
object
  val mutable display : string

  inherit Button.button
end

class type show_hide_t = object
  inherit Button.button_t
end
