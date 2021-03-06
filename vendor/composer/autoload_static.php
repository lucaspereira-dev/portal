<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit1b9cb94084da07159065bec2e610fa8b
{
    public static $prefixLengthsPsr4 = array (
        'R' => 
        array (
            'Router\\' => 7,
            'Resources\\' => 10,
        ),
        'A' => 
        array (
            'App\\' => 4,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Router\\' => 
        array (
            0 => __DIR__ . '/../..' . '/Router',
        ),
        'Resources\\' => 
        array (
            0 => __DIR__ . '/../..' . '/Resources',
        ),
        'App\\' => 
        array (
            0 => __DIR__ . '/../..' . '/App',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit1b9cb94084da07159065bec2e610fa8b::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit1b9cb94084da07159065bec2e610fa8b::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInit1b9cb94084da07159065bec2e610fa8b::$classMap;

        }, null, ClassLoader::class);
    }
}
