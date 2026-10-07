-- <leader>u — collect every URL in the current buffer (newest first, deduped)
-- and open the picked one in the system browser. Works in any buffer, including
-- the Claude terminal (press Esc Esc first to reach normal mode).
local function open_url_from_buffer()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local urls, seen = {}, {}
  for _, line in ipairs(lines) do
    for url in line:gmatch("https?://[^%s\"'`<>%)%]}]+") do
      url = url:gsub("[.,;:]+$", "") -- strip trailing prose punctuation
      if not seen[url] then
        seen[url] = true
        table.insert(urls, url)
      end
    end
  end
  if #urls == 0 then
    vim.notify("No URLs in this buffer", vim.log.levels.WARN)
    return
  end
  -- Newest first: links near the bottom (Claude's latest answer) matter most.
  local reversed = {}
  for i = #urls, 1, -1 do
    table.insert(reversed, urls[i])
  end
  if #reversed == 1 then
    vim.ui.open(reversed[1])
    return
  end
  vim.ui.select(reversed, { prompt = "Open URL:" }, function(choice)
    if choice then
      vim.ui.open(choice)
    end
  end)
end

vim.keymap.set("n", "<leader>u", open_url_from_buffer, { desc = "Open a URL from this buffer" })
