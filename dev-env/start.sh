#!/bin/bash

if [ -z "$SSH_PASSWORD" ]; then
    echo "Error: SSH_PASSWORD is not set. Please provide a password."
    exit 1
fi

echo "root:$SSH_PASSWORD" | chpasswd
echo "SSH password for root is set to: $SSH_PASSWORD"

service ssh start

exec "$@"
