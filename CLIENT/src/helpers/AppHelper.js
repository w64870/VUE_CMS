
class AppHelper {

    constructor() {}

    static isEmptyStr(str) {
        return (
            str === undefined ||
            str === null ||
            str.length === 0
        );
    }

    static isEmptyArr(arr) {
        return (
            !Array.isArray(arr) || !arr.length
        );
    }

    static isEmptyObj(obj) {
        return (
            obj === undefined ||
            obj === null ||
            obj.length === 0 ||
            (Object.keys(obj).length === 0 && obj.constructor === Object)
        );
    }

    static isBool(val) {
        return (val === true || val === false);
    }
    

    static convertSquareToAngleBrackets(text) {
        if (AppHelper.isEmptyStr(text)) {
            return text;
        }
        let leftConverted = text.replace(/\[/gi, "<");
        return leftConverted.replace(/\]/gi, ">");
    }

    static convertToCamelCase(text) {
        if (AppHelper.isEmptyStr(text)) {
            return text;
        }

        return text.replace(/(?:^\w|[A-Z]|\b\w|\s+)/g, function(match, index) {
            if (+match === 0) return "";
            return index == 0 ? match.toLowerCase() : match.toUpperCase();
        }).replace(/[-]+/g, "");
    }

    static getStyles(styleStr) {

        if (AppHelper.isEmptyStr(styleStr)) {
            return styleStr;
        }

        let styles = {};
        let styleArr = styleStr.replace(/("|')+/gi, "").split(";");

        styleArr.forEach(pair => {
            if (!AppHelper.isEmptyStr(pair)) {
                let pairArr = pair.split(":");
                styles[AppHelper.convertToCamelCase(pairArr[0].trim())] = pairArr[1].trim();
            }
        });

        return styles;
    }


    static getAttributes(attributeStr) {

        if (AppHelper.isEmptyStr(attributeStr)) {
            return attributeStr;
        }

        let attributes = {};
        let attributeArr = attributeStr.split(/ (?=([^\"]*\"[^\"]*\")*[^\"]*$)/gi);

        attributeArr.forEach(pair => {
            if (!AppHelper.isEmptyStr(pair)) {
                let pairArr = pair.split("=");
                let val = null;

                if(pairArr[0].trim().toLowerCase() == "style") {
                    val = AppHelper.getStyles(pairArr[1]);
                } else {
                    val = pairArr[1].trim().replace(/("|')+/gi, "");
                }

                attributes[AppHelper.convertToCamelCase(pairArr[0].trim())] = val;
            }
        });

        return attributes;
    }

    static findAttribute(attributeObj, attribute) {

        if (AppHelper.isEmptyObj(attributeObj)) {
            return "";
        }
        if( !AppHelper.isEmptyStr(attributeObj[attribute])) {
            return attributeObj[attribute]; 
        }

        return ""
    }
    
  }
  
  export default AppHelper;
  