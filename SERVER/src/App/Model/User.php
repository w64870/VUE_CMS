<?php

namespace Mes\App\Model;

use \Mes\App\Helpers\DbHelper as DbHelper;
use \Mes\App\Helpers\JsonHelper as JsonHelper;
use \Mes\App\Lib\Registry as Registry;

class User
{    
    public static function getuserDescription($user_id)
    {
        if (empty($userId)) {
            //Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty user ID.');
            return "";
        }
        
        $sqlQuery =
        PHP_EOL . 'SELECT Nvl(DESCRIPTION, id) opis ' .
        PHP_EOL . '  FROM cms_users ' .
        PHP_EOL . 'WHERE id = :user_id';
        
        $queryParameters = array(':user_id' => DbHelper::createBindArray($userId));
        
        $userDescription = DbHelper::executeSingleRowQuery($sqlQuery, $queryParameters, true)['opis'];
        
        return $userDescription;
    }
    
    public static function getUserLoginData($user_id)
    {
        if (empty($user_id)) {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty user ID.');
        }
        
        $sqlQuery =
            PHP_EOL . "SELECT upper(nvl(check_pass, 'YES')) AS check_pass," .
            PHP_EOL . '       password, id' .
            PHP_EOL . '  FROM cms_users' .
            PHP_EOL . ' WHERE id = :user_id';
        
        $queryParameters = array(':user_id' => DbHelper::createBindArray($user_id));

        $row = DbHelper::executeSingleRowQuery($sqlQuery, $queryParameters, true);

        return $row;
    }

    public static function changePassword($userId, $newPassword, $checkPassword)
    {    
        $sqlQuery =
            PHP_EOL . "UPDATE cms_users" .
            PHP_EOL . "   SET password = :new_password," .
            PHP_EOL . "       check_pass = :chceck_password" .
            PHP_EOL . " WHERE id = :user_id";
        
        $queryParameters = array(':user_id' => DbHelper::createBindArray($userId),
                                 ':new_password' => DbHelper::createBindArray($newPassword),
                                 ':chceck_password' => DbHelper::createBindArray($checkPassword));

        DbHelper::executeSpecialQuery($sqlQuery, $queryParameters, true);
    }

    public static function addUser($username, $userDesc, $password, $checkPassword, $canModify)
    {    
        $sqlQuery =
            PHP_EOL . "INSERT INTO cms_users(id, password, description, check_pass, can_modify)" .
            PHP_EOL . " VALUES(:username, :password, :userDesc, :checkPassword, :canModify)";
        
        $queryParameters = array(':username'      => DbHelper::createBindArray($username),
                                 ':password'      => DbHelper::createBindArray($password),
                                 ':userDesc'      => DbHelper::createBindArray($userDesc),
                                 ':checkPassword' => DbHelper::createBindArray($checkPassword),
                                 ':canModify'     => DbHelper::createBindArray($canModify));

        DbHelper::executeSpecialQuery($sqlQuery, $queryParameters, true);
    }

    public static function setDebugeMode($userId, $debugMode)
    {
        $sqlQuery =
            PHP_EOL . "UPDATE cms_operation_users set debug_mode = :debugMode where user_id = :userId";
        
        $queryParameters = array(':userId'    => DbHelper::createBindArray($userId),
                                 ':debugMode' => DbHelper::createBindArray($debugMode));

        DbHelper::executeSpecialQuery($sqlQuery, $queryParameters, true);
    }

}