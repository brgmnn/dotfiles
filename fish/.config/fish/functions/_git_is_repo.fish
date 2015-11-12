function _git_is_repo --description "Checks if the current directory is a repo."
    git rev-parse --show-toplevel >/dev/null ^&-;
    and test -r (git rev-parse --show-toplevel)"/.git/config"
end
