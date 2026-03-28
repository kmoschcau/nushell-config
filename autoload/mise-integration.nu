if (which mise | is-not-empty) {
  $nu.default-config-dir | path join vendor autoload | let mise_base_path
  mkdir $mise_base_path
  $mise_base_path | path join mise.nu | let mise_path
  ^mise activate nu | save $mise_path --force
}
