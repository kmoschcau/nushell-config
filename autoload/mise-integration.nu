if (which mise | is-not-empty) {
  let mise_base_path = $nu.default-config-dir | path join vendor autoload
  mkdir $mise_base_path
  let mise_path = $mise_base_path | path join mise.nu
  ^mise activate nu | save $mise_path --force
}
