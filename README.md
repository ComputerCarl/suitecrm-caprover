# SuiteCRM for CapRover

Test Dockerfile deploy of SuiteCRM on CapRover

A MySQL instance must be created and settings still must be manually added to CapRover.

Use `MySQL` One-Click App to create the database.

Create another app based off of this repo.;
* Has Persistent Data
* Add the following volumes;
  * /var/www/html
  * /var/spool/cron/crontabs
  * /usr/local/etc/php - only if you later need to make changes

Needed to add `nano` to install so I can run `crontab -e -u www-data` after install.