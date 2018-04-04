#!/bin/sh
# [[ ]] requires bash
set -ev # https://docs.travis-ci.com/user/customizing-the-build/

composer create-project --no-install symfony/website-skeleton
cd website-skeleton
cp ../.env.dist . # Needs apparently to be done before install.
composer install
install --directory config # Is it really needed?
# composer require symfony/yaml # in symfony/website-skeleton
# composer require symfony/console # in symfony/website-skeleton
# composer require symfony/twig-bundle # in symfony/website-skeleton
# composer require sensio/framework-extra-bundle # in symfony/website-skeleton
# composer require symfony/orm-pack # in symfony/website-skeleton
# composer require symfony/swiftmailer-bundle # in symfony/website-skeleton
# composer require symfony/security-csrf
cp ../config/packages/*.yaml config/packages
cp ../config/routes/*.yaml config/routes
composer require friendsofsymfony/user-bundle

cp ../src/Entity/*.php src/Entity # May be done earlier.
console doctrine:database:create
console doctrine:migrations:diff --quiet
console doctrine:migrations:migrate --no-interaction --quiet
# console doctrine:schema:update --force
composer require doctrine/doctrine-fixtures-bundle --dev

console assets:install --symlink
