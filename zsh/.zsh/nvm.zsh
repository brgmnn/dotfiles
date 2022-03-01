#       Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"

# This loads nvm
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# place this after nvm initialization!
autoload -U add-zsh-hook

# Automatically load the correct node version when changing directory. This is a stripped down
# version of one more commonly seen in other files that only checks the current directory rather
# than any nvmrc file in the file path. This is to keep cd's fast when switching subdirectories
# within a project folder.
load-nvmrc() {
    # local nvmrc_path="$(nvm_find_nvmrc)"

    if [[ -e .nvmrc ]]; then
        local node_version="$(nvm version)"
        local nvmrc_node_version=$(nvm version "$(cat .nvmrc)")

        if [[ "$nvmrc_node_version" = "N/A" ]]; then
            echo "Node $nvmrc_node_version is missing. Install with: nvm install"
        elif [[ "$nvmrc_node_version" != "$node_version" ]]; then
            nvm use
        fi
    fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
