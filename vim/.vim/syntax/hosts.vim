" Hosts file syntax highlighting
" Language: /etc/hosts
" Maintainer: Daniel Bergmann
" Last Change: 14-March-2016

if exists('b:current_syntax')
    finish
endif

syn match hosts_comment "#.*$"
syn match hosts_comment "\/\*.*\*\/"
syn match hosts_ipv4    "\v^([0-9]{1,3}\.){3}[0-9]{1,3}"
syn match hosts_ipv6    "\v^[a-fA-F0-9:]*:[a-fA-F0-9:]+"
syn match hosts_domain  "\v[a-zA-Z0-9\.\-]+$"

hi def link hosts_ipv4    Type
hi def link hosts_ipv6    Keyword
hi def link hosts_domain  String
hi def link hosts_comment Comment
