$env.config = {
  buffer_editor: "nvim"

  edit_mode: "vi"
}

def --env y [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")
  yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != "" and $cwd != $env.PWD {
    cd $cwd
  }
  rm -fp $tmp
}

zoxide init nushell | save -f ~/.zoxide.nu

source ~/.zoxide.nu
