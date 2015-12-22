function _git_is_submodule --description "Checks if we are in a git submodule."
    not test -r (git rev-parse --show-toplevel ^&-)"/.git/config"
end
