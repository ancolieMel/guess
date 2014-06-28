<?php

namespace Guess\UserBundle;

use Symfony\Component\HttpKernel\Bundle\Bundle;

class GuessUserBundle extends Bundle
{
    public function getParent()
    {
        return 'FOSUserBundle';
    }
}
