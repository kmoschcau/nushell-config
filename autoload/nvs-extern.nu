module "nvs extern" {
  def "nu-complete use versions" [] {
    let output: table<value:string, description:string> = ^nvs list
    | lines
    | str replace --regex '^..' ''
    | split column " " value description
    | default "" description
    | str replace --all --regex '\(|\)' '' description?

    $output
    | append (
      $output
      | where $it.description != ""
      | each {|it| { value: $it.description description: $it.value } }
    )
    | append [
      [value description];
      [auto "Use the version from '.node-version' or the default"]
      [lts "The latest LTS version"]
      [latest "The latest version"]
      [default "The configured default version"]
    ]
  }

  # Use a node version in the current shell
  export def --env "nvs use" [...args: string@"nu-complete use versions"] {
    let raw_output: table<op: string, path: string> = ^nvs use ...$args
    print $raw_output

    let output = $raw_output
    | lines
    | split column " " --number 3 _ op path
    | reject _
    | str replace "%LOCALAPPDATA%" $env.LOCALAPPDATA path

    let to_remove: list<string> = $output | where $it.op == "-=" | get path

    let to_add: list<string> = $output | where $it.op == "+=" | get path

    $env.PATH = $env.PATH | where $it not-in $to_remove | prepend $to_add
  }

  def "nu-complete subcommands" [] {
    ^nvs help
    | lines
    | where $it starts-with "nvs "
    | parse --regex "nvs (?P<value>[^ ]+).*?(?P<description>[[:upper:]].*)"
    | where $it.value != "use"
  }

  # NVS (Node Version Switcher)
  export extern nvs [
    command?: string@"nu-complete subcommands"
  ]
}

use "nvs extern" *
