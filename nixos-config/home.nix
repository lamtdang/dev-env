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
    ];
    shortcut = "z";
    extraConfig = ''
      set-option -sg escape-time 10
      set-option -g default-terminal "screen-256color"
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind-key J resize-pane -D 5
      bind-key K resize-pane -U 5
      bind-key H resize-pane -L 5
      bind-key L resize-pane -R 5
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
