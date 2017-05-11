clear
reset

# Call the local .bash_logout
if [ -f "~/.bash_logout.local" ]; then
    . "~/.bash_logout.local"
fi
