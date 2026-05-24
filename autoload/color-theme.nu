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
  $use_light_mode = (
    qdbus6
    org.freedesktop.portal.Desktop
    /org/freedesktop/portal/desktop
    org.freedesktop.portal.Settings.Read
    org.freedesktop.appearance
    color-scheme
  ) == "2"
}

if $use_light_mode {
  source ../themes/catppuccin-latte.nu
} else {
  source ../themes/catppuccin-mocha.nu
}
