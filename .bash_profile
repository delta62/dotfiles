export MOZ_ENABLE_WAYLAND=1
export XDG_PICTURES_DIR=~/Pictures

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
elif [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
