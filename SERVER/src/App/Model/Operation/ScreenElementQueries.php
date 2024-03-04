<?php

namespace Mes\App\Model\Operation;

class ScreenElementQueries
{
    public $defaultValueQuery;
    public $hiddenQuery;
    public $newWindowScreenQuery;
    public $nextScreenQuery;
    public $procedureQuery;
    public $sqlQuery;
    public $validationQuery;
    public $valueAfterQuery;
    public $valueBeforeQuery;

    public function __construct($defaultValueQuery, 
                                $hiddenQuery, 
                                $newWindowScreenQuery,
                                $nextScreenQuery, 
                                $procedureQuery, 
                                $sqlQuery, 
                                $validationQuery,
                                $valueAfterQuery, 
                                $valueBeforeQuery)
    {
        $this->defaultValueQuery = $defaultValueQuery;
        $this->hiddenQuery = $hiddenQuery;
        $this->newWindowScreenQuery = $newWindowScreenQuery;
        $this->nextScreenQuery = $nextScreenQuery;
        $this->procedureQuery = $procedureQuery;
        $this->sqlQuery = $sqlQuery;
        $this->validationQuery = $validationQuery;
        $this->valueAfterQuery = $valueAfterQuery;
        $this->valueBeforeQuery = $valueBeforeQuery;
    }
}
