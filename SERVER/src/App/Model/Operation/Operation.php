<?php 

namespace Mes\App\Model\Operation;

use \Mes\App\Handlers\RedirectHandler as RedirectHandler;
use \Mes\App\Helpers\AppHelper as AppHelper;
use \Mes\App\Helpers\DbHelper as DbHelper;
use \Mes\App\Helpers\JsonHelper as JsonHelper;

use \Mes\App\Lib\AppConfig as AppConfig;
use \Mes\App\Lib\Printer as Printer;
use \Mes\App\Lib\Registry as Registry;
use \Mes\App\Lib\Session as Session;

use \Mes\App\Model\Operation\ScreenElement as ScreenElement;

class Operation
{
    public $id;
    public $name;
    public $description;
    public $version;
    public $isDebugMode;    
    
    private $activeElementName;
    private $error;
    private $isNewScreen;
    private $isSubmit;
    private $currentScreen;
    
    private $goToOperationScreen;
    private $goToOperationName;
    
    
    public function __construct($id, $name, $description, $version, $isDebugMode)
    {
        $this->id = $id;
        $this->name = $name;
        $this->description = $description;
        $this->version = $version;
        $this->isDebugMode = $isDebugMode;        
    }
    
    public static function isCurrentOpInDebugMode() {
        $operationId = Session::get('operation_id');
        if(empty($operationId)) {
            $operationId = Session::get('prev_operation_id');
            if(empty($operationId)) {
                return false;
            }
        }
        return $_SESSION['operations'][$operationId]->isDebugMode;
    }
    
    //
    public function run(array $formValues)
    {
        $operationId = $this->id;
        
        $opdata = array(
            "activeFormName" => "akcje_form",
            "activeElementName" => "",
            "defaultElementName" => "",
            "error" => "",
            "isNewScreen" => false,
            "isSubmit" => false,
            "currentScreen" => array(),
            "prevScreen" => array(),
            "goToOperationScreen" => array(),
            "goToOperationName" => ""
        );

        Session::remove('prev_operation_id');
        
        $operations = Session::get('operations');
        $prevOpId = Session::get('operation_id');
        
        if( $operationId !== $prevOpId) {
            Session::remove('screen_elements');
            Session::remove('operation_id');
            Session::remove('previous_screen_name');
            
            //$prevOperation = $operations[$prevOpId] ?? null;
            $prevOpId = null;
        }
        
        $screenElements = self::getScreenElements();
        
        foreach ($screenElements as &$screenElement) {
            $screenElement->clearExecutionTime();
        }
        
        //
        if (empty($prevOpId)) self::load($operationId, $screenElements);

        //
        $screens = Session::get('screens');
        
        //
        if (empty($screens)) Registry::$errorHandler->exitWithError('Brak ekranów operacji w sesji', "Op6");
        
        //
        $this->setScreen($opdata);
        
        $postedScreenElements = $this->readScreenFormValues($formValues, $screenElements, $opdata);
        $this->preparePostedScreenElements($postedScreenElements, $screenElements, $opdata);
        $this->setScreenElementValues($postedScreenElements, $screenElements, $opdata);
        $this->executeValueAfterQueries($postedScreenElements, $screenElements, $opdata);
        
        $this->executeValidationQueries($postedScreenElements, $screenElements, $opdata);
        
        $this->executeNextScreenQueries($postedScreenElements, $screenElements, $opdata);
        
        $this->setScreenVars($screenElements, $opdata);
        
        if (empty($opdata["error"]))
        {
            $this->executeSqlQueries($postedScreenElements, $screenElements, $opdata);
            $this->executeProcedureQueries($postedScreenElements, $screenElements, $opdata);
            $this->executeScriptQueries($screenElements, $opdata);
            $this->executeHiddenQueries($screenElements, $opdata);
            $this->executeValueBeforeQueries($screenElements, $opdata);
            $this->executeTooltipQueries($screenElements, $opdata);
        }
        
        //HACK: sortowanie po tabindex/ordinalu i pozycji wymuszone, bo gdzieś po drodze ginie właściwa kolejność
        //TODO: znaleźć właściwą przyczynę, poprawić i DISABLEDąć to niepotrzebne wtedy sortowanie
        uasort($screenElements, '\Mes\App\Helpers\AppHelper::compareElementsByCounterPosition');
        
        Session::set('screen_elements', serialize($screenElements));
        
        $this->handleSpecialScreens($screenElements, $opdata);
        $operationJSON = $this->generateOperationJSON($postedScreenElements, $screenElements, $opdata);
        
        $previousScreen = Session::set('previous_screen_name', $opdata["currentScreen"]["name"] );
        
        return $operationJSON; 
    }
    
    //
    public static function getUserOperations($userId)
    {
        $sqlQuery =
            PHP_EOL . 'SELECT o.id, o.name, o.description, o.ordinal,' .
            PHP_EOL . '       o.version, ou.debug_mode ' .
            PHP_EOL . '  FROM cms_operations o,' .
            PHP_EOL . '       cms_operation_users ou' .
            PHP_EOL . ' WHERE ou.user_id = :user_id' .
            PHP_EOL . '   AND o.id = ou.op_id' .
            PHP_EOL . "   AND o.state_id != 'DISABLED'" .
            PHP_EOL . 'ORDER BY ordinal';

        $dbParams = array(
            ':user_id' => DbHelper::createBindArray($userId)
        );

        $rows = DbHelper::executeMultipleRowQuery($sqlQuery, $dbParams, true);
        
        $operations = array();
        $sessionOperations = array();
        
        foreach($rows as $row) {
            $operation = new Operation(
                $row['id'], 
                $row['name'], 
                $row['description'],
                $row['version'], 
                AppHelper::stringToBoolean($row['debug_mode'])
            );
            
            $operations[] = $operation;
            $sessionOperations[$row['id']] = $operation;
        }
        
        if (AppHelper::userCanModify($userId)){
            $sessionOperations = self::getUpsertOperations($sessionOperations);
        }

        $_SESSION['operations'] = $sessionOperations;
        
        return $operations;
    }

    //
    public static function getUpsertOperations(&$sessionOperations)
    {
        $sqlQuery =
            PHP_EOL . 'SELECT o.id, o.name, o.description, o.ordinal,' .
            PHP_EOL . "       o.version, 'NO' debug_mode " .
            PHP_EOL . '  FROM cms_operations o' .
            PHP_EOL . " WHERE o.id in('UPSERT_OP', 'UPSERT_USER')" .
            PHP_EOL . "   AND o.state_id != 'DISABLED'" .
            PHP_EOL . 'ORDER BY ordinal';

        $dbParams = array();

        $rows = DbHelper::executeMultipleRowQuery($sqlQuery, $dbParams, true);
        
        foreach($rows as $row) {
            $operation = new Operation(
                $row['id'], 
                $row['name'], 
                $row['description'],
                $row['version'], 
                AppHelper::stringToBoolean($row['debug_mode'])
            );
            //
            $sessionOperations[$row['id']] = $operation;
        }
        
        return $sessionOperations;
    }
    
    //
    public static function getOperationScreens($operationId, $newWindow=false)
    {
        $isNewWindow = $newWindow ? 'YES' : 'NO';
        
        $sqlQuery =
            PHP_EOL . 'SELECT id, name, default_element, active_element, ' .
            PHP_EOL . '       is_logout, is_new_window, is_menu ' .
            PHP_EOL . '  FROM cms_operation_screens ' .
            PHP_EOL . ' WHERE op_id = :op_id ' .
            PHP_EOL . '   AND Upper(is_new_window) = :is_new_window' .
            PHP_EOL . 'ORDER BY seq';
        
        $bindVars = array(
            ':op_id' => DbHelper::createBindArray($operationId),
            ':is_new_window' => DbHelper::createBindArray($isNewWindow)
        );
        
        $rows = DbHelper::executeMultipleRowQuery($sqlQuery, $bindVars, true);
        
        $screens = array();
        foreach($rows as $row) {
            $screens[$row['name']] = new Screen(
                $row['id'],
                $row['name'],
                $operationId,
                $row['default_element'],
                $row['active_element'],
                array(),
                $row['is_logout'],
                $row['is_menu'],
                $row['is_new_window']
            );
        }
        
        return $screens;
    }

    //
    public static function getScreenRows($screenId)
    {
        $sqlQuery =
        PHP_EOL . 'SELECT DISTINCT(scre.ordinal) ordinal, ' .
        PHP_EOL . '( ' .
        PHP_EOL . '  SELECT Count(ordinal) ' .
        PHP_EOL . '  FROM cms_screen_elements ' . 
        PHP_EOL . '  WHERE ordinal = scre.ordinal ' . 
        PHP_EOL . '  AND opscr_id = :srcop_id ' . 
        PHP_EOL . "  AND state_id <> 'DISABLED' " . 
        PHP_EOL . ') scrows' .
        PHP_EOL . '  FROM cms_screen_elements scre' .
        PHP_EOL . ' WHERE scre.opscr_id = :srcop_id ' .
        PHP_EOL . 'ORDER BY ordinal';
        
        $rows = DbHelper::executeMultipleRowQuery($sqlQuery, array(':srcop_id' => DbHelper::createBindArray($screenId)), true);
        
        $screensRows = array();
        foreach($rows as $row) {
            $screensRows[] = array(
                'row_no'     => $row['ordinal'],
                'positions'  => $row['scrows']
            );
        }
        
        return $screensRows;
    }
    
    public static function getOperationScreenElements($operationId)
    {
        if (empty($operationId)) {
            Registry::$errorHandler->exitWithError("InvalidArgumentException: An empty operation ID.'");
        }
        
        $sqlQuery =
        PHP_EOL . 'SELECT scre.id, scre.opscr_id, scre.name, scre.type, scre.class, scre.style, scre.function_check,' .
        PHP_EOL . '       scre.function_sql, scre.function_scr, scre.function_val, scre.function_hide, scre.function_val_before,' .
        PHP_EOL . '       scre.function_val_after, scre.function_proc,' .
        PHP_EOL . '       scre.gotoscr_id, scre.value, scre.clear_field, scre.ordinal tabindex,' .
        PHP_EOL . '       scre.is_row, scre.html_before_elem, scre.html_after_elem,' .
        PHP_EOL . '       scre.label, scre.refresh_content, scre.refresh_screen, scre.container_style,' .
        PHP_EOL . '       scre.new_window, scre.function_new_window, scre.new_window_in_tab, scre.tooltip' .
        PHP_EOL . '  FROM cms_screen_elements scre,' .
        PHP_EOL . '       cms_operation_screens opscr' .
        PHP_EOL . ' WHERE opscr.op_id = :op_id' .
        PHP_EOL . '   AND scre.opscr_id = opscr.id' .
        PHP_EOL . "   AND Upper(opscr.is_new_window) = 'NO'" .
        PHP_EOL . "   AND scre.state_id != 'DISABLED'" .
        PHP_EOL . 'ORDER BY opscr.ordinal, scre.ordinal ';
        
        
        $rows = DbHelper::executeMultipleRowQuery($sqlQuery, array(':op_id' => DbHelper::createBindArray($operationId)));
        
        $screenElements = array();
        foreach($rows as $row) {
            $screenElements[] = $row;
        }
        
        return $screenElements;
    }
    
    public static function loadUserOperations($userId)
    {
        $operations = self::getUserOperations($userId);

        if (empty($operations) && !AppHelper::userCanModify($userId)) {
            //session_destroy();
            Registry::$errorHandler->exitWithError("Brak uprawnień do wykonywania operacji.", "Op1a");
        }
        
        return $operations;
    }
    
    public static function getOperationId($operationName, array $operations)
    {
        if (empty($operationName) || empty($operations))
        {
            return null;
        }
        
        foreach ($operations as $id => $operation)
        {
            if ($operation->name === $operationName)
            {
                return $id;
            }
        }
    }
    
    public static function load($operationId, array &$screenElements)
    {
        if (empty($operationId)) {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty operation ID.');
        }
        
        $operations = Session::get('operations');
        if (empty($operations)) {
            Registry::$errorHandler->exitWithError('Brak uprawnień do wykonywania operacji', "Op1b");
        }
        
        // sprawdzenie czy zgadzają się uprawnienia
        if (!array_key_exists($operationId, $operations)) {
            Registry::$errorHandler->exitWithError('Brak uprawnień do operacji', "Op2b");
        }
        
        Session::set('operation_id', $operationId);
        
        $screens = self::getOperationScreens($operationId);
        
        if (empty($screens)) {
            Registry::$errorHandler->exitWithError('Błąd definicji: brak zdefinowanych ekranów dla operacji', "Op3");
        }
        
        $windowScreens = self::getOperationScreens($operationId, true);
        
        $elements = self::getOperationScreenElements($operationId);
        if (empty($elements)) {
            Registry::$errorHandler->exitWithError('Exception: Brak elementów dla ekranów operacji o ID równym ' . $operationId . '.', "Op4");
        }
        
        // Elementy ekranow operacji
        foreach ($screens as &$screen) {
            foreach ($elements as $element) {
                if ($element['opscr_id'] !== $screen->id) { continue; }
                
                $elementName = $element['name'];
                $screenElements[$elementName] = new ScreenElement($element, $screenElements);
                
                if (empty($screen->activeElementId)
                    && ($element['type'] === ScreenElement::TYPE_TEXT
                        || $element['type'] === ScreenElement::TYPE_LIST
                        || $element['type'] === ScreenElement::TYPE_NUMBER))
                {
                    $screen->activeElementId = $screenElements[$elementName]->getNameAttributeValue();
                }
            }
        }
        
        Session::set('screens', $screens);
        reset($_SESSION['screens']);
        
        Session::set('window_screens', $windowScreens);
        
        self::setOperationSessionVars($operationId);
    }
    
    public function setScreen(array &$opdata)
    {
        $currentScreenName = Session::get('previous_screen_name');
        $opdata["currentScreen"] = array(
            'name' => $currentScreenName,
            'id' => null
        );
        
        
        if (empty($opdata["currentScreen"]['name']))
        {
            $opdata["currentScreen"]['name'] = key($_SESSION['screens']);
            $opdata["currentScreen"]['id'] = $_SESSION['screens'][$opdata["currentScreen"]['name']]->id;
        }
        else
        {
            if (array_key_exists($opdata["currentScreen"]['name'], $_SESSION['screens']))
            {
                $opdata["currentScreen"]['id'] = $_SESSION['screens'][$opdata["currentScreen"]['name']]->id;
            }
            else
            {
                Registry::$errorHandler->exitWithError('Niepoprawny ekran: ' . $opdata["currentScreen"]['name'] . ' dla operacji: ' . $this->id, "Op5");
            }
        }
    }
    
    public function readScreenFormValues($formValues, array $screenElements, array &$opdata)
    {
        if (empty($formValues)) { return array(); }
        
        $postedScreenElements = array();
        
        foreach ($formValues as $key => $value)
        {
            if (!array_key_exists($key, $screenElements))
            {
                continue;
            }
            
            // If $_POST value is an array (checkboxes), implode to string
            if(is_array($value)) {
                $value = implode(",", $value);
            }
            
            $postedScreenElements[$key] = $value;
            $type = $screenElements[$key]->getType();
            if ($type === ScreenElement::TYPE_BUTTON ||
                $type === ScreenElement::TYPE_TABLE_RADIO)
            {
                $opdata["isSubmit"] = true;
            }
        }
        
        return $postedScreenElements;
    }    
    
    public function executeValueAfterQueries(array $postedScreenElements, array $screenElements, array &$opdata)
    {
        if (empty($postedScreenElements))
        {
            return;
        }
        
        if (empty($screenElements))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty screen elements array.');
        }

        $currentScreenId = $opdata["currentScreen"]['id'];
        
        if (empty($currentScreenId))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty current screen ID.');
        }
        
        foreach ($postedScreenElements as $key => $value)
        {
			if ($screenElements[$key]->getScreenId() == $currentScreenId)
            {
	            $screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_VALUE_AFTER, $screenElements);
			}
        }
    }
    
    public function executeSqlQueries(array $postedScreenElements, array $screenElements, array &$opdata)
    {
        $isError = Registry::$errorHandler->isError();
        if($isError) { return; }
        
        if (empty($postedScreenElements))
        {
            return;
        }
        
        if (empty($screenElements))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty screen elements array.');
        }

		$screenId = $opdata["currentScreen"]['id'];
		$prevScreenId = $opdata["prevScreen"]['id'];
        
        if (empty($screenId))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty current screen ID.');
        }
        
        foreach ($postedScreenElements as $key => $value)
        {
            if ($screenElements[$key]->getScreenId() == $screenId || $screenElements[$key]->getScreenId() == $prevScreenId)
            {
	            if (array_key_exists($key, $screenElements) && $screenElements[$key]->getType() === ScreenElement::TYPE_BUTTON)
	            {
	                $screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_SQL, $screenElements);
	            }
			}
        }
    }
    
    public function executeProcedureQueries(array $postedScreenElements, array $screenElements, array &$opdata)
    {
        $isError = Registry::$errorHandler->isError();
        if($isError) { return; }
        
        if (empty($postedScreenElements))
        {
            return;
        }
        
        if (empty($screenElements))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty screen elements array.');
        }

        $screenId = $opdata["currentScreen"]['id'];
        $prevScreenId = $opdata["prevScreen"]['id'];
        
        if (empty($screenId))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty current screen ID.');
        }
        
        foreach ($postedScreenElements as $key => $value)
        {
            if ($screenElements[$key]->getScreenId() == $screenId || $screenElements[$key]->getScreenId() == $prevScreenId)
            {
	            if (array_key_exists($key, $screenElements) &&
	                ($screenElements[$key]->getType() === ScreenElement::TYPE_TABLE_RADIO ||
	                    $screenElements[$key]->getType() === ScreenElement::TYPE_TABLE_CHECKBOX ))
	            {
	                $screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_PROCEDURE, $screenElements);
	            }
			}
        }
    }
    
    
    public function executeScriptQueries(array $screenElements, array &$opdata)
    {
        $isError = Registry::$errorHandler->isError();
        if($isError) { return; }
        
        if (empty($screenElements))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty screen elements array.');
        }

        $screenId = $opdata["currentScreen"]['id'];
        $prevScreenId = $opdata["prevScreen"]['id'];
        
        if (empty($screenId))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty current screen ID.');
        }
        
        foreach ($screenElements as $key => $value)
        {
            if ($screenElements[$key]->getScreenId() == $screenId || $screenElements[$key]->getScreenId() == $prevScreenId)
            {
            	if ($screenElements[$key]->getType() === ScreenElement::TYPE_SCRIPT && $screenElements[$key]->getScreenId() === $screenId)
	            {
	                $screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_SCRIPT, $screenElements);
	            }
			}
        }
    }
    
    
    public function executeHiddenQueries(array $screenElements, array &$opdata)
    {
        $isError = Registry::$errorHandler->isError();
        if($isError) { return; }
        
        if (empty($screenElements))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty screen elements array.');
        }

        $screenId = $opdata["currentScreen"]['id'];
        $prevScreenId = $opdata["prevScreen"]['id'];

        if (empty($screenId))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty current screen ID.');
        }
        
        foreach ($screenElements as $key => $value)
        {
            if ($screenElements[$key]->getScreenId() == $screenId || $screenElements[$key]->getScreenId() == $prevScreenId)
            {
            	$screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_HIDDEN, $screenElements);
			}
        }
    }
    
    public function executeValueBeforeQueries(array $screenElements, array &$opdata)
    {
        $isError = Registry::$errorHandler->isError();
        if($isError) { return; }
        
        if (empty($screenElements))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty screen elements array.');
        }

        $screenId = $opdata["currentScreen"]['id'];
        $prevScreenId = $opdata["prevScreen"]['id'];
        
        if (empty($screenId))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty current screen ID.');
        }
        
        foreach ($screenElements as $key => $value)
        {
            if ($screenElements[$key]->getScreenId() === $screenId)
            {
                $screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_VALUE_BEFORE, $screenElements);
            }
        }
    }

    public function executeTooltipQueries(array $screenElements, array &$opdata)
    {
        $isError = Registry::$errorHandler->isError();
        if($isError) { return; }
        
        if (empty($screenElements))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty screen elements array.');
        }

        $screenId = $opdata["currentScreen"]['id'];
        $prevScreenId = $opdata["prevScreen"]['id'];
        
        if (empty($screenId))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty current screen ID.');
        }
        
        foreach ($screenElements as $key => $value)
        {
            if ($screenElements[$key]->getScreenId() === $screenId && empty($screenElements[$key]->getTooltip()))
            {
                $screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_TOOLTIP, $screenElements);
            }
        }
    }
    
    public static function setOperationSessionVars($operationId)
    {
        if (empty($operationId))
        {
            Registry::$errorHandler->exitWithError('InvalidArgumentException: An empty operation ID.');
        }
    }    
    
    public static function getScreenElements()
    {
        $screenElements = array();
        
        if (Session::keyExists('screen_elements')) {
            $screenElements = unserialize(Session::get('screen_elements'));
        }
        else {
            $staticElements = array(
                array('nazwa' => '{USER_ID}'       , 'wartosc' => Session::get('user_id')),
                array('nazwa' => '{IP}'           , 'wartosc' => filter_input(INPUT_SERVER, 'REMOTE_ADDR')),
                array('nazwa' => '{PHP_RETURN}'   , 'wartosc' => ''),
                array('nazwa' => '{POPRZEDNI_EKR}', 'wartosc' => ''),
                array('nazwa' => '{AKTUALNY_EKR}' , 'wartosc' => ''),
                array('nazwa' => '{USER_DESC}'     , 'wartosc' => Session::get('user_desc')),
                array('nazwa' => '{BASE_URL}'     , 'wartosc' => AppHelper::getBaseUrl()),
                array('nazwa' => '{KONTEKST}'     , 'wartosc' => Session::get('context')),
                array('nazwa' => '{SESSION_ID}'   , 'wartosc' => hash('sha256', session_id())),
                
                array('nazwa' => '{DATE_MASK}'    , 'wartosc' => Registry::$defaultDateTimeFormat->getDate()->getOracleFormat()),
                array('nazwa' => '{DATETIME_MASK}', 'wartosc' => Registry::$defaultDateTimeFormat->getOracleDateTime()),
            );
            
            foreach ($staticElements as $item) {
                $name = $item['nazwa'];
                
                if (!array_key_exists($name, $screenElements)) {
                    $screenElement = ScreenElement::createEmptyTable($name, $item['wartosc']);
                    $screenElements[$name] = new ScreenElement($screenElement, $screenElements);
                }
            }
        }
        
        return $screenElements;
    }
    
    public function preparePostedScreenElements(array &$postedScreenElements, array &$screenElements, array &$opdata)
    {
    	$currentScreen = $opdata["currentScreen"];

        if (!empty($postedScreenElements))
        {
            // jeszcze trzeba dodać te elementy, które nie zostały wysłane
            foreach ($screenElements as $key => $value)
            {
                // te które powinny być w ekranie
                if ($screenElements[$key]->getScreenId() == $currentScreen['id'])
                {
                    $type = $screenElements[$key]->getType();
                    if ($type === ScreenElement::TYPE_LIST || $type === ScreenElement::TYPE_TEXT ||
                        $type === ScreenElement::TYPE_VALUE || $type === ScreenElement::TYPE_NUMBER)
                    {
                        if (!array_key_exists($key, $postedScreenElements))
                        {
                            $postedScreenElements[$key] = '';
                        }
                    }
                    
                    $screenElements[$key]->wynik_spr = '';
                }
            }
            
            // jesli nie bylo przycisku to dodajemy domyślny
            if (!empty($postedScreenElements) && !$opdata["isSubmit"])
            {
                $defaultElementName = $_SESSION['screens'][$currentScreen['name']]->defaultElementId;
                if(!empty($defaultElementName)) {
                    $postedScreenElements[$defaultElementName] = $screenElements[$defaultElementName]->getValue();
                }
            }
        }
    }
    
    public function setScreenElementValues(array $postedScreenElements, array &$screenElements, array &$opdata)
    {
        $currentScreen = $opdata["currentScreen"];

        // Setting the values from the HTML form posted elements
        foreach ($postedScreenElements as $key => $value)
        {
        	if ($screenElements[$key]->getScreenId() == $currentScreen['id'])
            {
	            switch($screenElements[$key]->getType()) {
	                case ScreenElement::TYPE_CHECKBOX:
	                    $checkboxValue = $screenElements[$key]->unCheckedValue;
	                    $boolValue = AppHelper::stringToBoolean($value);
	                    if ($boolValue) {
	                        $checkboxValue = $screenElements[$key]->checkedValue;
	                    } 
	                    $screenElements[$key]->setValue($checkboxValue);
	                    break;
	                case ScreenElement::TYPE_NUMBER:
	                    $numberStr = $value;
	                    if (!empty($value)) {
	                        $seperator = Registry::$decimalMarker;
	                        $tmp = str_replace(' ', '', $value);
	                        $tmp = str_replace(',', '.', $tmp);
	                        if (is_numeric($tmp)) {
	                            $numberStr = str_replace('.', $seperator, $tmp);
	                        }
	                        else {
	                            Registry::$errorHandler->exitWithError("Wartość podana w polu liczbowym nie jest liczbą", "Op21", "", 1);
	                        }
	                    }
	                    $screenElements[$key]->setValue($numberStr);
	                    break;
	                case ScreenElement::TYPE_TABLE_CHECKBOX:
	                    $valueStr = $value;
	                    if (is_array($value)) {
	                        $valueStr = implode(',', $value);
	                    }
	                    $screenElements[$key]->setValue($valueStr);
	                    break;
	                default:
	                    $screenElements[$key]->setValue($value);
	                    break;
	            }
        	}
        }
    }
    
    
    public function executeValidationQueries(array $postedScreenElements, array &$screenElements, array &$opdata)
    {
        $currentScreen = $opdata["currentScreen"];

        // Executing the QUERY_VALIDATION triggers
        foreach ($postedScreenElements as $key => $value)
        {
        	if ($screenElements[$key]->getScreenId() == $currentScreen['id'])
            {
	            $type = $screenElements[$key]->getType();
	            
	            $screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_VALIDATION, $screenElements);
	            
	            if (empty($opdata["error"]))
	            {
	                $opdata["error"] = $screenElements[$key]->wynik_spr;
	                if (($type === ScreenElement::TYPE_TEXT || $type === ScreenElement::TYPE_NUMBER) && !empty($opdata["error"]))
	                {
	                    $opdata["activeElementName"] = $screenElements[$key]->getNameAttributeValue();
	                }
	            }
	        }
        }
    }
    
    
    public function executeNextScreenQueries(array $postedScreenElements, array &$screenElements, array &$opdata)
    {
        $currentScreen = $opdata["currentScreen"];
    	
        // Executing the QUERY_NEXT_SCREEN triggers
        foreach ($postedScreenElements as $key => $value)
        {
        	if ($screenElements[$key]->getScreenId() == $currentScreen['id'])
            {
	            $screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_NEXT_SCREEN, $screenElements);
	            
	            if (empty($opdata["goToOperationScreen"]['screen_name']))
	            {
	                $opdata["goToOperationScreen"] = Screen::parseScreenName($screenElements[$key]->getNextScreen());
	                $opdata["goToOperationName"] = $opdata["goToOperationScreen"]['operation_name'];
	            }
	        }
        }
        
        // Executing the QUERY_NEW_WINDOW_SCREEN triggers
        foreach ($postedScreenElements as $key => $value)
        {
            if ($screenElements[$key]->getScreenId() == $currentScreen['id'])
            {
                $screenElements[$key]->executeSqlQuery(ScreenElement::QUERY_NEW_WINDOW_SCREEN, $screenElements);
            }
        }
    }
    
    public function setScreenVars(&$screenElements, array &$opdata)
    {
        $isError = Registry::$errorHandler->isError();
        if($isError) { return; }
        
        
        if (empty($opdata["activeElementName"])) {
            $opdata["activeElementName"] = $_SESSION['screens'][$opdata["currentScreen"]['name']]->activeElementId;
        }
        
        // Przejście między ekranami
        // Setting the screen variables
        $opdata["prevScreen"] = $opdata["currentScreen"];
        
        if (!empty($opdata["error"])) 
        {
            $opdata["isNewScreen"] = false;
        }
        elseif (!empty($opdata["goToOperationScreen"]['screen_name'])) 
        {
            if (empty($opdata["goToOperationScreen"]['operation_name']) && array_key_exists($opdata["goToOperationScreen"]['screen_name'], $_SESSION['screens'])) 
            {
                $opdata["currentScreen"]['name'] = $opdata["goToOperationScreen"]['screen_name'];
                $opdata["currentScreen"]['id'] = $_SESSION['screens'][$opdata["currentScreen"]['name']]->id;
                $opdata["isNewScreen"] = true;
                $opdata["activeElementName"] = $_SESSION['screens'][$opdata["currentScreen"]['name']]->activeElementId;
            }
            elseif (!empty($opdata["goToOperationScreen"]['operation_name'])) 
            {
                $opdata["currentScreen"]['name'] = $opdata["goToOperationScreen"]['screen_name'];
                $opdata["isNewScreen"] = true;
            }
            elseif ($opdata["goToOperationScreen"]['screen_name'] === '[logout]' || $opdata["goToOperationScreen"]['screen_name'] === '[menu]') 
            {
                $opdata["currentScreen"]['name'] = $opdata["goToOperationScreen"]['screen_name'];
                $opdata["isNewScreen"] = true;
            }
            else 
            {
                Registry::$errorHandler->exitWithError('Niepoprawny ekran: ' . $opdata["goToOperationScreen"]['screen_name'] . ' dla operacji: ' . $this->id, 5);
            }
        }
        
        $previousScreen = Session::get('previous_screen_name');
        
        // ustaw ekran jako poprzedni
        $screenElements['{POPRZEDNI_EKR}']->setValue($previousScreen);
        $screenElements['{AKTUALNY_EKR}']->setValue($opdata["currentScreen"]['name']);
    }
    
    
    public function handleSpecialScreens($screenElements, array &$opdata)
    {
        $isError = Registry::$errorHandler->isError();
        
        // Logout screen
        if ($screenElements['{AKTUALNY_EKR}']->getValue() === '[logout]') {
            if (Session::get('outsource')) {
                $urlAddress = Session::get('outsourceurl');
                AppHelper::logout();
                Registry::$db->sql_close();
                
                RedirectHandler::exitWithRedirect($urlAddress);
            }
            else {
                Registry::$db->sql_close();
                $logoutMessage = array_key_exists('{message}', $screenElements) ? $screenElements['{message}']->getValue() : null;
                
                RedirectHandler::exitWithRedirectAction('logout', array('message' => $logoutMessage));
            }
        }
        
        // Operations menu screen
        if ($screenElements['{AKTUALNY_EKR}']->getValue() === '[menu]') {

            Session::set('prev_operation_id', $this->id);
            
            Session::remove('screen_elements');
            Session::remove('operation_id');
            
            RedirectHandler::exitWithRedirectAction('menu');
        }
        
        // Different operation
        if (!$isError && empty($opdata["error"]) && !empty($opdata["goToOperationScreen"]['operation_name']))
        {
            $id = Operation::getOperationId($opdata["goToOperationName"], $_SESSION['operations']);
            
            RedirectHandler::exitWithRedirectAction('operation', array('id' => $id));
        }
    }
    
    
    public function generateOperationJSON($postedScreenElements, $screenElements, array &$opdata)
    {
        $isError = Registry::$errorHandler->isError();
        if($isError) {
            $opdata["currentScreen"]['id'] = $opdata["prevScreen"]['id'];
            $opdata["currentScreen"]['name'] = $opdata["prevScreen"]['name'];
            $opdata["isNewScreen"] = false;
            $opdata["activeElementName"] = $_SESSION['screens'][$opdata["prevScreen"]['name']]->activeElementId;
            
            $screenElements['{AKTUALNY_EKR}']->setValue($opdata["prevScreen"]['name']);
        }
        
        $currentScreen = $opdata["currentScreen"];
        
        $screenElementsJSON = array();

        $screenRows = self::getScreenRows($currentScreen['id']);
        
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
            
            foreach ($screenElements as $key => $value) {
                if ($screenElements[$key]->getScreenId() === $currentScreen['id']) {
                    
                    if( $currentTabindex != $screenElements[$key]->getTabindex()) {
                        continue;
                    }
                    
                    $json = $screenElements[$key]->generateJSON($screenElements);
                    if (!empty($json)) {
                        $pos = $screenElements[$key]->getPosition();
                        
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
            
        $activeFormName = 'akcje_form';

        // Setting an active control
        $idAttributeValue = !empty($screenElements[$opdata["activeElementName"]]) ? $screenElements[$opdata["activeElementName"]]->getIdAttributeValue() : null;
        if (!empty($idAttributeValue))
        {
            $activeElementId = $idAttributeValue;
        }
        else
        {
            $activeElementId = '';
        }

        $defaultElementName = $_SESSION['screens'][$opdata["currentScreen"]['name']]->defaultElementId;
        $defaultElementId = !empty($screenElements[$defaultElementName]) ? $screenElements[$defaultElementName]->getIdAttributeValue() : null;
        $defaultElement = !empty($defaultElementId)
            ? array(
                'id' => $defaultElementId,
                'name' => $defaultElementName,
                'value' => $screenElements[$defaultElementName]->getValue())
            : null;
        
        //
        $sqlQueries =  ($this->isDebugMode) ? Registry::$debugModeData['sql_queries'] : array();
        $dbInfo = ($this->isDebugMode) ?AppConfig::getDbDataInfo() : array();
        
        $screenElementsDebugJSON = array();
        if ($this->isDebugMode) {
            foreach ($screenElements as $key => $screenElement) {
                $screenElementsDebugJSON[] = array(
                    "key"            => $key,
                    "value"          => $screenElement->getValue(),
                    "type"           => $screenElement->getType(),
                    "executionTime"  => $screenElement->getExecutionTime()
                );
            }
        }
        
        //
        $screen = Session::get('screens')[$opdata["currentScreen"]['name']];

        $appError = Registry::$errorHandler->getLastError();
        
        //
        return array(
            'active_form_name'       => $activeFormName,
            'active_element_id'      => $activeElementId,
            'active_element_name'    => $opdata["activeElementName"],
            'default_element_id'     => $defaultElementId,
            'default_element'        => $defaultElement,
            'screen_elements'        => $screenElementsJSON,
            'posted_screen_elements' => $postedScreenElements,
            'operation_id'           => $this->id,
            'operation_description'  => $this->description,
            'screen_id'              => $currentScreen['id'],
            'screen_name'            => $currentScreen['name'],
            'go_to_operation_screen' => $opdata["goToOperationScreen"],
            'is_new_screen'          => $opdata["isNewScreen"],
            'version'                => $this->version,
            'app_error'              => $appError,
            'error'                  => $opdata["error"],
            'sql_queries'            => $sqlQueries,
            'screen_elements_debug'  => $screenElementsDebugJSON,
            'printer_ip'             => Session::get('ip_drukarki'),
            'printer_port'           => Session::get('port_drukarki'),
            'db_info'                => $dbInfo,
            'operations_enabled'     => AppHelper::stringToBoolean($screen->menuEnabled),
            'logout_enabled'         => AppHelper::stringToBoolean($screen->logoutEnabled),
            'is_debug_mode'          => $this->isDebugMode,
        ); 
    }
    
}
