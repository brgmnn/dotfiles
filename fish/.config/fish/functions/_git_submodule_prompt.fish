function _git_submodule_prompt --description "Returns the git submodule prompt."
    echo -s "git"(set_color 666666)":submodule"(set_color normal)" ";
    echo -s (_git_last_commit)" "(_git_branch_name);
end
