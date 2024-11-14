#!/bin/sh

rm -rf output_prod/
git clone --depth=1 https://github.com/phpes-org/phpes-org.github.io.git output_prod
cd output_prod/
git pull origin master
cd ../
vendor/bin/sculpin generate --env=prod
cd output_prod/
git add -A
git commit -m 'site update'
git push origin master
