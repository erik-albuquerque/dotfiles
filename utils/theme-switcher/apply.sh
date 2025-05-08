#!/bin/bash
set -euo pipefail


# USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
USER_HOME="$HOME"

current_hour=$(date +'%H')
default_cursor="KDE_Classic"
kitty_config="$USER_HOME/.config/kitty/kitty.conf"
vscode_config="$USER_HOME/.config/Code/User/settings.json"
sddm_theme_path="/usr/share/sddm/themes/kubuntu"
sddm_config="${sddm_theme_path}/theme.conf"
lock_screen_config="$USER_HOME/.config/kscreenlockerrc"

light_theme=(
    "org.kde.breeze.desktop"
    "BreezeWhite" # Breeze White by aroun
    "Stylish-Light" # Stylish icon theme by MJ 
    "$PWD/wallpaper/light.jpg"
    "$PWD/kitty/kitty-light.conf"
    "Min Light" # VSCode theme: Min theme
)

dark_theme=(
    "org.kde.breezedark.desktop"
    "Material Theme Dark" # Custom Material Theme Dark (find in dotfiles)
    "Stylish-Dark" # Stylish icon theme by MJ
    "$PWD/wallpaper/dark.jpg"
    "$PWD/kitty/kitty-dark.conf"
    "Min Dark" # VSCode theme: Material Theme - Free
)

error() {
    echo "Error: $1" >&2
    exit 1
}

# check_root() {
#     if [ "$EUID" -ne 0 ]; then
#         error "This script must be run as root. Please run white syudo."
#     fi
# }

check_dependencies() {
    required_cmds=("plasma-apply-lookandfeel" "plasma-apply-colorscheme" "plasma-apply-wallpaperimage" "plasma-apply-cursortheme")
    for cmd in "${required_cmds[@]}"; do
        command -v "$cmd" &> /dev/null || error "'$cmd' is required but not installed."
    done
}

select_theme() {
    if [ "$current_hour" -ge 6 ] && [ "$current_hour" -lt 18 ]; then
        theme=("${light_theme[@]}")
    else
        theme=("${dark_theme[@]}")
    fi
}

apply_system_theme() {
    plasma-apply-lookandfeel --apply "${theme[0]}"
    plasma-apply-colorscheme "${theme[1]}"
    /usr/lib/x86_64-linux-gnu/libexec/plasma-changeicons "${theme[2]}"
    plasma-apply-wallpaperimage "${theme[3]}"
}

apply_kitty_theme() { cp "${theme[4]}" "$kitty_config"; }

apply_cursor_theme() { plasma-apply-cursortheme "$default_cursor"; }

apply_vscode_theme() {
    cp "$vscode_config" "$vscode_config.bak"

    grep -q '"workbench.colorTheme"' "$vscode_config" &&
        sed -i "s|\"workbench.colorTheme\": *\"[^\"]*\"|\"workbench.colorTheme\": \"${theme[5]}\"|" "$vscode_config" ||
        sed -i "1s|^|{\"workbench.colorTheme\": \"${theme[5]}\",\n|" "$vscode_config"
}

change_sddm_wallpaper() {
    wallpaper_path="${theme[3]}"
    wallpaper_filename=$(basename "$wallpaper_path")

    [[ -f "$wallpaper_path" ]] || error "Wallpaper not found at $wallpaper_path"
    
    sudo cp "$wallpaper_path" "$sddm_theme_path"
    
    [[ -f "$sddm_config" ]] || error "SDDM configuration file not found"
    
    if grep -q "^background=" "$sddm_config"; then
        sudo sed -i "s|^background=.*|background=${wallpaper_filename}|" "$sddm_config"
    else
        echo "background=${wallpaper_filename}" | sudo tee -a "$sddm_config" > /dev/null
    fi
}

change_lock_screen_wallpaper() {
    wallpaper_path="${theme[3]}"

    [[ -f "$wallpaper_path" ]] || error "Wallpaper not found at $wallpaper_path"
    
    [[ -f "$lock_screen_config" ]] || echo "[Greeter]" > "$lock_screen_config"
    
    for key in "Image" "PreviewImage"; do
        grep -q "^${key}=" "$lock_screen_config" &&
            sed -i "s|^${key}=.*|${key}=${wallpaper_path}|" "$lock_screen_config" ||
            echo "${key}=${wallpaper_path}" >> "$lock_screen_config"
    done
}

# check_root
check_dependencies
select_theme
apply_system_theme
apply_kitty_theme
apply_cursor_theme
apply_vscode_theme
change_sddm_wallpaper
change_lock_screen_wallpaper

echo "Theme Configuration Applied:"
echo "  - OS Theme        : ${theme[0]}"
echo "  - Color Scheme    : ${theme[1]}"
echo "  - Icon Theme      : ${theme[2]}"
echo "  - Cursor Theme    : $default_cursor"
echo "  - Wallpaper       : ${theme[3]}"
echo "  - Login Screen (SDDM) Wallpaper  : ${theme[3]}"
echo "  - Lock Screen Wallpaper          : ${theme[3]}"
echo "  - Kitty Theme     : ${theme[4]}"
echo "  - VSCode Theme    : ${theme[5]}"
