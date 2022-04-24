#!/bin/bash
# XRay Installation
# Coded By DIYVPN
# ==================================

# // Update & Installing Requirement
apt update -y
apt upgrade -y
apt install socat -y
apt install python -y
apt install curl -y
apt install wget -y
apt install sed -y
apt install nano -y
apt install python3 -y

# // Make Main Directory
mkdir -p /usr/local/pakya/

# // grpc addon by @izhanV
domain=$(cat /etc/v2ray/domain)
cd /usr/local/pakya/
mkdir –m777 grpc
cd
mkdir /usr/local/pakya/grpc

cd /usr/bin
wget -O port-trgrpc "https://raw.githubusercontent.com/Diyserver/new/main/port-trgrpc.sh"
chmod +x port-trgrpc

wget -O port-grpc "https://raw.githubusercontent.com/Diyserver/new/main/port-grpc.sh"
chmod +x port-grpc 

wget -O menu-grpc "https://raw.githubusercontent.com/Diyserver/new/main/menu-grpc.sh"
chmod +x menu-grpc
cd



# // Installation XRay Core
wget -q -O /usr/local/pakya/xray-mini "https://raw.githubusercontent.com/Diyserver/new/main/xray-mini" 
chmod +x /usr/local/pakya/xray-mini

# // Make XRay Mini Root Folder
mkdir -p /etc/xray-mini/
chmod 775 /etc/xray-mini/

# // Installing XRay Mini Service
cat > /etc/systemd/system/xray-mini@.service << EOF
[Unit]
Description=XRay-Mini Service ( %i )
Documentation=https://wildyproject.com https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/pakya/xray-mini -config /etc/xray-mini/%i.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

# // String
ssl_path_crt="/etc/v2ray/v2ray.crt"
ssl_path_key="/etc/v2ray/v2ray.key"
Port1=6769
Port2=6769
uuid=$(cat /proc/sys/kernel/random/uuid)

# // Vless Splice
cat > /etc/xray-mini/vless-splice.json << END
{
  "inbounds": [
    {
      "port": ${Port1},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-splice"
#XRay
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 60000,
            "alpn": "",
            "xver": 1
          },
          {
            "dest": 60001,
            "alpn": "h2",
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "${ssl_path_crt}",
              "keyFile": "${ssl_path_key}"
            }
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
END

# // Vless Direct
cat > /etc/xray-mini/vless-direct.json << END
{
  "inbounds": [
    {
      "port": ${Port2},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-direct"
#XRay
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 60000,
            "alpn": "",
            "xver": 1
          },
          {
            "dest": 60001,
            "alpn": "h2",
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "${ssl_path_crt}",
              "keyFile": "${ssl_path_key}"
            }
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
END

# // grpc addon by @izhanV
cat > /etc/systemd/system/trgrpc.service << EOF
[Unit]
Description=XRay Trojan Grpc Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/pakya/xray-mini -config /usr/local/pakya/grpc/trojangrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000
[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/vless-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/pakya/xray-mini -config /usr/local/pakya/grpc/vlessgrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000
[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/vmess-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/pakya/xray-mini -config /usr/local/pakya/grpc/vmessgrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000
[Install]
WantedBy=multi-user.target
EOF

cat > /usr/local/pakya/grpc/vmessgrpc.json << EOF
{
    "log": {
#            "access": "/var/log/xray/access5.log",
#        "error": "/var/log/xray/error.log",
#        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 800,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vmessgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "${ssl_path_crt}",
                            "keyFile": "${ssl_path_key}"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
EOF

cat > /usr/local/pakya/grpc/vlessgrpc.json << EOF
{
    "log": {
#            "access": "/var/log/xray/access5.log",
#        "error": "/var/log/xray/error.log",
#        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 880,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vlessgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "${ssl_path_crt}",
                            "keyFile": "${ssl_path_key}"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
EOF

cat > /usr/local/pakya/grpc/trojangrpc.json << EOF
{
    "log": {
#            "access": "/var/log/xray/access5.log",
#        "error": "/var/log/xray/error.log",
#        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 653,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "${uuid}"
#xtrgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "$domain",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "${ssl_path_crt}",
                            "keyFile": "${ssl_path_key}"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
EOF

cat > /usr/local/pakya/grpc/akuntrgrpc.conf << EOF
#xray-mini-trojangrpc user
EOF


# // grpc addon by @izhanV
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 653 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 800 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 653 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 800 -j ACCEPT

iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload

# // grpc addon by @izhanV
systemctl enable trgrpc.service
systemctl start trgrpc.service
systemctl enable vless-grpc.service
systemctl start vless-grpc.service
systemctl enable vmess-grpc.service
systemctl start vmess-grpc.service
systemctl start xray-mini@.service

# // Enable & Start Service
systemctl enable xray-mini@vless-direct
systemctl start xray-mini@vless-direct
systemctl enable xray-mini@vless-splice
systemctl start xray-mini@vless-splice

# // grpc addon by @izhanV
cd /usr/bin
wget -O addgrpc "https://raw.githubusercontent.com/Diyserver/new/main/addgrpc.sh"
wget -O delgrpc "https://raw.githubusercontent.com/Diyserver/new/main/delgrpc.sh"
wget -O cekgrpc "https://raw.githubusercontent.com/Diyserver/new/main/cekgrpc.sh"
wget -O renewgrpc "https://raw.githubusercontent.com/Diyserver/new/main/renewgrpc.sh"

wget -O addtrgrpc "https://raw.githubusercontent.com/Diyserver/new/main/addtrgrpc.sh"
wget -O deltrgrpc "https://raw.githubusercontent.com/Diyserver/new/main/deltrgrpc.sh"
wget -O cektrgrpc "https://raw.githubusercontent.com/Diyserver/new/main/cektrgrpc.sh"
wget -O renewtrgrpc "https://raw.githubusercontent.com/Diyserver/new/main/renewtrgrpc.sh"

chmod +x addgrpc
chmod +x delgrpc
chmod +x cekgrpc
chmod +x renewgrpc

chmod +x addtrgrpc
chmod +x deltrgrpc
chmod +x cektrgrpc
chmod +x renewtrgrpc
cd



# // Downloading Menu
wget -q -O /usr/bin/add-xray "https://raw.githubusercontent.com/Diyserver/new/main/add-xray.sh"
wget -q -O /usr/bin/del-xray "https://raw.githubusercontent.com/Diyserver/new/main/del-xray.sh"
wget -q -O /usr/bin/renew-xray "https://raw.githubusercontent.com/Diyserver/new/main/renew-xray.sh"
chmod +x /usr/bin/add-xray
chmod +x /usr/bin/del-xray
chmod +x /usr/bin/renew-xray

# // Remove Not Used Files
rm -f install-xray.sh

