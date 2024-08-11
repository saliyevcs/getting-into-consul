ssh to bastion->client-api

curl -OL https://github.com/nicholasjackson/fake-service/releases/download/v0.26.2/fake_service_linux_amd64.zip
sudo apt install unzip
mv fake to /usr/local/bin
sudo chmod +x /usr/local/bin/fake-service
which fake-service 
-----------
NAME=api fake-service -> this will run the service how ever we need to put it to systemd
sudo vim /etc/systemd/system/api.service

[Unit]
Description=API
After=syslog.target network.target

[Service]
Environment="MESSAGE=api"
Environment="NAME=api"
ExecStart=/usr/local/bin/fake-service
ExecStop=/bin/sleep 5
Restart=always

[Install]
WantedBy=multi-user.target
---------

sudo systemctl start api -> it picks up /etc/systemd/system/api.service
curl localhost:9090 -> this service listens 9090 

create service defenition 
sudo vim /etc/consul.d/api.hcl
service {
  name = "api"
  port = 9090
}

systemctl restart consul

consul catalog services -> to see all services 
we acan also use api call: curl localhost:8500/v1/agent/services\?pretty

---------
mkdir -p /etc/systemd/resolved.conf.d
sudo vim /etc/systemd/resolved.conf.d/consul.conf
[Resolve]
DNS=127.0.0.1
DNSSEC=false
Domains=~consul


sudo systemctl daemon-reload 

sudo systemctl --version
incase systemd > 245
iptables --table nat --append OUTPUT --destination localhost --protocol udp --match udp --dport 53 --jump REDIRECT --to-ports 8600
iptables --table nat --append OUTPUT --destination localhost --protocol tcp --match tcp --dport 53 --jump REDIRECT --to-ports 8600
sudo systemctl restart systemd-resolved

dig api.service.consul
does not return IP of the node 

it does after iptables added 
iptables -t nat -F -> to delete the iptables

curl api.service.consul:9090