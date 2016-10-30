## Development Environment for CPM
This Development Environment shoudl include Web server for main website, and for the registry with CPM packages.

#### Requirements 
- docker 1.12+
- docker-compose
- free tcp 80 port

#### Installation and start
```
git clone --recursive git@github.com:cpmteam/devenv.git
cd devenv
docker-compose build
docker-compose up -d
```

After after, will be available some resources
- http://www.127.0.0.1.xip.io/ - main website
- http://registry.127.0.0.1.xip.io/ - registry with cpm packages, replicated from public one, at the build stage
- http://localhost:5984/_utils/ - Futon portal for CouchDB (admin/admin)

As well as a plain http available access via SSL, in this case will be used generated at the build stage ssl certificate.
