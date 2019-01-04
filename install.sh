BASEDIR="$( cd "$(dirname "$0")" ; pwd -P )"

# symlinks tmux configuration
ln -sf $BASEDIR/tmux/tmux.conf ~/.tmux.conf
