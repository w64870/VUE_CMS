<?php

namespace Mes\App\Model\Operation;

use \Mes\App\Helpers\AppHelper as AppHelper;
use \Mes\App\Helpers\DbHelper as DbHelper;
use \Mes\App\Helpers\JsonHelper as JsonHelper;

use \Mes\App\Lib\AppConfig as AppConfig;
use \Mes\App\Lib\OracleDateTimeFormat as OracleDateTimeFormat;
use \Mes\App\Lib\Registry as Registry;
use \Mes\App\Lib\Session as Session;
use \Mes\App\Model\Operation\ScreenElementQueries as ScreenElementQueries;

use \Mes\App\Model\Operation\Operation as Operation;

class ScreenElement
{
    // Rodzaje wyzwalaczy/zapytań SQL
    const QUERY_DEFAULT_VALUE     = 'VALUE';
    const QUERY_HIDDEN            = 'QUERY_HIDDEN';
    const QUERY_NEW_WINDOW_SCREEN = 'NEW_WINDOW_SCREEN';
    const QUERY_NEXT_SCREEN       = 'EKR';
    const QUERY_PROCEDURE         = 'PROC';
    const QUERY_SCRIPT            = 'SCRIPT';
    const QUERY_SQL               = 'SQL';
    const QUERY_VALIDATION        = 'CHECK';
    const QUERY_VALUE_AFTER       = 'VALUE_AFTER';
    const QUERY_VALUE_BEFORE      = 'VALUE_BEFORE';
    const QUERY_TOOLTIP           = 'TOOLTIP';
    
    // Rodzaje elementów
    const TYPE_BUTTON         = 'BUTTON';
    const TYPE_CHECKBOX       = 'CHECKBOX';
    const TYPE_CLOCK          = 'CLOCK';
    const TYPE_INFO           = 'INFO';
    const TYPE_JS             = 'JS';
    const TYPE_LABEL          = 'LABEL';
    const TYPE_LIST           = 'LIST';
    const TYPE_NUMBER         = 'NUMBER';
    const TYPE_SCRIPT         = 'SCRIPT';
    const TYPE_TABLE_CHECKBOX = 'TABELA_CHECKBOX';
    const TYPE_TABLE_RADIO    = 'TABELA';
    const TYPE_TEXT           = 'TEXT';
    const TYPE_TEXTAREA       = 'TEXTAREA';
    const TYPE_VALUE          = 'VAL';
    
    public $id;
    public $type;
    public $screenId;
    public $value;
    public $queries;
    public $wynik_spr;
    public $wynik_war_po;
    public $wynik_war_przed;
    public $wynik_ukryj;
    public $clearContent;
    public $displayInNewTab;
    public $newWindowScreen;
    public $nextScreen;
    public $executionTime;
    public $css;
    public $idAttributeValue;
    public $nameAttributeValue;
    public $classAttributeValue;
    public $styleAttributeValue;
    public $generateSurroundingTableRow;
    public $htmlCodeBeforeElement;
    public $htmlCodeAfterElement;
    public $tabindex;
    public $hashValue;
    public $placeholderPhrase = 'placeholder';
    
    public $checkedValue;
    public $unCheckedValue;
    public $etykieta;
    
    public $format = "";
    public $seperators = array();
    
    public $refreshContext;
    public $position;
    public $refreshScreen;
    public $tooltip;
    
    
    function __construct(array $screenElement, array $screenElements)
    {
        $this->executionTime      = array();
        $this->id                 = $screenElement['id'];
        $this->nameAttributeValue = $screenElement['name'];
        $this->idAttributeValue   = str_replace(array('{', '}'), '', $screenElement['name']);
        $this->type               = $screenElement['type'];
        $this->screenId           = $screenElement['opscr_id'];
        
        if (!empty($screenElement['tabindex']))
        {
            $this->tabindex = (int) $screenElement['tabindex'];
        }
        
        $this->classAttributeValue = $screenElement['class'];
        $this->styleAttributeValue = $screenElement['style'];
        $this->css                 = '';
        
        if (!empty($this->classAttributeValue))
        {
            $this->css = 'class="' . $this->classAttributeValue . '"';
        }
        elseif (!empty($this->styleAttributeValue))
        {
            $this->css = 'style="' . $this->styleAttributeValue . '"';
        }
        
        $this->queries = new ScreenElementQueries(
            $screenElement['function_val'],
            $screenElement['function_hide'],
            $screenElement['function_new_window'],
            $screenElement['function_scr'],
            $screenElement['function_proc'] ? $screenElement['function_proc'] : '',
            $screenElement['function_sql'],
            $screenElement['function_check'],
            $screenElement['function_val_after'],
            $screenElement['function_val_before']
            );
        
        if (!empty($screenElement['value']))
        {
            $this->value = $screenElement['value'];
        }
        else
        {
            $this->value = null;
        }
        
        $this->displayInNewTab             = AppHelper::stringToBoolean($screenElement['new_window_in_tab']);
        $this->newWindowScreen             = $screenElement['new_window'];
        
        $this->nextScreen                  = $screenElement['gotoscr_id'];
        $this->wynik_spr                   = '';
        $this->clearContent                = AppHelper::stringToBoolean($screenElement['clear_field']);
        $this->generateSurroundingTableRow = AppHelper::stringToBoolean($screenElement['is_row']);
        $this->htmlCodeBeforeElement       = $screenElement['html_before_elem'];
        $this->htmlCodeAfterElement        = $screenElement['html_after_elem'];
        
        $this->hashValue = 'h_' . md5(uniqid(rand(), true));
        
        $this->etykieta = $screenElement['label'];
        
        if($screenElement['type'] === self::TYPE_CHECKBOX) {
            $this->assignCheckboxValues($screenElements);
        }
        
        if($screenElement['type'] === self::TYPE_CLOCK) {
            $this->setFormat($screenElements);
        }

        $this->refreshContext = AppHelper::stringToBoolean($screenElement['refresh_content']);  
        
        $this->refreshScreen = AppHelper::stringToBoolean($screenElement['refresh_screen']);
        $this->tooltip = $screenElement['tooltip'];
    }
    
    
    public function getId()
    {
        return $this->id;
    }
    
    public function getType()
    {
        return $this->type;
    }
    
    public function getQueries()
    {
        return $this->queries;
    }
    
    public function getValue()
    {
        return $this->value;
    }
    
    public function setValue($value)
    {
        $this->value = $value;
    }
    
    public function getIdAttributeValue()
    {
        return $this->idAttributeValue;
    }
    
    public function getNameAttributeValue()
    {
        return $this->nameAttributeValue;
    }
    
    public function getScreenId()
    {
        return $this->screenId;
    }
    
    public function setScreenId($screenId)
    {
        $this->screenId = $screenId;
    }
    
    public function getDisplayInNewTab()
    {
        return $this->displayInNewTab;
    }
    
    public function getNewWindowScreen()
    {
        return $this->newWindowScreen;
    }
    
    public function getNextScreen()
    {
        return $this->nextScreen;
    }
    
    public function getExecutionTime()
    {
        return $this->executionTime;
    }
    
    public function clearExecutionTime()
    {
        $this->executionTime = array();
    }
    
    public function getTabindex()
    {
        return $this->tabindex;
    }
    
    public function getPosition()
    {
        return $this->position;
    }
    
    public function getHtmlCode()
    {
        return $this->htmlCode;
    }
    
    //
    public function getFormat()
    {
        return $this->format;
    }
    
    public function getSeperators()
    {
        return $this->seperators;
    }

    public function getTooltip()
    {
        return $this->tooltip;
    }
    
    
    //
    public function executeSqlQuery($sqlType, array $screenElements, array $placeholderArray = [])
    {
        $startTime = AppHelper::getmicrotime();
        
        switch ($sqlType)
        {
            case self::QUERY_DEFAULT_VALUE:
                $sqlQuery = $this->queries->defaultValueQuery;
                break;
                
            case self::QUERY_HIDDEN:
                $sqlQuery = $this->queries->hiddenQuery;
                if (empty($sqlQuery))
                {
                    $this->wynik_ukryj = false;
                }
                break;
                
            case self::QUERY_NEW_WINDOW_SCREEN:
                $sqlQuery = $this->queries->newWindowScreenQuery;
                break;
                
            case self::QUERY_NEXT_SCREEN:
                $sqlQuery = $this->queries->nextScreenQuery;
                break;
                
            case self::QUERY_PROCEDURE:
                $sqlQuery = null;
                $this->executeProcedure($screenElements);
                break;
                
            case self::QUERY_SCRIPT:
                $sqlQuery = null;
                $this->executeScript($screenElements);
                break;
                
            case self::QUERY_SQL:
                $sqlQuery = null;
                $this->executeSql($screenElements);
                break;
                
            case self::QUERY_VALIDATION:
                $sqlQuery = $this->queries->validationQuery;
                break;
                
            case self::QUERY_VALUE_AFTER:
                $sqlQuery = $this->queries->valueAfterQuery;
                break;
                
            case self::QUERY_VALUE_BEFORE:
                $sqlQuery = $this->queries->valueBeforeQuery;
                break;
            
            case self::QUERY_TOOLTIP:
                $sqlQuery = $this->tooltip;
                break;
                
            default:
                Registry::$errorHandler->exitWithError('RuntimeException: Wystąpił błąd. Nieznany rodzaj wyzwalacza (' . $sqlType . self::QUERY_TOOLTIP .').');
        }
        
        if (empty($sqlQuery))
        {
            return;
        }

        $sqlQuery = 'SELECT (' . $sqlQuery . ') AS wartosc FROM dual';
        $row = $this->executeOneRowQuery($sqlQuery, $screenElements);

        switch ($sqlType)
        {
            case self::QUERY_DEFAULT_VALUE:
                $this->value = $row['wartosc'];
                break;
                
            case self::QUERY_HIDDEN:
                $this->wynik_ukryj = AppHelper::stringToBoolean($row['wartosc']);
                break;
                
            case self::QUERY_NEW_WINDOW_SCREEN:
                $this->newWindowScreen = $row['wartosc'];
                break;
                
            case self::QUERY_NEXT_SCREEN:
                $this->nextScreen = $row['wartosc'];
                break;
                
            case self::QUERY_SQL:
                break;
                
            case self::QUERY_VALIDATION:
                if (!empty($row['wartosc']))
                {
                    $this->wynik_spr = $row['wartosc'];
                }
                else
                {
                    $this->wynik_spr = '';
                }
                break;
                
            case self::QUERY_VALUE_AFTER:
                $this->value = $row['wartosc'];
                break;
                
            case self::QUERY_VALUE_BEFORE:
                $this->value = $row['wartosc'];
                break;

            case self::QUERY_TOOLTIP:
                $this->tooltip = $row['wartosc'];
                break;
                
            default:
                Registry::$errorHandler->exitWithError('RuntimeException: Wystąpił błąd. Nieznany rodzaj wyzwalacza (' . $sqlType . ').');
        }
        
        $isDebugMode = Operation::isCurrentOpInDebugMode();
        $stopTime = AppHelper::getmicrotime();
        if ($isDebugMode)
        {
            $this->executionTime[] = array(
                'SQL'  => $sqlQuery,
                'czas' => $stopTime - $startTime
            );
        }
    }

    //
    private function executeSql($screenElements)
    {
        if (empty($this->queries->sqlQuery) || $this->type !== self::TYPE_BUTTON) { return; }
                
        //
        $sqlQuery = $this->queries->sqlQuery;
        $bindings = self::generateSqlQueryParameterBindings($sqlQuery, $screenElements);
        $bindings[':PHP_RETURN'] = array("value" => "", "type" => DbHelper::DEFAULT_BIND_TYPE);
        
        $bind = DbHelper::executeAndReturnBindParams($sqlQuery, $bindings, false);
        
        $phpReturn = $bind[':PHP_RETURN']["value"];
        if (isset($phpReturn))
        {
            foreach ($screenElements as $key => $value)
            {
                if ($key === '{PHP_RETURN}')
                {
                    $screenElements[$key]->setValue($phpReturn);
                }
            }
        }
        
    }
    
    //
    private function executeScript($screenElements)
    {
        if (empty($this->queries->sqlQuery) || $this->type !== self::TYPE_SCRIPT) { return; }
        
        $sqlQuery = $this->queries->sqlQuery;
        $result = $this->executePlSqlQuery($sqlQuery, $screenElements);

        $vars = $result["vars"];
        $bind = $result["binds"];
        
        foreach ($vars as $key => $value)
        {
            foreach ($bind as $bind_key => $bind_array)
            {
                if ($bind_key == $vars[$key]['bind'])
                {
                    $screenElements[$key]->setValue($bind[$bind_key]["value"]);
                }
            }
        }
    }
    
    
    private function executeProcedure($screenElements)
    {
        if (empty($this->queries->procedureQuery) ||
            ($this->type !== self::TYPE_TABLE_RADIO  &&
                $this->type !== self::TYPE_TABLE_CHECKBOX) )
        { return; }
        
        
		$sqlQuery = $this->queries->procedureQuery;
        $result = $this->executePlSqlQuery($sqlQuery, $screenElements);

        $vars = $result["vars"];
        $bind = $result["binds"];

        foreach ($vars as $key => $value)
        {
            foreach ($bind as $bind_key => $bind_array)
            {
                if ($bind_key == $vars[$key]['bind'])
                {
                    $screenElements[$key]->setValue($bind[$bind_key]["value"]);
                }
            }
        }
    }


	//
    private function executePlSqlQuery($sqlQuery, $screenElements)
    {
        $vars = self::extractVariablesFromSqlQuery($sqlQuery, $screenElements);
        $bind = array();
        
        //Array ( [{Z1}] => Array ( [wartosc] => [bind] => :Z1 ) )
        foreach ($vars as $key => $value)
        {
            // podmien {x} na :x
            $sqlQuery = str_ireplace($key, $vars[$key]['bind'], $sqlQuery);
            // tworz tablice bindowanych zmiennych :x => 'wartosc
            $bind[$vars[$key]['bind']] = array(
                "value" => $vars[$key]['wartosc'],
                "type" => DbHelper::DEFAULT_BIND_TYPE
            );
        }
        
        $bind = DbHelper::executeAndReturnBindParams($sqlQuery, $bind, false);
        
        return array(
            "vars" => $vars,
            "binds" => $bind
        );
    }

    private function executeOneRowQuery($sqlQuery, array $screenElements)
    {
        if (empty($sqlQuery)) {
            Registry::$errorHandler->exitWithError("InvalidArgumentException: An empty SQL query.");
        }
        
        $bindings = self::generateSqlQueryParameterBindings($sqlQuery, $screenElements);
        $row = DbHelper::executeSingleRowQuery($sqlQuery, $bindings);
        
        return $row;
    }
    
    private function executeManyRowsQuery($sqlQuery, array $screenElements)
    {
        if (empty($sqlQuery)) {
            Registry::$errorHandler->exitWithError("InvalidArgumentException: An empty SQL query.");
        }
        
        $bindings = self::generateSqlQueryParameterBindings($sqlQuery, $screenElements);
        $rows = DbHelper::executeMultipleRowQuery($sqlQuery, $bindings);
        
        return $rows;
    }

    //    
    private static function generateSqlQueryParameterBindings(&$sqlQuery, array $screenElements)
    {
        $bindings = array();
        
        $variables = self::extractVariablesFromSqlQuery($sqlQuery, $screenElements);
        foreach ($variables as $key => $value)
        {
            // podmien {x} na :x
            $sqlQuery = str_ireplace($key, $variables[$key]['bind'], $sqlQuery);
            // tworz tablice bindowanych zmiennych :x => 'wartosc
            $bindings[$variables[$key]['bind']] = array(
                "value" => $variables[$key]['wartosc'],
                "type" => DbHelper::DEFAULT_BIND_TYPE
            );
        }
        
        return $bindings;
    }
    
    /**
     * Funkcja parsuje kod SQL i zwraca zmienne zawarte w nim opisane wartościami i nazwa potrzebną do binodwania w Oracle
     *
     * Podajemy:
     *   $funkcja => kod SQL <string>
     *   $screenElements => tablica - [{ELEMENT}] => (instancja klasy element)    // tablica elementów
     *
     * Zwraca:
     *   tablica - [{ELEMENT}] =>
     *          Tablica - [wartosc] => 'wartosc'   // wartosc pola
     *                    [bind] => :DM_KOD        // nazwa pola zgodna z bindowaniem
     */
    private static function extractVariablesFromSqlQuery($sqlQuery, $screenElements)
    {
        if (empty($sqlQuery))
        {
            return null;
        }
        
        $zmienne = array();
        $start = -1;
        $stop = 0;
        
        while (true)
        {
            $start = strpos($sqlQuery, '{', $start + 1);
            $stop = strpos($sqlQuery, '}', $start + 1);
            if ((!$start || !$stop) && !is_numeric($start))
            {
                break;
            }
            
            $zmienna = substr($sqlQuery, $start, $stop + 1 - $start);
            
            if (array_key_exists($zmienna, $screenElements))
            {
                $zmienna_bindowana = str_ireplace('}', '', $zmienna);
                $zmienna_bindowana = str_ireplace('{', ':', $zmienna_bindowana);
                $zmienne[$zmienna] = array(
                    'wartosc' => $screenElements[$zmienna]->value,
                    'bind'    => $zmienna_bindowana
                );
            }
        }
        
        return $zmienne;
    }
    
    public static function createEmptyTable($name, $value)
    {
        $screenElement = array(
            'id'                   => '0',
            'opscr_id'             => '',
            'name'                 => $name,
            'type'                 => self::TYPE_VALUE,
            'class'                => '',
            'style'                => '',
            'function_check'       => '',
            'function_sql'         => '',
            'function_scr'         => '',
            'function_val'         => '',
            'function_hide'        => '',
            'function_val_before'  => '',
            'function_val_after'   => '',
            'function_proc'        => '',
            'gotoscr_id'           => '',
            'value'                => $value,
            'clear_field'          => false,
            'tabindex'             => '',
            'is_row'               => true,
            'html_before_elem'     => '',
            'html_after_elem'      => '',
            'label'                => '',
            'refresh_content'      => false,
            'refresh_screen'       => false, 
            'new_window'           => '',
            'function_new_window'  => '',
            'new_window_in_tab'    => true,
            'tooltip'              => ''
        );
        
        return $screenElement;
    }
    
    
    //
    public function getAttachmentTablePlaceholdersArray($screenElements)
    {
        if (empty($this->queries->sqlQuery)) { return array(); }
        
        $sqlQuery = $this->queries->sqlQuery;
        $bind = self::generateSqlQueryParameterBindings($sqlQuery, $screenElements); 
        $rows = DbHelper::executeMultipleRowQuery($sqlQuery, $bind);
        $rowsNumber = count($rows);
        
        $placeholdersArray = array();
        
        for($i = 0; $i < $rowsNumber; $i++) {
            
            $rowPlaceholders = array();
            $tableRow = $rows[$i];
            
            foreach ($tableRow as $key => $value) {
                if (strpos($key, $this->placeholderPhrase) !== false) {
                    $rowPlaceholders[$key] = $value;
                }
            }
            array_push($placeholdersArray, $rowPlaceholders);
        }
        
        return $placeholdersArray; 
    }
    
    // Przypisuje wartości dla checkboxa
    public function assignCheckboxValues($screenElements)
    {
        if ($this->type !== self::TYPE_CHECKBOX)
        {
            return;
        }
        
        $sqlQuery = $this->queries->sqlQuery;
        
        if (!empty($sqlQuery) && !is_null($sqlQuery))
        {
            $row = $this->executeOneRowQuery($sqlQuery, $screenElements);
            
            $this->checkedValue = $row['yes'];
            $this->unCheckedValue = $row['no'];
        }
        else
        {
            $this->checkedValue = 'YES';
            $this->unCheckedValue = 'NO';
        }
        
        if (empty($this->value) || is_null($this->value))
        {
            $this->value = $this->unCheckedValue;
        }
        
    }
    
    public function getScreenInfo()
    {
        $row = self::getDbScreenInfo($this->screenId);
        
        $elementDescription = '[' .
            $row['op_id'] . '].' .
            $row['op_desc'] . '.' .
            $row['scrname'] . '.' .
            $this->nameAttributeValue;
            
        $screenInfo = array(':screen_info' => DbHelper::createBindArray($elementDescription));
        
        return $screenInfo;
    }
    
    public static function getDbScreenInfo($screenId)
    {
        if(empty($screenId)) {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty screen ID.');
        }
        
        $sqlQuery =
        PHP_EOL . 'SELECT op.id op_id, op.description op_desc, opscr.name scrname, ' .
        PHP_EOL . '       opscr.is_menu, opscr.is_logout, opscr.is_new_window ' .
        PHP_EOL . '  FROM cms_operation_screens opscr, cms_operations op ' .
        PHP_EOL . ' WHERE opscr.op_id = op.id ' .
        PHP_EOL . '   AND opscr.id = :screen_id';
        
        $queryParameters = array(':screen_id' => DbHelper::createBindArray($screenId));
        $row = DbHelper::executeSingleRowQuery($sqlQuery, $queryParameters);
        
        return $row;
    }
    
    
    public function getContent($screenElements)
    {
        if (empty($this->queries->sqlQuery)) { return array(); }
        
        $sqlQuery = $this->queries->sqlQuery;
        $bind = self::generateSqlQueryParameterBindings($sqlQuery, $screenElements);
        
        $headers = DbHelper::getQueryFields($sqlQuery, $bind);
        $rows = DbHelper::executeMultipleRowQuery($sqlQuery, $bind);
        
        return array(
            "headers" => $headers,
            "rows" => $rows
        );
    }
    
    
    public function generateJSON($screenElements)
    {
        if ($this->type === self::TYPE_SCRIPT) { return; }
        if ($this->wynik_ukryj && $this->type !== self::TYPE_VALUE) { return; }
        
        $content = array();
        $format = null;
        $value = $this->value;
        
        $datetimeFormat = "";
        $dateFormat = "";
        $timeFormat = "";
        
        switch ($this->type)
        {
            case self::TYPE_CHECKBOX:
                $value = false;
                if ($this->value == $this->checkedValue) {
                    $value = true;
                }
                break;
            
            case self::TYPE_CLOCK:
                //$format = $this->queries->sqlQuery;
                if(!empty($this->format)) {
                    $oracleFormat = new OracleDateTimeFormat("DATETIME", $this->format, $this->seperators);
                } else {
                    $oracleFormat = new OracleDateTimeFormat();
                }
                
                $datetimeFormat = $oracleFormat->getMomentDateTime(); 
                $format = $oracleFormat->getLuxonDateTime();
                break;
                
            case self::TYPE_JS:
                //$content = preg_replace('/\s+/', ' ', $this->queries->sqlQuery);
                $content = $this->queries->sqlQuery;
                break;
        }
        
        $complexTypes = array(
            self::TYPE_INFO,
            self::TYPE_LIST,
            self::TYPE_TABLE_CHECKBOX,
            self::TYPE_TABLE_RADIO,
        );
                
        if (in_array($this->type, $complexTypes)) {
            $content = $this->getContent($screenElements);
        }

        $newWindowParams = array('screen_id' => '', 'new_tab' => $this->displayInNewTab);
        if(!empty($this->newWindowScreen)) {
            $windowScreens = Session::get('window_screens');
            $windowScreenId = array_key_exists($this->newWindowScreen, $windowScreens) ? $windowScreens[$this->newWindowScreen]->id : '';

            $newWindowParams = array(
                'screen_id' => $windowScreenId,
                'new_tab' => $this->displayInNewTab
            );
        }
        
        return array(
            'id'            => $this->id,
            'type'          => $this->type,
            'idAttribute'   => $this->idAttributeValue,
            'nameAttribute' => $this->nameAttributeValue,
            'value'         => $value,
            'tabIndex'      => $this->tabindex,
            //'position'    => $this->position,
            'classAttribute' => $this->classAttributeValue,
            'styleAttribute' => $this->styleAttributeValue,
            'clearContent'   => $this->clearContent,
            'label'          => $this->etykieta,
            'boolean' => array(
                'checkedValue'   => $this->checkedValue,
                'uncheckedValue' => $this->unCheckedValue
            ),
            'format'  => $format,
            'formats' => array(
                'datetimeFormat' => $datetimeFormat,
                'dateFormat' => $dateFormat,
                'timeFormat' => $timeFormat
            ),
            'content'         => $content,
            'htmlBefore'      => $this->htmlCodeBeforeElement,
            'htmlAfter'       => $this->htmlCodeAfterElement,
            'refreshContext'  => $this->refreshContext,
            'refreshScreen'   => $this->refreshScreen,
            'newWindowParams' => $newWindowParams,
            'tooltip'         => $this->tooltip
        );
        
    }
        
    // Ustawianie formatu daty/czasu
    private function setFormat($screenElements)
    {
        if ($this->type !== self::TYPE_CLOCK) {
                return;
            }
            
            $sqlQuery = $this->queries->sqlQuery;
            
            if (!empty($sqlQuery))
            {
                $row = $this->executeOneRowQuery($sqlQuery, $screenElements);
                $this->format = AppHelper::getKey("format", $row, "");
                
                $this->seperators["datetimeSeperator"] = AppHelper::getKey("separator_daty_czasu", $row, "");
                $this->seperators["dateSeperator"] = AppHelper::getKey("separator_daty", $row, "");
                $this->seperators["timeSeperator"] = AppHelper::getKey("separator_czasu", $row, "");
            }
            
    }
    
}
