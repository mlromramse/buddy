if [[ $# == 0 ]]; then
	echo "usage:  cat file-with-ip-numbers | $0 file-to-copy"
	exit 0;
fi

if [ -z ${PRIVATE_KEY_FILE+x} ]; then
	echo "This script needs the environment variable PRIVATE_KEY_FILE to be set to"
	echo "the location of the private key used to reach your amazon server."
	echo "Please enter 'export PRIVATE_KEY_FILE=/the/path/to/the/private/key'"
	exit 0;
fi

while read row
do
	echo "Copy $1 to '$row'"
	scp -i "$PRIVATE_KEY_FILE" -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $1 "admin@$row:."
done