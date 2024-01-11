#!/bin/bash

# Set environment variables using .env file
# -a means that every bash variable would become an environment variable
# Using ‘+’ rather than ‘-’ causes the option to be turned off
set -a
source "$HOME/cybrlab/demos/demo_vars.env"
set +a
