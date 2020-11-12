{{ template "header.tpl" . }}
{{/********** Global Vars **********/ -}}
{{ $width := 70 -}}
{{/********** Main **********/ -}}
Welcome to this `Gopher' server!
{{ ginfo (tablewriter (dict "data" (list (list "ABOUT")) "width" $width "text-alignment" "center" "box-separator" "~" "box-left" ")" "box-right" ")")) -}}
{{ gmenu (gurl_for "about/me") (floating $width " " ":: about/me" "looking for a job!") -}}
{{ gmenu (gurl_for "about/server") (floating $width " " ":: about/server" "about this server") -}}
{{ gmenu (gurl_for "about/stats") (floating $width " " ":: about/stats" "stats of the server") -}}
{{ gurl "https://t18s.fr" (floating $width " " ":: https://t18s.fr " "more information available") }}
{{ ginfo (tablewriter (dict "data" (list (list "BLOG" )) "width" $width "text-alignment" "center" "box-separator" "~" "box-left" ")" "box-right" ")")) -}}
{{ gmenu (gurl_for "blog/2020/11") (floating $width " " ":: blog/2020/10" "entries for 2020/11") -}}
{{ gmenu (gurl_for "blog/2019/08") (floating $width " " ":: blog/2019/08" "entries for 2019/08") -}}
{{ gmenu (gurl_for "blog/2019/03") (floating $width " " ":: blog/2019/03" "entries for 2019/03") }}
{{ ginfo (tablewriter (dict "data" (list (list "AGGREGATORS" )) "width" $width "text-alignment" "center" "box-separator" "~" "box-left" ")" "box-right" ")")) -}}
{{ gmenu (gurl_for "aggregator/unix") (floating $width " " ":: aggregator/unix" "unix news from the world") -}}
{{ gmenu (gurl_for "aggregator/music") (floating $width " " ":: aggregator/music" "good music feeds") -}}
{{ template "footer.tpl" . }}
