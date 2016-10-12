#!/bin/bash
git checkout .
git pull origin master
/etc/init.d/bookstore.inclouds.com.ua stop
rm -Rf ./public/assets
RAILS_ENV=production bin/rake assets:precompile
RAILS_ENV=production bin/rake db:migrate
/etc/init.d/bookstore.inclouds.com.ua start
