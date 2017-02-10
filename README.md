# CS3028 Team Charlie
Charlie team repository, _Law in the Aberdeen Council Registers 1398-1511_

The repository structure is roughly modelled on the structure of GNU coreutils, in the hope that it's familiar, with a few changes:

## Getting Started
Install [Docker](https://docs.docker.com/engine/installation/)
- [Debian](https://docs.docker.com/v1.12/engine/installation/linux/debian/)
- [Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04#step-1-—-installing-docker)
- [Linux Mint](http://linuxbsdos.com/2016/12/13/how-to-install-docker-and-run-docker-containers-on-linux-mint-1818-1/)
- [Arch linux](https://wiki.archlinux.org/index.php/Docker#Installation)

Install [docker-compose](https://docs.docker.com/compose/install/)
- Using pip
```sh
pip install docker-compose
```
Navigate to `CS3028-CHARLIE/src` and execute `start`
```sh
cd src
./start
```

## Repository contents:
* /coursework
  Contains the coursework for the project
  * /coursework/Presentations
    Contains any presentations we may give

* /doc

  Project documentation - the "user-facing" documentation - how things work, etc

* /doc-internal
  Internal-use documentation - documentation for use whilst building the project - TEI documentation, for example
  * /doc-internal/TEI

    Internal documentation pertaining to TEI

    * /doc-internal/TEI/Guidlines.pdf

      The official TEI Guidlines

    * /doc-internal/TEI/TEI.table

      A table of the TEI tags we'll be using in the project

* /src

  Project source code
