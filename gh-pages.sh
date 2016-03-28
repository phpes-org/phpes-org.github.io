#!/bin/sh

sculpin generate --env=prod
cd output_prod/
git init
git remote add origin git@github.com:phpes-org/phpes-org.github.io.git
git add -A
git commit -m 'site update'
git push origin master
