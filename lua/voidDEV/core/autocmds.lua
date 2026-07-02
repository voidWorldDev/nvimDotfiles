-- Highlight on yank (very common & useful)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- you can also try "Visual", "Search", etc.
			timeout = 200, -- default is 150ms
		})
	end,
})

vim.api.nvim_create_user_command("InstallMasonDeps", function()
  local required = { "unzip", "zip", "wget", "curl", "tar", "gzip", "clang", "make", "git","npm"}
  local missing = {}
  for _, bin in ipairs(required) do
    if vim.fn.executable(bin) == 0 then
      table.insert(missing, bin)
    end
  end

  if #missing == 0 then
    vim.notify("All system deps already installed!")
    return
  end

  local pkg_manager
  if vim.fn.executable("apt") == 1 then pkg_manager = "sudo apt install -y "
  elseif vim.fn.executable("dnf") == 1 then pkg_manager = "sudo dnf install -y "
  elseif vim.fn.executable("pacman") == 1 then pkg_manager = "sudo pacman -S --noconfirm "
  elseif vim.fn.executable("brew") == 1 then pkg_manager = "brew install "
  else
    vim.notify("No known package manager found. Missing: " .. table.concat(missing, " "))
    return
  end

  local cmd = pkg_manager .. table.concat(missing, " ")

  -- open a horizontal split terminal and send the command
  vim.cmd("split | terminal")
  local chan = vim.b.terminal_job_id
  vim.fn.chansend(chan, cmd .. "\n")
end, {})
