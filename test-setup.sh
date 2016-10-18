#!/bin/bash
echo "Start Drupal Site Install"
mysql -u root -proot -e "CREATE DATABASE drupal"
cd docroot
/usr/bin/env PHP_OPTIONS="-d sendmail_path=`which true`" ../bin/drush site-install -y --db-url=mysql://root:root@127.0.0.1:3306/drupal
php -S 127.0.0.1:8081 &
sleep 4
cd ..
echo "Completed Drupal Site Install"