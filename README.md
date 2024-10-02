# Personal Emacs Configuration

Written in Org mode.

This will always be work in progress.

## How to setup
Git clone this repo wherever you want, and just insert the following at the top of your ```init.el``` file
```lisp
(load-file "~/emacs-config/bootstrap.el")
```
where the path to bootstrap.el is adjusted to wherever you cloned this repo.
This will also automatically pull the latest version of the config on startup, unless you forbid it with
```lisp
(setq config-no-auto-update t)
```
