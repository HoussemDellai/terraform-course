# https://www.checkov.io
# https://www.checkov.io/1.Introduction/Getting%20Started.html

# install Checkov from pypi using pip
pip install checkov

# cd into a folder like /13_storage_blob/
cd /13_storage_blob/

# Scan config files in current folder
checkov -d .

# Scan and output compact
checkov -d . --compact

# Scan specific file
checkov -f main.tf --compact

# Export check to json
checkov -d . -o json

# Run checks in Docker container
docker run --tty --volume ./:/tf bridgecrew/checkov --directory /tf --compact

# check the list of resources scan:
# https://github.com/bridgecrewio/checkov/blob/master/docs/3.Scans/resource-scans.md
# or also here: https://www.checkov.io/3.Scans/resource-scans.html