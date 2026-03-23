-- Wezterm config for wsl
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.font_size = 12
config.use_fancy_tab_bar = false
config.tab_max_width = 32
-- config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 1.0
config.adjust_window_size_when_changing_font_size = false
config.default_domain = "WSL:Ubuntu-24.04"

-- Background image
config.background = {
	{
		source = { File = "C:/Users/u0776047/Documents/_home/images/webgradients-night-call.png" },
		hsb = { brightness = 0.05 },
	},
}

-- key bindings
config.keys = {
	{
		key = "n",
		mods = "CTRL",
		action = wezterm.action.SpawnWindow,
	},
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.SpawnTab("DefaultDomain"),
	},
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnTab({ DomainName = "local" }),
	},
	{
		key = "t",
		mods = "CTRL|ALT",
		action = wezterm.action.SpawnTab({ DomainName = "WSL:archlinux" }),
	},
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action.MoveTabRelative(1),
	},
}
-- right click to copy and paste
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}

return config
