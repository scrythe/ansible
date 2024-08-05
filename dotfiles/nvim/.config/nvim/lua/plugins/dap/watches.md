inside `.local/share/nvim/lazy/nvim-dap-ui/lua/dapui/components/watches.lua` replace

```
  ---@type dapui.watches.Watch[]
  local watches = {}
```

with

```
  local Path = require("plenary.path")
  local data_path = vim.fn.stdpath("data")
  local cache_config = string.format("%s/watches.json", data_path)
  ---@type dapui.watches.Watch[]
  local ok, watches = pcall(function()
    return vim.json.decode(Path:new(cache_config):read())
  end)
  if not ok then
    watches = {}
  end
  function updateWatch()
    Path:new(cache_config):write(vim.fn.json_encode(watches), "w")
  end
```

and

```
    ---@param canvas dapui.Canvas
    render = function(canvas)
```

with

```
    ---@param canvas dapui.Canvas
    render = function(canvas)
      updateWatch()

```
