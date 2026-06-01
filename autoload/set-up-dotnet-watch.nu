# Sets up some common environment variables set to make dotnet watch behave
# better.
def --env set-up-dotnet-watch [] {
  # This is needed for atomic writes with vim/neovim
  $env.DOTNET_USE_POLLING_FILE_WATCHER = "true"

  # Just tell it to restart and not ask
  $env.DOTNET_WATCH_RESTART_ON_RUDE_EDIT = "true"

  # I can open my browser myself, tyvm
  $env.DOTNET_WATCH_SUPPRESS_LAUNCH_BROWSER = "true"

  $env.DOTNET_WATCH_SUPPRESS_STATIC_FILE_HANDLING = "true"
}
