$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.completions.algorithm = "fuzzy"
$env.config.show_banner = false

def --env y [...args] {
  let tmp = (mktemp --tmpdir "yazi-cwd.XXXXXX")
  yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != "" and $cwd != $env.PWD {
    cd $cwd
  }
  rm --force --permanent $tmp
}

zoxide init nushell | save --force ~/.zoxide.nu

source ~/.zoxide.nu
