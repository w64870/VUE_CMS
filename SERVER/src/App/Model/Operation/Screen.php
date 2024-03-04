<?php

namespace Mes\App\Model\Operation;

use \Mes\App\Helpers\AppHelper as AppHelper;
use \Mes\App\Helpers\DbHelper as DbHelper;
use \Mes\App\Helpers\JsonHelper as JsonHelper;
use \Mes\App\Lib\AppConfig as AppConfig;
use \Mes\App\Lib\Registry as Registry;
use \Mes\App\Lib\Session as Session;
use \Mes\App\Model\Operation\Operation as Operation;
use \Mes\App\Model\Operation\ScreenElement as ScreenElement;


class Screen
{
    public $id;
    public $name;
    public $operationId;
    public $defaultElementId;
    public $activeElementId;
    public $elements;
    public $logoutEnabled;
    public $isNewWindow;
    public $menuEnabled;
    
    
    public function __construct(
        $id, 
        $name, 
        $operationId, 
        $defaultElementId,
        $activeElementId, 
        array $elements = array(), 
        $logoutEnabled,
        $menuEnabled,
        $isNewWindow)
    {
        $this->id = $id;
        $this->name = $name;
        $this->operationId = $operationId;
        $this->defaultElementId = $defaultElementId;
        $this->activeElementId = $activeElementId;
        $this->elements = $elements;
        $this->logoutEnabled = $logoutEnabled;
        $this->menuEnabled = $menuEnabled;
        $this->isNewWindow = $isNewWindow;
    }
    
    public static function parseScreenName($screenName)
    {
        $result = array(
            'operation_name' => '',
            'screen_name' => ''
        );
        
        if (empty($screenName))
        {
            return $result;
        }
        
        $position = strpos($screenName, '].[');
        if ($position === false)
        {
            $result['screen_name'] = $screenName;
        }
        else
        {
            $result['operation_name'] = substr($screenName, 0, $position + 1);
            $result['screen_name'] = substr($screenName, $position + 2, strlen($screenName));
        }
        
        return $result;
    }
    
    public static function run($screenId) 
    {
        $screenData = self::checkScreen($screenId);
        $screenInfo = $screenData['screenInfo'];
        $operations = $screenData['operations'];
        $operationId = $screenData['operationId'];
        
        //
        $screenName = $screenInfo['ekrop_nazwa'];
        $opDescription = $operations[$operationId]->description;
        $opVersion = $operations[$operationId]->version;
        
        //
        $screenElements = unserialize(Session::get('screen_elements'));
        if(empty($screenElements)) {
            $screenElements = unserialize(Session::get('prev_screen_elements'));
        }
        if(empty($screenElements)) {
            $screenElements = array();
        }
        
        $windowScreenElements = self::getWindowScreenElements($screenElements, $screenId);
        
        foreach ($windowScreenElements as &$windowScreenElement)
        {
            $windowScreenElement->clearExecutionTime();
        }
        
        self::executeQueries($windowScreenElements, $screenElements, $screenId);
        
        $error = Registry::$errorHandler->getLastError();
        
        $screenData = array(
            'operation_id'            => $operationId,
            'operation_description'   => $opDescription,
            'screen_id'               => $screenId,
            'screen_name'             => $screenName,
            'version'                 => $opVersion,
            'error'                   => $error
        );
        
        $screenJSON = self::generateScreenJSON($windowScreenElements, $screenElements, $screenData);
        
        return $screenJSON;
    }
    
    
    public static function getScreenElements($screenId)
    {
        if (empty($screenId)) {
            Registry::$errorHandler->exitWithError("InvalidArgumentException: An empty screen ID.'");
            return array();
        }
        
        $sqlQuery =
            PHP_EOL . 'SELECT scre.id, scre.opscr_id, scre.name, scre.type, scre.class, scre.style, scre.function_check,' .
            PHP_EOL . '       scre.function_sql, scre.function_scr, scre.function_val, scre.function_hide, scre.function_val_before,' .
            PHP_EOL . '       scre.function_val_after, scre.function_proc,' .
            PHP_EOL . '       scre.gotoscr_id, scre.value, scre.clear_field, scre.ordinal tabindex,' .
            PHP_EOL . '       scre.is_row, scre.html_before_elem, scre.html_after_elem,' .
            PHP_EOL . '       scre.label, scre.refresh_content, scre.refresh_screen, scre.container_style,' .
            PHP_EOL . '       scre.new_window, scre.function_new_window, scre.new_window_in_tab ' .
            PHP_EOL . '  FROM cms_screen_elements srce' .
            PHP_EOL . ' WHERE scre.opsrc_id = :opsrc_id' .
            PHP_EOL . "   AND scre.state_id != 'DISABLED'" .
            PHP_EOL . 'ORDER BY scre.ordinal';
         
        $rows = DbHelper::executeMultipleRowQuery($sqlQuery, array(':opsrc_id' => DbHelper::createBindArray($screenId)));
        
        $screenElements = array();
        foreach($rows as $row) {
            $screenElements[] = $row;
        }
        
        return $screenElements;
    }

    
    public static function checkScreen($screenId)
    {
        if(empty($screenId)) {
            Registry::$errorHandler->exitWithError('Błąd: brak ekranu', 'Sc1');
            return array();
        }
        
        $screenInfo = ScreenElement::getDbScreenInfo($screenId);
        
        $isAllowed = AppHelper::stringToBoolean($screenInfo['czy_nowe_okno']);
        if(!$isAllowed) {
            Registry::$errorHandler->exitWithError('Brak uprawnień: ekran nie może być otwierany w nowym oknie', 'Sc2');
            return array();
        }
        
        $operations = Session::get('operations');
        if(empty($operations)) {
            Registry::$errorHandler->exitWithError('Brak operacji w sesji', 'Sc3');
            return array();
        }
        
        $operationId = Session::get('operation_id');
        if(empty($operationId)) {
            $operationId = Session::get('prev_operation_id');
            if(empty($operationId)) {
                Registry::$errorHandler->exitWithError('Brak ID operacji w sesji', 'Sc4');
                return array();
            }
        }
        
        if($screenInfo["op_id"] != $operationId) {
            //Registry::$errorHandler->exitWithError('Brak uprawnień: ekran należy do innej operacji', 'Sc5');
        }
        
        if (!Session::keyExists('screen_elements'))
        {
            if(!Session::keyExists('prev_screen_elements')) {
                Registry::$errorHandler->exitWithError('Brak elementów ekranu w sesji', 'Sc6');
                return array();
            }
        }
        
        return array(
            'screenInfo'  => $screenInfo,
            'operations'  => $operations,
            'operationId' => $operationId
        );
    }
    
    
    public static function getWindowScreenElements($screenElements, $screenId)
    {
        $windowScreenElements = array();
        
        $elements = self::getScreenElements($screenId);
        
        if (empty($elements)) {
            Registry::$errorHandler->exitWithError('Brak elementów dla tego ekranu', 'Sc7');
            return array();
        }
        
        $allowedTypes = array(
            ScreenElement::TYPE_ATTACHMENT,
            ScreenElement::TYPE_CLOCK,
            ScreenElement::TYPE_HTML,
            ScreenElement::TYPE_INFO,
            ScreenElement::TYPE_JS,
            ScreenElement::TYPE_LABEL,
            ScreenElement::TYPE_LINK,
            ScreenElement::TYPE_LINK_TAB,
            ScreenElement::TYPE_MES_WIDGET,
            ScreenElement::TYPE_NOTICE,
            ScreenElement::TYPE_VALUE
        );
        
        foreach ($elements as $element)
        {
            if(in_array($element['rodzaj'], $allowedTypes)) {
                $elementName = $element['nazwa'];
                $windowScreenElements[$elementName] = new ScreenElement($element, $screenElements);
            }
        }
        
        return $windowScreenElements;
    }
    
    
    public static function executeQueries($windowScreenElements, $screenElements, $screenId)
    {
        
        foreach ($windowScreenElements as $key => $value)
        {
            $windowScreenElements[$key]->executeSqlQuery(ScreenElement::QUERY_HIDDEN, $screenElements);
        }
        
        foreach ($windowScreenElements as $key => $value)
        {
            $windowScreenElements[$key]->executeSqlQuery(ScreenElement::QUERY_VALUE_BEFORE, $screenElements);
        }
    }
    
    
    public static function generateScreenJSON($windowScreenElements, $screenElements, array $screenData)
    {
        $screenElementsJSON = array();
        
        $screenId = $screenData["screen_id"];
        
        $screenRows = Operation::getScreenRows($screenId);
        $rowNo = count($screenRows);
        
        $i=0;
        while($i < $rowNo) {
            $j=0;
            
            $currentTabindex = $screenRows[$i]['row_no'];
            $screenElementsJSON[$i] = array(
                'positions' => $screenRows[$i]['positions'],
                'first_elements' => [],
                'middle_elements' => [],
                'last_elements' => []
            );
            
            foreach ($windowScreenElements as $key => $value) {
                if ($windowScreenElements[$key]->getScreenId() === $screenId) {
                    
                    if( $currentTabindex != $windowScreenElements[$key]->getTabindex()) {
                        continue;
                    }
                    
                    $json = $windowScreenElements[$key]->generateJSON($screenElements);
                    if (!empty($json)) {
                        $pos = $windowScreenElements[$key]->getPosition();
                        
                        if($pos > 12) {
                            $screenElementsJSON[$i]['last_elements'][] = $json;
                        }
                        elseif ($pos >= 1 && $pos <= 12) {
                            $screenElementsJSON[$i]['middle_elements'][] = $json;
                        }
                        else {
                            $screenElementsJSON[$i]['first_elements'][] = $json;
                        }
                    }
                    $j++;
                }
            }
            $i++;
        }
        
        $appError = Registry::$errorHandler->getLastError();
        //
        return array(
            //'screen_elements'         => $screenElements,
            'window_screen_elements'  => $screenElementsJSON,
            'operation_id'            => $screenData['operation_id'],
            'operation_description'  =>  $screenData['operation_description'],
            'screen_id'               => $screenData['screen_id'],
            'screen_name'             => $screenData['screen_name'],
            'version'                 => $screenData['version'],
            'app_error'               => $appError,
            'error'                   => ''
        ); 
    }
    
}
