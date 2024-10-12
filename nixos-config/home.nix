{ config, pkgs, ... }:

{
  home.username = "lamtdang";
  home.homeDirectory = "/home/lamtdang";
  home.stateVersion = "24.05";

  fonts.fontconfig.enable = true;
  # packages
  home.packages = with pkgs; [
    #terminal
    alacritty
    oh-my-zsh
    fzf #Search Text
    xorg.xrandr #multiple monitors

    #ide
    ripgrep #Search text


    #programming language
    go
    gopls
    gotools
    go-tools

    cargo
    unzip
    nodejs_22
    python3
    luajit
    luajitPackages.luarocks-nix

    #misc
    google-chrome
    obsidian
    feh

    #devtools
    gh
    docker_27
    kubernetes
    docker-compose


  ];

  programs.git = {
    enable = true;
    userName = "Lam Dang";
    userEmail = "lamtdang98@gmail.com";
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "alacritty -e zsh";
      name = "open-terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>w";
      command = "google-chrome-stable";
      name = "exit-terminal";
    };


  };

  programs.home-manager.enable = true;


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake .";
    };

    history = {
      size = 100000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "golang" "kubectl" "sudo" "docker" "docker-compose" ];
      theme = "af-magic";
    };

  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      LazyVim
      nvim-treesitter
    ];
    extraPackages = with pkgs; [
      gcc
    ];
  };

   
  programs.lazygit.enable = true;

  

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      catppuccin
    ];
    shortcut = "z";
    terminal = "screen-256color";
    extraConfig = ''
      set-option -sg escape-time 10
      set-option -g default-terminal "screen-256color"
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key J resize-pane -D 5
      bind-key K resize-pane -U 5
      bind-key H resize-pane -L 5
      bind-key L resize-pane -R 5

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
      | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
      "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
      "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
    '';
  };
 
  home.file.".config/nvim/" = {
    source = ./../ide/nvim;
    recursive = true;
  };

  home.file.".config/i3/" = {
    source = ./../terminal/i3;
    recursive = true;
  };

}
