This is my personal Dotfiles Repo

# Prerequisites

- i3 alacritty git nano neovim vim nautulus yazi neofetch htop sudo feh zsh ttf-jetbrains-mono networkmanager pulseaudio
- yay for AUR, nvm, yazi from github.
- dmenu( with height patch )

- YT Link : <https://youtu.be/odgD_RdJjCU?si=FjLXyps7iP2yI0fT>
- Cursor Theme Select in Xresources
- for GTK edit gtk-3.0/setting.ini file. (40 for Personal Laptop)
- xrandr for display settings (see arch wiki)

# Cheatsheets

## Shell

- !(string) runs last command starting with string
- !! means above command
- !$ args from last command, !:[0-n] means words friom last command
- !# means current line, !#:[0-n] means word from current line
- C-a to move to begining of the line
- C-e to move to the end of the line
- C-w delete word before means
- C-k to delete afterwards till end
- ^s1^s2 will find and replace s1 with s2 and run it

# Notification

This command for persistan eplacinf Notification notify-send -e -h string:x-canonical-private-synchronous:brightness -h int:value:1 -u low "Screen" "Brightness: 1%"
