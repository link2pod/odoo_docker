docker kill db css odoo #Stop currently running containers
docker rm db css odoo

# Run Database
# --rm: remove container when stopped
# -d: run in daemon mode
docker run \
    --rm \
    -d \
    -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db postgres:15 

# Run Odoo in dev-mode 
# -v part mounts local addons to docker container 
docker run \
    -v $(pwd)/modules:/mnt/extra-addons \
    -d -p 8069:8069 --name odoo --link db:db odoo \
    --dev=all --log-level=debug # run odoo in dev mode. Remove to run in normal

# Run Community Solid Server 
sudo docker run -d --name css --rm -it --hostname css -e BASEURL=http://172.17.0.4:8000 garendaxe/css

# open odoo container in interactive mode 
docker start -i odoo


