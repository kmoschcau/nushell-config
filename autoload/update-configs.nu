module "update configs" {
  const base_uri = "git@github.com:kmoschcau/"

  const configs: table<name: string gui: bool win_dir: string> = [
    [name       gui   win_dir];
    [bat        false ~\AppData\Roaming\bat]
    [fish       false none]
    [fontconfig true  none]
    [fzf        false none]
    [git        false ~\.config\git]
    [neovide    true  ~\AppData\Roaming\neovide]
    [nushell    false ~\AppData\Roaming\nushell]
    [nvim       false ~\AppData\Local\nvim]
    [starship   false ~\.config\starship]
    [yamllint   false ~\.config\yamllint]
    [wezterm    true  ~\.config\wezterm]
    [yazi       false ~\AppData\Roaming\yazi\config]
  ]

  const irregular_configs: table<name: string gui: bool win_dir: string> = [
    [name          gui   win_dir];
    [global-config false none]
    [home-config   false none]
  ]

  const old_configs: table<name: string gui: bool win_dir: string> = [
    [name       gui   win_dir];
    [alacritty  true  none]
    [dunst      true  none]
    [glamour    false none]
    [i3         true  none]
    [i3blocks   true  none]
    [picom      true  none]
    [ranger     false none]
    [rofi       true  none]
    [rubocop    false none]
    [terminator true  none]
    [tig        false none]
    [tmux       false none]
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

    let is_on_windows = (sys host).name == "Windows"

    try {
      if not $is_on_windows {
        ls --directory $env.XDG_CONFIG_HOME
      }
    } catch {
      print $in.rendered
      return 2
    }

    $configs
    | insert "irregular" false
    | append ($irregular_configs | insert "irregular" true)
    | if $old { append ($old_configs | insert "irregular" false) } else {}
    | if $no_gui { where not $it.gui } else {}
    | if $is_on_windows { where $it.win_dir != "none" } else {}
    | par-each {|config|

      let config_name: string = $config.name
      | if not $config.irregular { $in + "-config" } else {}

      let dir_name = if $is_on_windows {
        $config.win_dir | path expand
      } else {
        $"($env.XDG_CONFIG_HOME)/($config.name)"
      }

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
