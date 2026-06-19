$env.config.auto_cd_implicit = true
$env.config.buffer_editor = "nvim"
$env.config.completions.algorithm = "fuzzy"
$env.config.cursor_shape.vi_insert = "blink_line"
$env.config.cursor_shape.vi_normal = "blink_block"
$env.config.edit_mode = "vi"
$env.config.error_style = "nested"
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true
$env.config.hooks.display_output = "if (term size).columns >= 100 { table --expand --icons } else { table --icons }"
$env.config.show_banner = false

# Do not send dotnet CLI telemetry data
$env.DOTNET_CLI_TELEMETRY_OPTOUT = "true"
