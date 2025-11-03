# Show all network interfaces and their IP addresses
ip a

# Display and configure network interface details (use ip a instead)
ifconfig

# Show the kernel IP routing table in a user-friendly format
route -n

# Alias - Displays all IP addresses associated with the host
ipinfo

# Traces the route packets take to reach a specific destination, showing hops along the way
traceroute <site/ip>

# Queries DNS servers to resolve hostnames to IP addresses or vice versa
nslookup <site/ip>

# Advanced DNS lookup tool compared to nslookup, offering detailed information about DNS records
dig <site/ip>

# Alias - Display listening ports
ports

# Provides information about network sockets similar to netstat but with a more structured and process-oriented view
ss
