Heading
==============

## tpm
Tmux Plugin Manager
###Installing plugins
Add new plugin to ~/.tmux.conf with set -g @plugin '...'
Press prefix + I (capital I, as in Install) to fetch the plugin.
You're good to go! The plugin was cloned to ~/.tmux/plugins/ dir and sourced.

###Uninstalling plugins
Remove (or comment out) plugin from the list.
Press prefix + alt + u (lowercase u as in uninstall) to remove the plugin.
All the plugins are installed to ~/.tmux/plugins/ so alternatively you can find plugin directory there and remove it.

###Key bindings
prefix + I
Installs new plugins from GitHub or any other git repository
###Refreshes TMUX environment
prefix + U
updates plugin(s)
prefix + alt + u
remove/uninstall plugins not on the plugin list
###More plugins
For more plugins, A [check here](https://github.com/tmux-plugins).

## tmuxinator
Tmuxinator, manage complex tmux sessions easily.
  tmuxinator commands                          # Lists commands available in tmuxinator
  tmuxinator completions [arg1 arg2]           # Used for shell completion
  tmuxinator copy [EXISTING] [NEW]             # Copy an existing project to a new project and open it in you...
  tmuxinator debug [PROJECT] [ARGS]            # Output the shell commands that are generated by tmuxinator
  tmuxinator delete [PROJECT1] [PROJECT2] ...  # Deletes given project
  tmuxinator doctor                            # Look for problems in your configuration
  tmuxinator help [COMMAND]                    # Describe available commands or one specific command
  tmuxinator implode                           # Deletes all tmuxinator projects
  tmuxinator list                              # Lists all tmuxinator projects
  tmuxinator local                             # Start a tmux session using ./.tmuxinator.yml
  tmuxinator new [PROJECT] [SESSION]           # Create a new project file and open it in your editor
  tmuxinator start [PROJECT] [ARGS]            # Start a tmux session using a project's name (with an optiona...
  tmuxinator stop [PROJECT]                    # Stop a tmux session using a project's tmuxinator config
  tmuxinator version                           # Display installed tmuxinator version
