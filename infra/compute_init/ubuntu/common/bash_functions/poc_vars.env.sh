#!/bin/bash

# Set environment variables using .env file
# -a means that every bash variable would become an environment variable
# Using ‘+’ rather than ‘-’ causes the option to be turned off
set -a
source "$CYBR_POC_PATH/poc_vars.env"
set +a
