#!/bin/bash

# HERBSTLUFT PANEL
# nxll

font='-misc-orp-medium-r-semicondensed--12-110-75-75-c-60-iso10646-1'
glyphs='-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1'

set -f

function uniq_linebuffered() {
    awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

monitor=${1:-0}

herbstclient pad $monitor 16

funtion statusbar
{
   conky -c ~/.conkyrc | while read -r; do
      echo -e "conky $REPLY";
      #break
   done > >(uniq_linebuffered) &
   childpid=$!

   herbstclient --idle
   kill $childpid
} 2> /dev/null | {
    TAGS=( $(herbstclient tag_status $monitor) )
    unset TAGS[${#TAGS[@]}]
	conky=""   
 	visible=true

    while true ; do
        echo -n "%{l}"
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#') # current tag
                    echo -n "%{F#151515}%{B#aadb0f}"
                    ;;
                '+') # active on other monitor
                    echo -n "%{B#202020}"
                    ;;
                ':')
                    echo -n "%{B#202020}%{F-}"
                    ;;
                '!') # urgent tag
                    echo -n "%{B#ffffff}"
                    ;;
                *)
                    echo -n "%{B-}%{F-}"
                    ;;
            esac
            echo -n " ${i:1} "
        done
        echo -n "$conky "
        echo ""
        # wait for next event
        read line || break
        cmd=( $line ) 
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                TAGS=( $(herbstclient tag_status $monitor) )
                unset TAGS[${#TAGS[@]}]
                ;;
            conky)
                #echo "Getting Conky input" >&2
                conky="${cmd[@]:1}"
                ;;
            quit_panel)
                exit
                ;;
            reload)
                exit
                ;;
        esac
    done
} 2> /dev/null | lemonbar -p -g 1920x16+0+0 -B "#151515" -F "#ffffff" -f "$glyphs" -f "$font" $1 | sh &

