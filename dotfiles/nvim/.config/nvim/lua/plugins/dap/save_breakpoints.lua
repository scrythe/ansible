-- https://github.com/mfussenegger/nvim-dap/issues/198#issuecomment-1732842264
local M = {}
local Path = require("plenary.path")
local data_path = vim.fn.stdpath("data")
local cache_config = string.format("%s/breakpoints.json", data_path)

M.store_breakpoints = function(clear)
  local ok, bps = pcall(function()
    return vim.json.decode(Path:new(cache_config):read())
  end)
  if not ok then
    bps = {}
  end

  local breakpoints_by_buf = require("dap.breakpoints").get()
  if clear then
    for _, bufrn in ipairs(vim.api.nvim_list_bufs()) do
      local file_path = vim.api.nvim_buf_get_name(bufrn)
      if bps[file_path] ~= nil then
        bps[file_path] = {}
      end
    end
  else
    for buf, buf_bps in pairs(breakpoints_by_buf) do
      bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
    end
  end
  Path:new(cache_config):write(vim.fn.json_encode(bps), "w")
end

M.load_breakpoints = function()
  local ok, bps = pcall(function()
    return vim.json.decode(Path:new(cache_config):read())
  end)
  if not ok then
    bps = {}
  end
  local loaded_buffers = {}
  local found = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local file_name = vim.api.nvim_buf_get_name(buf)
    if bps[file_name] ~= nil and bps[file_name] ~= {} then
      found = true
    end
    loaded_buffers[file_name] = buf
  end
  if found == false then
    return
  end
  for path, buf_bps in pairs(bps) do
    for _, bp in pairs(buf_bps) do
      local line = bp.line
      local opts = {
        condition = bp.condition,
        log_message = bp.logMessage,
        hit_condition = bp.hitCondition,
      }
      require("dap.breakpoints").set(opts, tonumber(loaded_buffers[path]), line)
    end
  end
end

return M
