{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "elixir" "make" "html" ];
    userSettings = {
      assistant = {
        enabled = true;
        version = "2";
        default_model = {
          provider = "copiolot_chat";
          model = "gpt-4o";
        };
      };
      node = {
        path = pkgs.nodejs;
        npm_path = pkgs.nodejs.npm;
      };
      hour_format = "hour24";
      auto_update = false;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [ ".env" "env" ".venv" "venv" ];
            activate_script = "default";
          };
        };
        env = {
          TERM = "kitty";
        };
        font_family = "FiraCode Nerd Font";
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };
      lsp = {
        rust-analyzer = {
          binary = {
            path_lookup = true;
          };
        };
        nixd = {
          binary = {
            path_lookup = true;
          };
        };
        eslint = {

        };
      };
      languages = {
        "Elixir" = {
          language_servers = [ "elixir-ls" ];
          format_on_save = {
            external = {
              command = "mix";
              arguments = [ "format" "--stdin-filename" "{buffer_path}" "-" ];
            };
          };
        };
        "Nix" = {
          language_servers = [ "rnix-lsp" ];
          format_on_save = {
            external = {
              command = "nixpkgs-fmt";
              arguments = [ "--check" "--stdin" ];
            };
          };
        };
      };
      vim_mode = true;
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };
      show_whitespaces = "all";
      ui_font_size = 16;
      buffer_font_size = 16;
    };
  };
}
