<?php

namespace Mes\App\Lib;

class DateTimeFormat 
{
	private $format;
	private $seperator;

	//
	public static $formatTypes = array("php", "jquery", "moment", "luxon");

	// Numeric representation of a month WITHOUT leading zeros (PHP n)
    // Day of the month WITHOUT leading zeros (PHP j)
    // 24-hour format of an hour WITHOUT leading zeros (PHP G)
    // 12-hour format of an hour WITHOUT leading zeros (PHP g)

	public static $mappings = array(
		// A full numeric representation of a year, 4 digits
		"YYYY" => array(
	        "php" => "Y", 
	        "jquery" => "yy",
            "moment" => "YYYY",
	        "luxon" => "yyyy"
    	),
        "RRRR" => array(
            "php" => "Y", 
            "jquery" => "yy",
            "moment" => "YYYY",
            "luxon" => "yyyy"
        ),
    	// A two digit representation of a year
    	"YY" => array(
	        "php" => "y", 
	        "jquery" => "y",
            "moment" => "YY",
	        "luxon" => "yy"
    	),
        "RR" => array(
            "php" => "y", 
            "jquery" => "y",
            "moment" => "YY",
            "luxon" => "yy"
        ),

    	// Numeric representation of a month with leading zeros
		"MM" => array(
	        "php" => "m", 
	        "jquery" => "mm",
            "moment" => "MM",
	        "luxon" => "MM"
    	),
    	
    	// Day of the month with leading zeros
		"DD" => array(
	        "php" => "d", 
	        "jquery" => "dd",
            "moment" => "DD",
	        "luxon" => "dd"
    	),
    	
    	// 24-hour format of an hour with leading zeros
		"HH24" => array(
	        "php" => "H", 
	        "jquery" => "HH",
            "moment" => "HH",
	        "luxon" => "HH"
    	),
    	// 12-hour format of an hour with leading zeros
    	"HH" => array(
	        "php" => "h", 
	        "jquery" => "hh",
            "moment" => "hh",
	        "luxon" => "hh"
    	),
    	
    	// minutes with leading zeros
		"MI" => array(
	        "php" => "i", 
	        "jquery" => "mm",
            "moment" => "mm",
	        "luxon" => "mm"
    	),
    	// seconds with leading zeros
		"SS" => array(
	        "php" => "s", 
	        "jquery" => "ss",
            "moment" => "ss",
	        "luxon" => "ss"
    	)
    );


	//
	public function __construct($format, $seperator)
    {
    	$this->format = $format;
    	$this->seperator = $seperator;
    }


    //
    public function getOracleFormat()
    {
    	return $this->format;
    }

    public function getPhpFormat()
    {
    	return $this->parseFormat("php");
    }

    public function getJqueryFormat()
    {
    	return $this->parseFormat("jquery");
    }

    public function getMomentFormat()
    {
        return $this->parseFormat("moment");
    }

    public function getLuxonFormat()
    {
    	return $this->parseFormat("luxon");
    }


    //
    private function parseFormat($formatType) 
    {
        $elements = explode($this->seperator, $this->format);

        $newElements = array();
        foreach($elements as $element) {
            $el = $this->map($element, $formatType);
            array_push($newElements, $el);
        }

        $newFormat = implode($this->seperator, $newElements);
        return $newFormat;
    }


    private function map($element, $formatType) 
    {
    	if(array_key_exists($element, self::$mappings) && in_array($formatType, self::$formatTypes) ) {
    		return self::$mappings[$element][$formatType];
    	}
    	return "";
    }

}