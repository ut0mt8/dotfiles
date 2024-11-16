local wezterm = require 'wezterm'

-- import
local config = wezterm.config_builder()
local act = wezterm.action

-- ssh mux
config.ssh_domains = {
  {
    name = 'wrk',
    remote_address = 'firefly.net:2322',
    timeout = 0,
  },
}

-- mouse bindings
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

-- keys bindings
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.Multiple {
      act.DetachDomain { DomainName = 'wrk' },
      act.AttachDomain('wrk'),
    } 
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 't',
    mods = 'LEADER',
    action = act.SpawnTab { DomainName = 'local' },
  },
  {
    key = 'b',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'LeftArrow',
    mods = 'LEADER',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'RightArrow',
    mods = 'LEADER',
    action = act.ActivateTabRelative(1),
  },
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

-- font
config.font = wezterm.font 'Tamzen'
config.font_size = 13.0
config.line_height = 0.9

-- themes/colors
local scheme = 'Gruvbox Dark (Gogh)'
local custom = wezterm.color.get_builtin_schemes()[ scheme ]
custom.background = "#262626"
custom.foreground = "#e0e0e0"

config.color_schemes = {
  [scheme] = custom,
}
config.color_scheme = scheme 

-- macos
config.window_background_opacity = 0.93
config.window_decorations = "RESIZE"
config.send_composed_key_when_left_alt_is_pressed = true

-- visual bell
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}

-- set tabbar title
function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  return tab_info.active_pane.title
end

-- tabbar style
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local background = '#373737'
    local foreground = '#bbbbbb'

    if tab.is_active then
      background = '#262626'
      foreground = '#cccccc'
    end

    local title = tab_title(tab)

    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = '[ '},
      { Text = title },
      { Text = ' ]'},
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
    }
  end
)

return config
