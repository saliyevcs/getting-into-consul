


#1 run command in consul server 
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install consul
consul -v

#systemd -> continuos process (run it in a background) -> to run consul agent  
sudo cat /usr/lib/systemd/system/consul.service
[Unit]
Description="HashiCorp Consul - A service mesh solution"
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.hcl

[Service]
Type=notify
EnvironmentFile=-/etc/consul.d/consul.env
User=consul
Group=consul
ExecStart=/usr/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGTERM
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target

--------
# Modify the default consul.hcl file
sudo vim /etc/consul.d/consul.hcl
data_dir = "/opt/consul"
client_addr = "0.0.0.0"
ui_config{
  enabled = true
}
server = true
bind_addr = "0.0.0.0"
advertise_addr = "{{ GetInterfaceIP `ens5` }}"
bootstrap_expect=1

sudo systemctl start consul
consul members 
curl http://127.0.0.1:8500/v1/status/leader
----------------------

#client
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install consul

sudo vim /etc/consul.d/consul.hcl
data_dir = "/opt/consul"
client_addr = "0.0.0.0"
server = false
bind_addr = "0.0.0.0"
advertise_addr = "{{ GetInterfaceIP `ens5` }}"
retry_join = ["consul-server-private-IP-address"]

sudo systemctl start consul




cat /etc/consul.d/consul.hcl | grep -v "#"
