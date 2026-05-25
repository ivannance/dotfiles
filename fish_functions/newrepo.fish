function newrepo
    ssh mini "git init --bare /DATA/repos/$argv[1].git"
    git init
    # Add the absolute path here:
    git remote add origin mini:/DATA/repos/$argv[1].git
    echo "# $argv[1]" >README.md
    git add . && git commit -m init
    git push -u origin main
end
