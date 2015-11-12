function _git_is_submodule --description "Checks if we are in a git submodule."
    git rev-parse --show-toplevel >/dev/null ^&-;
    and not test -r (git rev-parse --show-toplevel)"/.git/config"
end
