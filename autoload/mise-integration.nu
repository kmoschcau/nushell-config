if (which mise | is-not-empty) {
  let mise_path = $nu.default-config-dir | path join vendor autoload mise.nu
  ^mise activate nu | save $mise_path --force
}
