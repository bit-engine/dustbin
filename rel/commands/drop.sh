#!/bin/bash

sudo -u postgres dropdb "${DUSTBIN_DB_NAME}" &&
sudo -u postgres dropuser "${DUSTBIN_DB_USERNAME}" &&
echo "The database '${DUSTBIN_DB_NAME}' and role '${DUSTBIN_DB_USERNAME}' have been dropped."
