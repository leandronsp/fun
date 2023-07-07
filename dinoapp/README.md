# dinoapp
A toy application.

## Playset

- A pure web application using Ruby
- TCP socket
- UNIX programming (socket pair)
- Web fundamentals
- Docker containers
- etc

## Running

```bash
make install.gems
make db.seed
make web.server
```
Open `localhost:3000`. Try out login using the following credentials:

- email: `user@example.com`
- password: `user`

## Deployment in an Ubuntu instance

Setup / provisioning
```bash
make prod.setup instance=<remote-machine>
```

Deploy
```bash
make prod.deploy instance=<remote-machine>
```
