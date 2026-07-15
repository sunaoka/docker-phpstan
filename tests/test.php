<?php

class Test
{
    /**
     * @template T
     * @param T $args
     * @return T
     *
     * @phpstan-ignore shipmonk.deadMethod
     */
    function foo($args)
    {
        return $args;
    }
}
