{
  pkgs,
  config,
  ...
}: {
  config = {
    programs.nano = {
      # enabled by default anyway, we can keep it in case my neovim config breaks
      enable = true;
      nanorc = ''
        include ${pkgs.nanorc}/share/*.nanorc # extended syntax highlighting

        # Options
        # https://github.com/davidhcefx/Modern-Nano-Keybindings
        set tabsize 4
        set tabstospaces
        set linenumbers
        set numbercolor yellow,normal
        set indicator                         # side-bar for indicating cur position
        set smarthome                         # `Home` jumps to line start first
        set afterends                         # `Ctrl+Right` move to word ends instead of word starts
        set wordchars "_"                     # recognize '_' as part of a word
        set zap                               # delete selected text as a whole
        set historylog                        # remember search history
        set multibuffer                       # read files into multibuffer instead of insert
        set mouse                             # enable mouse support
      '';
    };
  };
}
