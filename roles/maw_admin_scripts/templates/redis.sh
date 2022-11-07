#!/bin/bash
podman exec -it {{ maw_as__redis_container }} redis-cli
