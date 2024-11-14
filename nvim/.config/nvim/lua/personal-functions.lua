function yanky()
  local f = require "fzf-lua"
  local contents = require("yanky.history").all()

  local function getContent(args)
    local r = string.match(args[1], "^%d+")
    return contents[tonumber(r)]
  end

  local entries = {}
  for k, v in ipairs(contents) do
    table.insert(
      entries,
      string.format("%-2s", f.utils.ansi_codes.yellow(tostring(k)))
        .. " "
        .. v.regcontents:gsub("\n", f.utils.ansi_codes.yellow "\\n")
    )
  end

  local opts = {
    fzf_opts = {
      ["--no-multi"] = "",
      ["--border"] = "none",
      ["--preview-window"] = "right",
      -- ["--preview-window"] = "down:65%",
      ["--preview"] = f.shell.action(function(args)
        return getContent(args).regcontents
      end, nil, false),
    },
    actions = {
      ["default"] = function(args)
        require("yanky.picker").actions.put "p"(getContent(args))
      end,
    },
  }
  f.fzf_exec(entries, opts)
end
