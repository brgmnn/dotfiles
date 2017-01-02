function _git_repo_prompt --description "Returns the git prompt."
    echo -s (_git_last_commit)" "(_git_branch_name);
    echo -s (_git_dirty);
end
