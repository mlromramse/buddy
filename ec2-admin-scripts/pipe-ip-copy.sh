if [[ $# == 0 ]]; then
	echo "usage:  cat file-with-ip-numbers | $0 file-to-copy"
	exit 0;
fi

while read row
do
	echo "Copy $1 to '$row'"
	scp -i "$PRIVATE_KEY_FILE" -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $1 "admin@$row:."
done