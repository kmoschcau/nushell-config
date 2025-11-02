# Open yazi and change into the last explored directory.
def --env y [...args] {
  let tmp = (mktemp --tmpdir "yazi-cwd.XXXXXX")
  yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != "" and $cwd != $env.PWD {
    cd $cwd
  }
  rm --force --permanent $tmp
}
