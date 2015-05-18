function prompt_long_pwd --description ""
    echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||'
end
