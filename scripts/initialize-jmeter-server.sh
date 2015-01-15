#!/bin/bash
echo "###################################################################"
echo "# initialize-jmeter-server.sh"

# Create activation script
cat > jmeter-server <<EOF_MARKER
#!/bin/bash
#

# Carry out specific functions when asked to by the system
case "\$1" in
  start)
    /opt/apache-jmeter/bin/jmeter-server
    ;;
  stop)
    kill \`ps h -C java -o "%p|%a" |cut -d\| -f1\`
    ;;
  *)
    echo "Usage: /etc/init.d/jmeter-server {start|stop}"
    exit 1
    ;;
esac

exit 0
EOF_MARKER

# Make the script runnable
chmod +x jmeter-server

# Move the script to init.d
sudo mv jmeter-server /etc/init.d/.

# Active autostart and service script of tightvncserver
sudo update-rc.d jmeter-server defaults

