function _git_is_repo --description "Checks if the current directory is a repo."
    set -l toplevel (git rev-parse --show-toplevel ^&-);
    and test -n "$toplevel";
    and test -r "$toplevel/.git/config"
end
