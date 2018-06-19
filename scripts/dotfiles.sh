for source_path in $PWD/dotfiles/.*; do
  # Get the path and filename
  source_dir=$(dirname $source_path)
  source_filename=${source_path##*/}
  target_path="$HOME/${source_filename}"

  [ -d $source_path ] && continue;

  # Backup existing dotfiles
  if [ -f $target_path ]; then
    echo "File '$source_filename' already exists. Backing up to $HOME/.dotfiles.bak/"
    mkdir -p $HOME/.dotfiles.bak
    mv $target_path "$HOME/.dotfiles.bak/$source_filename.$(date "+%Y%m%d%H%M%S")"
  fi;

  # Symlink!
  ln -s $source_path $target_path
done;
