#!/bin/bash

echo "Hello Consul Client Web!"

# Install Consul.  This creates...
# 1 - a default /etc/consul.d/consul.hcl
# 2 - a default systemd consul.service file
# curl -fsSL https://apt.releases.hashicorp.com/gpg -o gpg.txt
# sudo apt-key add gpg.txt
# sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# sudo apt-get update && sudo apt-get install consul
# rm gpg.txt

# # Grab instance IP
# local_ip=`ip -o route get to 169.254.169.254 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'`

# # Modify the default consul.hcl file
# cat > /etc/consul.d/consul.hcl <<- EOF
# data_dir = "/opt/consul"

# client_addr = "0.0.0.0"

# server = false

# bind_addr = "0.0.0.0"

# advertise_addr = "$local_ip"

# retry_join = ["provider=aws tag_key=\"${PROJECT_TAG}\" tag_value=\"${PROJECT_VALUE}\""]
# EOF

# # Start Consul
# sudo systemctl start consul