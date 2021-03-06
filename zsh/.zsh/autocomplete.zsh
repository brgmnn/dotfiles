#!/bin/zsh

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna clamav \
    daemon dbus distcache dnsmasq dovecot fax ftp games gdm gkrellmd gopher \
    hacluster haldaemon halt hsqldb ident junkbust kdm ldap lp mail mailman \
    mailnull man messagebus mldonkey mysql nagios named netdump news \
    nfsnobody nobody nscd ntp nut nx obsrun openvpn operator pcap polkitd \
    postfix postgres privoxy pulse pvm quagga radvd rpc rpcuser rpm rtkit \
    scard shutdown squid sshd statd svn sync tftp usbmux uucp vcsa wwwrun \
    xfs '_*'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts \
    'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

