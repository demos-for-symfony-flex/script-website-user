<?php

namespace App\DataFixtures;

use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\Persistence\ObjectManager;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager)
    {
        $user = new User();
        $user->setUsername('superadmin');
        $user->setEmail('superadmin@example.org');
        $user->setEnabled(true);
        $user->setPassword('superadmin');
        $user->setSuperAdmin(true);
        $manager->persist($user);

        $manager->flush();
    }
}
