_: {
  "hyprland/window" = {
    "format" = "{}";
    "separate-outputs" = true;
  };

  "hyprland/workspaces" = {
    active-only = false;
    disable-scroll = true;
    all-outputs = false;

    format = "{icon}";
    on-click = "activate";
    format-icons = {
      "1" = "󰎤";
      "2" = "󰎧";
      "3" = "󰎪";
      "4" = "󰎭";
      "5" = "󰎱";
      "6" = "󰎳";
      "7" = "󰎶";
      "8" = "󰎹";
      "9" = "󰎼";
      "10" = "󰽽";
      urgent = "󱨇";
      default = "";
      empty = "󱓼";
      sort-by-number = true;
    };
    persistent-workspaces = {
      "1" = [];
      "2" = [];
      "3" = [];
      "4" = [];
      "5" = [];
      "6" = [];
    };
    # "format-window-separator" = "->";
    "window-rewrite-default" = "";
    "window-rewrite" = {
      "class<NordPass>" = "󰢁";
      "class<Caprine>" = "󰈎";
      "class<Github Desktop>" = "󰊤";
      "class<Godot>" = "";
      "class<Mysql-workbench-bin>" = "";
      "class<Slack>" = "󰒱";
      "class<Signal>" = "󰭹";
      "class<jetbrains-phpstorm>" = "";
      "code-url-handler" = "";
      "class<discord>" = "󰙯";
      "class<Google-chrome>" = "";
      "class<Google-chrome> title<.*github.*>" = "";
      "class<Google-chrome> title<.*twitch|youtube|plex|tntdrama|bally sports.*>" = "";
      "class<kitty>" = "";
      "class<mediainfo-gui>" = "󱂷";
      "class<org.kde.digikam>" = "󰄄";
      "class<org.telegram.desktop>" = "";
      "class<.pitivi-wrapped>" = "󱄢";
      "class<steam>" = "";
      "class<thunderbird>" = "";
      "class<virt-manager>" = "󰢹";
      "class<vlc>" = "󰕼";
      "class<thunar>" = "󰉋";
      "class<org.gnome.Nautilus>" = "󰉋";
      "class<Spotify>" = "";
      "title<Spotify Free>" = "";
      "class<libreoffice-draw>" = "󰽉";
      "class<libreoffice-writer>" = "";
      "class<libreoffice-calc>" = "󱎏";
      "class<libreoffice-impress>" = "󱎐";
      "class<teams-for-linux>" = "󰊻";
      "class<OrcaSlicer>" = "󰈺";
      "class<obsidian>" = "󱞁";
    };
  };
}
