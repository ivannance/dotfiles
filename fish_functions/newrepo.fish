function newrepo
    ssh homeserver "git init --bare /DATA/repos/$argv[1].git"
    git init
    git remote add origin homeserver:repos/$argv[1].git
    echo "# $argv[1]" >README.md
    git add . && git commit -m init
    git push -u origin main
end
