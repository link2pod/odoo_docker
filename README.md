# Setup Dev Environment
If you didn't clone the submodule `./addons/` then either 
- reclone this repo with  `git clone --recurse-submodules git@github.com:link2pod/odoo_docker.git`
- or using https: `git clone --recurse-submodules https://github.com/link2pod/odoo_docker.git`
- or clone the submodule with `git submodule update --init --recursive`

Update submodules: `git submodule update --remote --merge`

Edit the CSS_BASE_URL in the [.env](https://github.com/link2pod/odoo_addons/blob/3d8bd734df107aed64be3d6846866d538925c43d/solid/controllers/auth_signup_home.py#L66) for the addon

Run `docker compose up`. On browser, visit [http://localhost:10015](http://localhost:10015/)

To stop, run `docker compose down`

To setup the solid module, follow tutorial at [https://www.link2.ca/knowledge/article/14](https://www.link2.ca/knowledge/article/14)

For more details, reference [Start individual containers](#start-individual-containers)

# Start individual containers
## Start postgres server
Pull docker image: 
```bash
docker pull postgres:15
``` 
Start docker image: 
```bash
docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db postgres:15
```
## Start odoo server
Pull docker image: 
```bash
docker pull odoo:16 
``` 
Start docker image: 
```bash
docker run -p 8069:8069 --name odoo --link db:db -t odoo
```

Run addons 
```bash
docker run -v $(pwd)/addons:/mnt/extra-addons -p 8069:8069 --name odoo --link db:db -t odoo
```

Run in dev mode 
```bash
docker run --rm -v  $(pwd)/addons:/mnt/extra-addons -p 8069:8069 --name odoo --link db:db -t odoo --dev=all
```

# Debugging 
## Database
Enter database container
```bash
docker exec -it db bash 
```
Query postgres database inside container (assume database was named testdb at setup)
```bash 
psql testdb -U odoo 
```
Useful database commands 
`\d` `\d res.users` `select web_id from res.users;`

Inspect odoo std-out logging: 
```bash
docker start -i odoo
```
## Docker network 
```bash 
docker network inspect bridge
```



