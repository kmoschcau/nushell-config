let is_on_windows = (sys host).name == "Windows"

if (not $is_on_windows and (which pnpm | is-not-empty)) {
  $env.PNPM_HOME = "/home/kmoschcau/.local/share/pnpm"
  $env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend ($env.PNPM_HOME | path join "bin")
  )
}
