SphinxSearch Docker
=========================

Version: **2.2.11**

### Exposed ports

* `9312` for client connections
* `9306` for SQL connections

### Mount points

This image provides some directories for configurations, logs and other files:

* `/var/sphinx/log`
* `/var/sphinx/idx`

All this directories are **data volumes**.

### Scripts

The available scripts are:

* `searchd.sh`, to start `searchd` in the foreground (needed also for real-time indexes)
* `indexall.sh`, to index all the plain indexes (i.e., `indexer --all`) defined in the configuration

## Installation

You can clone this repository and manually build it.

```
cd sphinxsearch
docker build -t sphinxsearch:2.2.11 .
```

## Usage

```
version: '2'
services:
  sphinxsearch:
    image: sphinxsearch:2.2.11
    # build: ./sphinxsearch
    volumes:
      - sphinxsearch_logs:/var/sphinx/log
      - sphinxsearch_index:/var/sphinx/idx
      - ./xmlpipe2:/var/sphinx/xmlpipe2
      - ./config/sphinx.conf:/usr/local/etc/sphinx.conf
    networks:
      - default
    ports:
      - 9306
      - 9312

networks:
  default:
    external:
      name: cenradis

volumes:
  sphinxsearch_logs:
    driver: local

  sphinxsearch_index:
    driver: local
```
