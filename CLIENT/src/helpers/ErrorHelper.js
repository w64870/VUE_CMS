import AppHelper from "./AppHelper.js";

class ErrorHelper {
  constructor() {}

  static catchError(error, type) {
    let apiErrors = {};

    switch (type) {
        case 1:
            apiErrors.error = error ? error : {};
            apiErrors.showError = !AppHelper.isEmptyObj(apiErrors.error) ? true : false;
            break;
        case 2:
            apiErrors.error2 = error ? error : {};
            apiErrors.showError = !AppHelper.isEmptyObj(apiErrors.error2) ? true : false;
            break;
        case 3:
            apiErrors.error3 = error ? error : "";
            apiErrors.showError = !AppHelper.isEmptyObj(apiErrors.error3) ? true : false;
            break;
        case 0:
            apiErrors.requestError = error ? error : "";
            apiErrors.showError = !AppHelper.isEmptyObj(apiErrors.requestError) ? true : false;
            break;
        default:
            break;
    }  

    return apiErrors;
  }


  static isEmpty(obj) {
    return (
      obj === undefined ||
      obj === null ||
      obj.length === 0 ||
      (Object.keys(obj).length === 0 && obj.constructor === Object)
    );
  }

  static catchApiError(error, error2, screenError) {
    let apiErrors = {};

    apiErrors.error = error ? error : {};
    apiErrors.error2 = error2 ? error2 : {};
    apiErrors.screenError = screenError ? screenError : "";

    apiErrors.showError =
      !AppHelper.isEmptyObj(apiErrors.error) ||
      !AppHelper.isEmptyObj(apiErrors.error2) ||
      !AppHelper.isEmptyObj(apiErrors.screenError)
        ? true
        : false;

    return apiErrors;
  }

  static catchRequestError(error) {
    let apiErrors = {};
    apiErrors.requestError = error ? error : "";
    apiErrors.showError = !AppHelper.isEmptyObj(apiErrors.requestError)
      ? true
      : false;

      return apiErrors;
  }
}

export default ErrorHelper;
