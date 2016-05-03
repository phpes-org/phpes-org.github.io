#!/bin/sh

git clone --depth=1 http://github.com/phpes-org/phpes-org.github.io.git output_prod
cd output_prod/
git pull origin master
cd ../
sculpin generate --env=prod
cd output_prod/
git add -A
git commit -m 'site update'
git push origin master
