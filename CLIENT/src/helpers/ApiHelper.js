
import AppHelper from "./AppHelper";
const DEFAULT_API = CONFIG.defaultCmsApi.name;
const DEFAULT_URL = CONFIG.defaultCmsApi.url;
const API_LIST = CONFIG.CmsApiList;

class ApiHelper {
    constructor() {}

    static getApiName(url) {
        let api = API_LIST.find(obj => {
            return obj.url === url;
        })

        return !AppHelper.isEmptyObj(api) ? api.name : DEFAULT_API; 
    }

    static getApiUrl(name) {
        let api = API_LIST.find(obj => {
            return obj.name === name;
        })

        return !AppHelper.isEmptyObj(api) ? api.url : DEFAULT_URL; 
    }

    static getBaseUrl(url) {
        return url.substring(0, url.lastIndexOf("api"));
    }

}


export default ApiHelper;