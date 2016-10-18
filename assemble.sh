#!/bin/bash

# helper json function
function getJsonVal () {
    python -c "import json,sys;obj=json.load(sys.stdin);print obj['$1'];"
}

# check if docroot is present
if [ -d "docroot" ]; then
    # if yes, then check the if drupal code base is there and is version Drupal 8.x
    cd docroot
    DRUPALVERSION=`drush status --format=json | getJsonVal "drupal-version"`
    cd ..
    if [[ $DRUPALVERSION == 8* ]]; then
        # if yes, then run composer update
        echo "Initiating Composer Update"
        composer update --no-interaction
        echo "Composer Update Completed"
    else
        # if not, then that is not the correct docroot content. Delete it and run install.
        echo "Cleanup docroot for fresh install"
        rm -rf docroot
    fi
fi

# if docroot is not present initially or post delete, then run install
if [ ! -d "docroot" ]; then
    echo "Initiating Composer Install"
	composer install --no-interaction
	cd vendor
	npm install less
	cd ..
    echo "Complete Composer Install"
fi
