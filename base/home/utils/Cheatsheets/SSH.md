--- Server Commands
# Install ssh
apt update
apt install openssh-server

# Enable ssh service to start after reboot
systemctl enable ssh

# Start service to start now
systemctl start ssh

# Check status
systemctl status ssh = Check status
	
# Configure ssh
FILE: /etc/ssh/sshd_config
```
PermitRootLogin no           # Disable root login for security
PubkeyAuthentication yes     # Enable public key authentication
PasswordAuthentication yes   # (Optional) Allow passwords initially for debugging
```

--- Client Commands

# Connect to a user in the host machine(IP or address)
ssh user@host
