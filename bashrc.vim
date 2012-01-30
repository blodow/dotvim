# what's going on with the gnome devs to make it so hard to get 256 colors
# in terminal vim? it's 2012 for fuck's sake.

# force 256 color gnome-terminal terminfo
if [[ TERM=="xterm" && COLORTERM==gnome* ]]; then
  export TERM="xterm-256color"
fi
