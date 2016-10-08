#!/bin/bash

# start searchd without exiting shell
exec searchd --nodetach "$@"
