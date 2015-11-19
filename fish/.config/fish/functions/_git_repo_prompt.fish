function _git_repo_prompt --description "Returns the git prompt."
    echo -s "git "(_git_last_commit)" "(_git_branch_name)(_git_dirty);
end
