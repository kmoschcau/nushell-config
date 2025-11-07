let is_on_windows = (sys host).name == "Windows"

mut use_light_mode = false

if $is_on_windows {
  $use_light_mode = (
    registry
    query
    --hkcu
    'Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
    'AppsUseLightTheme'
  ).value == 1
} else {
  # TODO: Make this more sensitive on Linux.
  $use_light_mode = (darkman get) == "light"
}

if $use_light_mode {
  source ../themes/catppuccin-latte.nu
} else {
  source ../themes/catppuccin-mocha.nu
}
