function repos
    ssh homeserver "ls /DATA/repos" | sed 's/\.git//'
end
