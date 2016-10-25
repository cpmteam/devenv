set -e

# generate login and password
LOGIN=`date | md5sum | head -c16`
PASSWORD=`date | md5sum | head -c16`
printf "[admins]\n$LOGIN = $PASSWORD\n" > /usr/local/etc/couchdb/local.d/cpm-couchapp-install.ini

# (HOME=/var/lib/couchdb; cd /tmp && exec gosu couchdb couchdb -b); wait
(HOME=/var/lib/couchdb; cd /tmp && couchdb -b -o /tmp/couchdberror.log ); wait

COUCHDBURL="http://$LOGIN:$PASSWORD@localhost:5984"

echo COUCHDBURL - $COUCHDBURL

cd /usr/src/cpm-registry-couchapp
echo "npm-registry-couchapp:couch=$REGISTRY/registry" > .npmrc

# fix for no-auth
sed -i 's/\([[:blank:]]*\)"\${auth\[@\]}" \\/\1${auth[@]} \\/' copy.sh

# attempt to connect to couchdb for 5ish seconds
ATTEMPTS=5
while ! curl -sX GET "$COUCHDBURL/_users/" > /dev/null; do
  #(( ATTEMPTS-- ))
  ATTEMPTS=`expr $ATTEMPTS - 1`
  if [ $ATTEMPTS -eq 0 ]; then
    echo "$LINENO: Failed to connect to couchdb."
    exit 1
  fi
  sleep 1
done

RESULT=`curl -s -w "%{http_code}" -X PUT $COUCHDBURL/registry -o /dev/null`
if [ "$RESULT" != "201" ] && [ "$RESULT" != "412" ]; then
  echo "$LINENO: Unable to create database \"registry\". Server responded with status code $RESULT."
  exit 1
fi

# export DEPLOY_VERSION=v$NPM_REGISTRY_COUCHAPP_VERSION

# npm start
# npm run load
# NO_PROMPT=1 npm run copy

echo "Replicating remote database"
RESULT=`curl -s -w "%{http_code}" -H 'Content-Type: application/json' -d '{"source":"https://couchdb-86507a.smileupps.com/registry/","target":"registry"}' -X POST $COUCHDBURL/_replicate -o /dev/null` 
if [ "$RESULT" != "200" ]; then
  echo "$LINENO: Unable to replicate remote database \"registry\". Server responded with status code $RESULT."
  exit 1
fi
echo "  Complete"

chown -R couchdb:couchdb /data

# (HOME=/var/lib/couchdb; cd /tmp && exec gosu couchdb couchdb -d); wait
(HOME=/var/lib/couchdb; cd /tmp && couchdb -d); wait

cat /tmp/couchdberror.log
rm /tmp/couchdberror.log
# delete temporary password
rm /usr/local/etc/couchdb/local.d/cpm-couchapp-install.ini
