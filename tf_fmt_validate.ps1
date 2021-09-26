# /bin/bash

tf_folders=(stage0 stage1 stage3 stage4)
for d in "${tf_folders[@]}" ; do
    echo "$d ---------------------------------"
    cd $d
    echo "terraform fmt"
    terraform fmt
    # echo "terraform init"
    # terraform init
    # echo "terraform plan -out tfplan"
    # terraform plan -out tfplan
    # echo "terraform validate"
    # terraform validate
    cd ..
done