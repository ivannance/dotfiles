function repos
    ssh mini "ls /DATA/repos" | sed 's/\.git//'
end
