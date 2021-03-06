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