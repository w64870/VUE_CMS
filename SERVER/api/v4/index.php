<?php

use \Mes\App\Helpers\JsonHelper as JsonHelper;
use \Mes\App\Lib\AppStartup as AppStartup;

require __DIR__ . '/../../vendor/autoload.php';

$secret = require __DIR__ . '/../../config/cms_key.php';
$cms_config = require __DIR__ . '/../../config/cms_config.php';
$composer = '../../composer.json';

$startupSettings = array(
	"secret" => $secret, 
	"config_file" => $cms_config, 
	"composer_file" => $composer, 
	"mode" => 'JSON',
	"error_log_file" => __DIR__ . '/../../logs/error.log'
);

AppStartup::run($startupSettings);

$settings = require __DIR__ . '/../../src/JsonView/settings.php';
$app = new \Slim\App($settings);


require __DIR__ . '/../../src/JsonView/dependencies.php';
require __DIR__ . '/../../src/JsonView/middleware.php';
require __DIR__ . '/../../src/JsonView/routes.php';

$app->run();

//header('Content-Type: application/json');


