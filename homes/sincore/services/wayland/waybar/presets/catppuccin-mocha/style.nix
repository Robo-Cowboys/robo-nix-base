{colors}:
with colors; ''
     /**
     * Global configuration for theme
     * */

     * {
         font-family: Ubuntu Nerd Font;
         font-size: 12px;
     }

     window#waybar {
         background: none;
         border-radius: 0px;
     }

     window#waybar.empty #window {
       background-color: transparent;
     }

     .modules-left {
       background: #${colors.base02};
       border-top-right-radius: 14px;
       border-bottom-right-radius: 14px;
       padding: 0px 12px 0px 4px;
     }

     .modules-right {
       background: #${colors.base02};
       border-top-left-radius: 14px;
       border-bottom-left-radius: 14px;
       padding: 0px 4px 0px 12px;
       font-weight: bold;
     }

     .modules-center {
       background: transparent;
     }

     #window {
       color: #${colors.base05};
       font-weight: bold;
     }

     #custom-separator-right,
     #custom-separator-left {
       font-size: 16px;
       padding-left: 1em;
       padding-right: 1em;
       color: #${colors.base05};
     }


   /* Add spacing for right side modules */
     #tray,
     #utilities,
     #notifications,
     #mpd {
       margin: 0.5em;
     }

   #clock {
       font-size: 12px;
       font-weight: 900;
     }


   @keyframes blink {
           to {
             background-color: #ffffff;
             color: #000000;
           }
         }

  /******************************
   * Taskbar
   * */

   #taskbar {
     background: #${colors.base02};
     padding: 0px 4px 1px;
   }

   #taskbar button {
     border-radius: 0px;
     transition: all 0.3s;
     padding: 1px 2px 0px 4px;
     margin: 0px;
     opacity: 0.3;
     background: transparent;
   }

   #taskbar button.active {
     background: transparent;
     opacity: 1;
   }

   #taskbar button:hover {
     background: #${colors.base04};
     opacity: 0.8;
   }

  /******************************
   * Workspaces
   * */

   #workspaces {
     padding-left: 0.5em;
     padding-right: 0.5em;
   }

   #workspaces button {
     padding: 0 0.5em;
     border-radius: 0px;
     margin: 0px;
     color: #${colors.base05};
     font-weight: bold;
     border-top: 2px solid transparent;
     border-bottom: 2px solid transparent;
   }

   #workspaces button.active {
     color: #${colors.base0E};
     border-bottom: 2px solid #${colors.base0E};
   }

     /***********************************************
      * Notifications
      * */
     #custom-notification,
     #custom-updates,
     #pulseaudio,
     #backlight,
     #systemd-failed-units
      {
       padding: 0 0.5em;
     }

     /* Unique colors for modules */
     #idle_inhibitor {
       color: #${colors.base0A};
     }

     #pulseaudio{
       color: #${colors.base0B};
     }

     #backlight{
       color: #${colors.base0A};
     }

     #battery {
       color: #${colors.base0F};
     }

     #custom-updates {
       color: #${colors.base08};
     }

     #systemd-failed-units {
       color: #${colors.base0E};
     }

     #pulseaudio.muted {
       background-color: #90b1b1;
       color: #2a5c45;
     }

     /***********************************************
     * Stats Drawer
     * */

     #stats,
     #stats-drawer {
       padding-left: 5px;
       padding-right: 5px;
       color: #${colors.base09};
     }

     #battery,
     #cpu,
     #memory,
     #temperature,
     #disk,
     #network {
       padding: 0 0.5em;
     }

     /* Unique colors for modules */
     #cpu {
       color: #${colors.base08};
     }

     #memory {
       color: #${colors.base0A};
     }
     #temperature {
       color: #${colors.base0B};
     }

     #network {
       color: #${colors.base0D};
     }

     #network.disconnected {
       background-color: #f53c3c;
     }

     #temperature.critical {
       background-color: #eb4d4b;
     }
''
