# make sure terraform CLI is installed
terraform

# initialize terraform Azure modules
terraform init

# plan and save the infra changes into tfplan file
terraform plan -out tfplan

# generate graph for resource dependencies
# we need GraphViz to be installed on the machine
# $ choco install graphviz 
terraform graph | dot -Tsvg > graph.svg

# use Rover CLI or Rover docker container to generate a graph for resources
# $ rover -workingDir "example/myTF_infra"
# in Linux, replace ${pwd} with $(pwd)
docker run --rm -it -p 9000:9000 -v ${pwd}:/src im2nguyen/rover \
           -planPath tfplan
# visualize the generated graph in localhost:9000

# standalone mode generates a rover.zip file containing all the static assets
docker run --rm -it -p 9000:9000 -v ${pwd}:/src im2nguyen/rover \
           -planPath tfplan -standalone true

# apply the infra changes
terraform apply tfplan

# delete the infra
terraform destroy

# cleanup files
rm terraform.tfstate
rm terraform.tfstate.backup
rm tfplan
rm tfplan.json
rm -r .terraform/