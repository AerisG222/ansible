#!/bin/bash

ansible-playbook \
    --ask-become-pass \
    --inventory inventories/inventory_test.yml \
    playbook_ddclient.yml
