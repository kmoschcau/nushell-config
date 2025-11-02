module "update langs" {
  # Update installed programming languages.
  export def update-langs [] {
    # Go =======================================================================
    if (which goenv | is-not-empty) {
      print "Updating goenv…"
      cd ([$env.HOME .goenv] | path join)
      git pull
    }

    # node.js ==================================================================
    if (which nodenv | is-not-empty) {
      nodenv update
    }

    if (
      (which npm | is-not-empty)
      and (which nodenv | is-not-empty)
      and (nodenv version) !~ "^system"
    ) {
      npm update --global
    }

    # PHP ======================================================================
    if (which phpenv | is-not-empty) {
      phpenv update
    }

    # Python ===================================================================
    if (which pyenv | is-not-empty) {
      pyenv update
    }

    if (
      (which pip-review | is-not-empty)
      and (which pyenv | is-not-empty)
      and (pyenv version) !~ "^system"
    ) {
      pip-review --auto
    }

    # Ruby =====================================================================
    if (which rbenv | is-not-empty) {
      rbenv update
    }

    if (
      (which gem | is-not-empty)
      and (which rbenv | is-not-empty)
      and (rbenv version) !~ "^system"
    ) {
      gem update
      gem clean
    }

    # Rust =====================================================================
    if (which rustup | is-not-empty) {
      rustup update
    }

    if (
      (which cargo | is-not-empty)
      and (cargo --list) =~ "install-update"
    ) {
      cargo install-update --all
    }
  }
}

use "update langs" update-langs
