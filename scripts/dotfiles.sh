for source_path in $PWD/dotfiles/.*; do
  # Get the path and filename
  source_dir=$(dirname $source_path)
  source_filename=${source_path##*/}
  target_path="$HOME/${source_filename}"

  # Backup existing dotfiles
  if [ -e $target_path ]; then
    echo "Backing up '$source_filename' in $HOME/.dotfiles.bak/"
    mkdir -p $HOME/.dotfiles.bak
    mv $target_path "$HOME/.dotfiles.bak/$source_filename.$(date "+%Y%m%d%H%M%S")"
  fi;

  # Symlink!
  ln -s $source_path $target_path
done;
