-- Wezterm config for wsl
local wezterm = require("wezterm")
local config = wezterm.config_builder()

local act = wezterm.action
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.font_size = 14
config.use_fancy_tab_bar = false
config.tab_max_width = 32
-- config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 1.0

config.adjust_window_size_when_changing_font_size = false
-- key bindings
config.keys = {
	{
		key = "n",
		mods = "ALT",
		action = wezterm.action.SpawnWindow,
	},
	{
		key = "t",
		mods = "ALT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "h",
		mods = "SHIFT|ALT",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = "l",
		mods = "SHIFT|ALT",
		action = wezterm.action.MoveTabRelative(1),
	},
	{
		key = "/",
		mods = "ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "'",
		mods = "ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "j",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|ALT",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "RightArrow",
		mods = "CTRL|ALT",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "UpArrow",
		mods = "CTRL|ALT",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "DownArrow",
		mods = "CTRL|ALT",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
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
-- Background image
config.window_background_image = "C:/Users/u0776047/Documents/_home/images/Monterey-Dark.png"
config.window_background_image_hsb = {
	brightness = 0.3,
	hue = 1.0,
	saturation = 1.0,
}

config.default_domain = "WSL:Ubuntu-24.04"

return config
