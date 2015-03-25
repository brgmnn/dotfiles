syn match fortranComment excludenl "^[!c*].*$" contains=@fortranCommentGroup,@spell
syn match fortranComment excludenl "!.*$" contains=@fortranCommentGroup,@spell
