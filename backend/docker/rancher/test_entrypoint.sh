#!/usr/bin/env bash

cd /var/www/ol/backend
rm -r vendor
composer install -o --prefer-dist
bin/console cache:clear --env=prod
bin/console cache:warmup --env=prod
bin/console assets:install --symlink
bin/console doctrine:schema:update -f
chown -R www-data:www-data /var/www/ol/backend/var
chown -R www-data:www-data /var/www/ol/backend/app/uploads
phing generate-jwt-keys
apache2-foreground
