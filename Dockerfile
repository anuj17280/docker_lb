From nginx
VOLUME ["/root/v1:/v1:ro", "/root/v2:/v2:rw"]
CMR ["start.sh"]
