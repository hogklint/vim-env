local conf_files = {
  "settings.lua",
  "keymaps.lua",
  "plugins.lua",
  "lsp.lua",
  "statusline.lua",
}

local viml_conf_dir = vim.fn.stdpath("config") .. "/viml_conf"
for _, file_name in ipairs(conf_files) do
  if vim.endswith(file_name, 'vim') then
    local path = string.format("%s/%s", viml_conf_dir, file_name)
    local source_cmd = "source " .. path
    vim.cmd(source_cmd)
  else
    local module_name, _ = string.gsub(file_name, "%.lua", "")
    package.loaded[module_name] = nil
    require(module_name)
  end
end
