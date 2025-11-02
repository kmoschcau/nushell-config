module "update configs" {
  const base_uri = "git@github.com:kmoschcau/"

  const configs: table<name: string gui: bool> = [
    [name gui];
    [bat false]
    [fish false]
    [fontconfig true]
    [fzf false]
    [git false]
    [glamour false]
    [neovide true]
    [nushell false]
    [nvim false]
    [starship false]
    [tig false]
    [yamllint false]
    [wezterm true]
    [yazi false]
  ]

  const irregular_configs: table<name: string gui: bool> = [
    [name gui];
    [global-config false]
    [home-config false]
  ]

  const old_configs: table<name: string gui: bool> = [
    [name gui];
    [alacitty true]
    [dunst true]
    [i3 true]
    [i3blocks true]
    [picom true]
    [ranger false]
    [rofi true]
    [rubocop false]
    [terminator true]
    [tmux false]
  ]

  # Update my user configuration files.
  export def update-configs [
    --no-gui
    --old
  ]: nothing -> nothing {
    if (which git | is-empty) {
      print "git is not installed!"
      return 1
    }

    try {
      ls --directory $env.XDG_CONFIG_HOME
    } catch {
      print $in.rendered
      return 2
    }

    $configs
    | insert "irregular" false
    | append ($irregular_configs | insert "irregular" true)
    | if $old { append ($old_configs | insert "irregular" false) } else {}
    | if $no_gui { where not $it.gui } else {}
    | par-each {|config|

      let config_name: string = $config.name
      | if not $config.irregular { $in + "-config" } else {}

      let dir_name = $"($env.XDG_CONFIG_HOME)/($config.name)"

      mut update_or_clone: string = "clone"
      try {
        ls --directory $dir_name
        $update_or_clone = "update"
      }

      match $update_or_clone {
        "update" => {
          print $"Existing ($config_name) repository, updating…"
          cd $dir_name
          git pull --prune | ignore
        }
        _ => {
          print $"No ($config_name) repository, cloning…"
          git clone $"($base_uri)($config_name).git" $dir_name | ignore
        }
      }

      print $"Updated ($config_name)."
    }

    null
  }
}

use "update configs" update-configs
