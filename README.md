# SuperCollider documentation

This repository builds the official documentation of SuperCollider on the web which is located at [docs.supercollider.online](https://docs.supercollider.online).
It is built and deployed every week based on the source files of the latest major version of SuperCollider.

The following enhancements and adjustments have been made to the documentation:

* [x] Links to source files are heading to the source files on GitHub instead of a local copy.
* [x] A CSS patch that limits the screen-width which improves readability on wider screens (see `custom.css`)

The documentation is limited to a vanilla installation of SuperCollider, i.e. without any plugins or Quarks.
The documentation for each Quark can be found at [baryon.supercollider.online](https://baryon.supercollider.online).

This repository contains all the necessary build steps for the documentation and uses [GitHub Pages](https://pages.github.com/) for hosting of the static HTML files.
This could be replaced with any other static file hosting mechanism in the future.

> In case of a new major release update the branch in `Dockerfile`

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

```shell
cd build && python3 -m http.server
```

which will make the docs available under <http://localhost:8000>.

To make a clean build use `rm -rf build`.

Make sure to re-build the Docker image in case any files such as `build_docs.sh` or `custom.css` are changed because they are included during build time.

## License

This repository uses the GPL3 license.

SuperCollider is free software published under the GPL: Licensing.

The help files are published under the Creative Commons CC-BY-SA-3 license.
