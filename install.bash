#!/bin/sh
# [[ ]] requires bash
set -ev # https://docs.travis-ci.com/user/customizing-the-build/

composer create-project --no-install symfony/website-skeleton $CREATE_PROJECT_DIRECTORY
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
cp ../config/packages/*.yaml config/packages --verbose
cp ../config/routes/*.yaml config/routes --verbose
composer require friendsofsymfony/user-bundle

cp ../src/Entity/*.php src/Entity --verbose # May be done earlier.
bin/console doctrine:database:create
bin/console doctrine:migrations:diff --quiet
bin/console doctrine:migrations:migrate --no-interaction --quiet
# bin/console doctrine:schema:update --force
# composer require doctrine/doctrine-fixtures-bundle --dev
# cp ../src/DataFixtures/AppFixtures.php src/DataFixtures
# bin/console doctrine:fixtures:load --append
bin/console fos:user:create superadmin superadmin@example.com superadmin --super-admin
bin/console fos:user:create user user@example.com user
cp --recursive ../tests . --verbose

bin/console assets:install --symlink
