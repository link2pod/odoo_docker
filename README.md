# Setup Dev Environment
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
docker run -v $(pwd)/modules:/mnt/extra-addons -p 8069:8069 --name odoo --link db:db -t odoo
```

Run in dev mode 
```bash
docker run --rm -v  $(pwd)/modules:/mnt/extra-addons -p 8069:8069 --name odoo --link db:db -t odoo --dev=all
```

# Debugging 
## Database
Enter database container
```bash
docker exec -it odoo bash 
```
Query postgres database inside container (assume database was named testdb at setup)
```bash 
psql testdb -U odoo 
```
Useful database commands 
`\d` `\d res.users` `select web_id from res.users;`

## Docker network 
```bash 
docker network inspect bridge
```


