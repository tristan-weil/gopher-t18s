{{ template "header.tpl" . }}
{{/********** Global Vars **********/ -}}
{{ $width := 70 -}}
{{/********** Main **********/ -}}
:: BLOG 2020/11 ::

{{ ginfo (tablewriter (dict "data" (list (list "2020/11/11: back from the grave!")) "width" $width "text-alignment" "center" "box-separator" "~" "box-left" ")" "box-right" ")")) -}}
This `Gopher' space is once again up and running.

It is now powered by my own server in Go, `ttserver':
{{ gmenu (gurl_for "about/server") "More info here" }}

The `finger' space is also up: finger @finger.t18s.fr
{{ template "footer.tpl" . }}
