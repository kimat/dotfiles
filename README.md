# dotfiles

## Setup

```sh
find * -maxdepth 0 -type d -exec stow {} \;
# uninstall
find * -maxdepth 0 -type d -exec stow -D {} \;
```

## Screenshots

![screenshot](https://raw.githubusercontent.com/kimat/images/master/tmux.png)

## Credits

- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
