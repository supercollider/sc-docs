# SuperCollider documentation

The aim of this repository is to provide a transparent and semi-official way of deploying the documentation of SuperCollider into the web.

* [x] Changes source code links to the hosted files on GitHub
* [x] Stays automatically up-to-date and makes the build process transparent
* [x] Allows for CSS patches which creates a better UX on bigger screens (see `custom.css`)

Currently this only includes the documentation of the sclang core and not any Extensions.
Feel free to create a Pull Request to include any 

## Build

Although the docs are deployed via GitHub Pages and Actions, the build process happens within a Docker container which allows local testing as well as allowing for porting to other hosting platforms.

Start by building the container

```shell
docker build -t scdocs .
```

and then execute it, where `/root/scdocs` will be the output dir within the container for the docs, so it is necessary to mount this directory on the host machine.

```shell
docker run -v ${PWD}/build:/root/scdocs scdocs /root/build_docs.sh
```

> The generated build files will be owned by the root user, so modifying
> them requires sudo rights!
> 
> Use `sudo chown -R $USER build` to transfer ownership to the host user.

To access the docs in a webserver way it is possible to use a lightweight development web server via Python

```
cd build && python3 -m http.server
```

which will make the docs available under <http://localhost:8000>.

To make a clean build use `rm -rf build`.

Make sure to re-build the Docker image in case any files such as `build_docs.sh` or `custom.css` are changed because they are included during build time.

## License

This repository uses the GPL3 license.

SuperCollider is free software published under the GPL: Licensing.

The help files are published under the Creative Commons CC-BY-SA-3 license.
