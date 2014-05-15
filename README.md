
# build the main image

```
docker build -t cjlyth/ssh cjlyth/ssh
```

# create a dockerfile in $HOME/.ssh

```
cat > $HOME/.ssh/Dockerfile <<'EOF'
FROM cjlyth/ssh

EXPOSE 1389
CMD ["ssh", "-vv", "-N", "ldap"]
EOF
```


# build the local image with our ssh configs

```
docker build -t ssh_env $HOME/.ssh
```


# Stop and start the containers

```
docker stop tb_containers_ssh 2> /dev/null | xargs --no-run-if-empty docker rm
gateway=$(netstat -nr | grep -E -e "^0.0.0.0" -e "default" | awk {'print $2'})

docker run -d -P \
  --name "tb_containers_ssh" \
  --dns=$gateway \
  --dns=8.8.8.8 \
  --dns=8.8.4.4 \
  --dns=127.0.0.1 \
  ssh_env
```


