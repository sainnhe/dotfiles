#!/usr/bin/env bash

cd ~/.mozilla/firefox/*.dev-edition-default || exit
git clone https://github.com/sainnhe/minimal-functional-fox.git chrome
cd chrome || exit
git checkout forest-night

echo 'In `about:config`,'
echo 'Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.'
