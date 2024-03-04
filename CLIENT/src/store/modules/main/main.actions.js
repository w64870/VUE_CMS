//
import CmsApiService from "../../../api/CmsApiService.js";
import AppHelper from "../../../helpers/AppHelper";

//
import {
    RESET_OPERATIONS,
    GET_APP,
    GET_SCREENDATA,
    SUBMIT_SCREEN,
    PURGE_APP,
    TOGGLE_OPERATIONS,
    CHANGE_CONTEXT,
    CHANGE_OPERATION,
    CHANGE_PASSWORD,
    CREATE_USER
} from "../../types/actions.type.js";

//
import {
    FETCH_START,
    FETCH_STOP,
    RESET_ERRORS,
    SET_ERRORS,
    SET_INFO_MESSAGE,
    SET_TOKEN,
    SET_USERNAME,
    PURGE_AUTH,
    //
    SET_CURRENT_CONTEXT,
    SET_CURRENT_OPERATION,
    HIDE_OPERATIONS,
    SHOW_OPERATIONS,
    SET_CONTEXTS,
    SET_OPERATIONS,
    SET_SCREENDATA,
    SET_SETTINGS,
    SET_FEATURES_STATUS,
    SET_DEBUG_STATUS,
    SET_FORM_VALUES,
    FILTER_FORM_VALUES,
    RESET_VALUES
} from "../../types/mutations.type.js";

//
const actions = {

    //
    [RESET_OPERATIONS](context) {
        context.commit(FETCH_START, null, { root: true });

        return new Promise((resolve) => {
            CmsApiService.endpoints.operations
                .reset(null, {})
                .then(response => response.json())
                .then(data => {
                    //console.log(JSON.stringify(data.result)); // eslint-disable-line no-console

                    context.commit(FETCH_STOP, null, { root: true });
                    switch(data.status) {
                        case "OK":
                            if (data.result) {
                                if (data.result.token) {
                                    context.commit(SET_TOKEN, {  
                                        token: data.result.token, 
                                        expires: data.result.expires 
                                    });
                                    resolve({ timeout: data.result.expires });
                                }

                                if (data.result.error) {
                                    context.commit(SET_ERRORS, { error: data.result.error, type: 3 }, { root: true });
                                }
                            }
                            break;
                        case "error":
                            context.commit(SET_ERRORS, { error: data.result, type: 1 }, { root: true });
                            break;
                        case "error2":
                            context.commit(SET_ERRORS, { error: data.result, type: 2 }, { root: true });
                            break;
                        default:
                            break;
                    }
                })
                .catch(error => {
                    context.commit(SET_ERRORS, { error: error, type: 0 }, { root: true });
                });
        });
    },
    [GET_APP](context) {
        context.commit(FETCH_START, null, { root: true });
        context.commit(RESET_ERRORS, null, { root: true });
        context.commit(SHOW_OPERATIONS);

        return new Promise((resolve) => {

            CmsApiService.endpoints.app
                .getAll({ context: context.state.currentContext })
                .then(response => response.json())
                .then(data => {
                    //console.log(JSON.stringify(data.result)); // eslint-disable-line no-console
                    context.commit(FETCH_STOP, null, { root: true });
                    
                    switch(data.status) {
                        case "OK":
                            if (data.result) {

                                context.commit(SET_CONTEXTS, { contexts: data.result.contexts });
                                context.commit(SET_OPERATIONS, { operations: data.result.operations });
                                context.commit(SET_SCREENDATA, { screenData: [] });

                                context.commit(SET_USERNAME, { username: data.result.username }, { root: true });
                                context.commit(SET_SETTINGS, { settings: data.result.settings });
                                
                                if (data.result.tokendata) {
                                    context.commit(SET_TOKEN, {  
                                        token: data.result.tokendata.token, 
                                        expires: data.result.tokendata.expires 
                                    });
                                }

                                if (data.result.error) {
                                    context.commit(SET_ERRORS, { error: data.result.error, type: 3 }, { root: true });
                                }

                                resolve({ timeout: data.result.tokendata.expires });
                            }
                            break;
                        case "error":
                            context.commit(SET_ERRORS, { error: data.result, type: 1 }, { root: true });
                            break;
                        case "error2":
                            context.commit(SET_ERRORS, { error: data.result, type: 2 }, { root: true });
                            break;
                        default:
                            break;
                    }
                })
                .catch(error => {
                    context.commit(SET_ERRORS, { error: error, type: 0 }, { root: true });
                });
        });
    },
    [GET_SCREENDATA](context) {
        context.commit(FETCH_START, null, { root: true });
        context.commit(RESET_ERRORS, null, { root: true });
        context.commit(HIDE_OPERATIONS);

        return new Promise((resolve) => {
            CmsApiService.endpoints.operations
                .postOne(context.state.currentOperation, null, { 
                    formValues: {}
                })
                .then(response => response.json())
                .then(data => {
                    //console.log(JSON.stringify(data.result)); // eslint-disable-line no-console
                    context.commit(FETCH_STOP, null, { root: true });
                    
                    switch(data.status) {
                        case "OK":
                            if (data.result) {
                                context.commit(SET_SCREENDATA, { screenData: data.result });
                                context.commit(SET_FORM_VALUES, { screenElements: data.result.screen_elements });

                                context.commit(SET_FEATURES_STATUS, {
                                    contextsEnabled: data.result.operations_enabled,
                                    operationsEnabled: data.result.operations_enabled,
                                    logoutEnabled: data.result.logout_enabled
                                });

                                if (data.result.tokendata) {
                                    context.commit(SET_TOKEN, {  
                                        token: data.result.tokendata.token, 
                                        expires: data.result.tokendata.expires 
                                    });
                                }

                                if (data.result.error) {
                                    context.commit(SET_ERRORS, { error: data.result.error, type: 3 }, { root: true });
                                }

                                resolve({ timeout: data.result.tokendata.expires });
                            }
                            break;
                        case "error":
                            context.commit(SET_ERRORS, { error: data.result, type: 1 }, { root: true });
                            break;
                        case "error2":
                            context.commit(SET_ERRORS, { error: data.result, type: 2 }, { root: true });
                            break;
                        default:
                            break;
                    }
                })
                .catch(error => {
                    context.commit(SET_ERRORS, { error: error, type: 0 }, { root: true });
                });
        });
    },
    [CHANGE_PASSWORD](context, { changePasswordData }) {
        context.commit(FETCH_START, null, { root: true });
        context.commit(RESET_ERRORS, null, { root: true });

        return new Promise((resolve) => {
            CmsApiService.endpoints.auth
                .changePassword(changePasswordData)
                .then(response => response.json())
                .then(data => {
                    //console.log(JSON.stringify(data.result)); // eslint-disable-line no-console
                    context.commit(FETCH_STOP, null, { root: true });
                    
                    switch(data.status) {
                        case "OK":
                            if (data.result.error) {
                                context.commit(SET_ERRORS, { error: data.result.error, type: 3 }, { root: true });
                            }    
                            resolve({});
                            break;
                        case "error":
                            context.commit(SET_ERRORS, { error: data.result, type: 1 }, { root: true });
                            break;
                        case "error2":
                            context.commit(SET_ERRORS, { error: data.result, type: 2 }, { root: true });
                            break;
                        default:
                            break;
                    }
                })
                .catch(error => {
                    context.commit(SET_ERRORS, { error: error, type: 0 }, { root: true });
                });
        });
    },
    [CREATE_USER](context, { createUserData }) {
        context.commit(FETCH_START, null, { root: true });
        context.commit(RESET_ERRORS, null, { root: true });

        return new Promise((resolve) => {
            CmsApiService.endpoints.auth
                .createUser(createUserData)
                .then(response => response.json())
                .then(data => {
                    //console.log(JSON.stringify(data.result)); // eslint-disable-line no-console
                    context.commit(FETCH_STOP, null, { root: true });
                    
                    switch(data.status) {
                        case "OK":
                            if (data.result.error) {
                                context.commit(SET_ERRORS, { error: data.result.error, type: 3 }, { root: true });
                            }    
                            resolve({});
                            break;
                        case "error":
                            context.commit(SET_ERRORS, { error: data.result, type: 1 }, { root: true });
                            break;
                        case "error2":
                            context.commit(SET_ERRORS, { error: data.result, type: 2 }, { root: true });
                            break;
                        default:
                            break;
                    }
                })
                .catch(error => {
                    context.commit(SET_ERRORS, { error: error, type: 0 }, { root: true });
                });
        });
    },
    //
    [SUBMIT_SCREEN](context, { formValues, alert }) {
        context.commit(FETCH_START, null, { root: true });
        context.commit(RESET_ERRORS, null, { root: true });

        return new Promise((resolve) => {
            CmsApiService.endpoints.operations
                .postOne(context.state.currentOperation, null, {
                    formValues: formValues
                })
                .then(response => response.json())
                .then(data => {
                    //console.log(JSON.stringify(data.result)); // eslint-disable-line no-console
                    context.commit(FETCH_STOP, null, { root: true });
                    
                    switch(data.status) {
                        case "OK":
                            if (data.result) {
                                context.commit(SET_SCREENDATA, { screenData: data.result });
                                context.commit(SET_FORM_VALUES, { screenElements: data.result.screen_elements });

                                context.commit(SET_FEATURES_STATUS, {
                                    contextsEnabled: data.result.operations_enabled,
                                    operationsEnabled: data.result.operations_enabled,
                                    logoutEnabled: data.result.logout_enabled
                                });

                                if(!AppHelper.isEmptyObj(alert)) {
                                    context.commit(SET_INFO_MESSAGE, { message: alert }, { root: true });
                                }

                                if (data.result.tokendata) {
                                    context.commit(SET_TOKEN, {  
                                        token: data.result.tokendata.token, 
                                        expires: data.result.tokendata.expires 
                                    });
                                }

                                if (data.result.error) {
                                    context.commit(SET_ERRORS, { error: data.result.error, type: 3 }, { root: true });
                                }
                            }

                            context.commit(FILTER_FORM_VALUES, { screenElements: context.state.screenData.screen_elements });

                            resolve({ 
                                timeout: data.result.tokendata.expires,
                                isRedirect: false,
                            });
                            break;
                        case "redirect":
                            if (data.result) {
                                resolve({ 
                                    timeout: null,//data.result.tokendata.expires,
                                    isRedirect: true,
                                    redirect: {
                                        action: data.result.action,
                                        url: data.result.url,
                                        params: data.result.params
                                    }
                                    
                                });
                            }
                            break;
                        case "error":
                            context.commit(SET_ERRORS, { error: data.result, type: 1 }, { root: true });
                            break;
                        case "error2":
                            context.commit(SET_ERRORS, { error: data.result, type: 2 }, { root: true });
                            break;
                        default:
                            break;
                    }
                })
                .catch(error => {
                    context.commit(SET_FORM_VALUES, { screenElements: context.state.screenData.screen_elements });
                    context.commit(SET_ERRORS, { error: error, type: 0 }, { root: true });
                });
        });
    },
    //
    [PURGE_APP](context) {
        context.commit(RESET_ERRORS);
        context.commit(RESET_VALUES);
        context.commit(PURGE_AUTH, null, { root: true });
    },
    [TOGGLE_OPERATIONS](context) {
        if (context.state.operationsVisible) {
            context.commit(HIDE_OPERATIONS);
        } else {
            context.commit(SHOW_OPERATIONS);
        }
    },
    [CHANGE_CONTEXT](context, { contextId  }) {
        context.commit(SET_CURRENT_CONTEXT, { contextId: contextId  });
        context.commit(SET_CURRENT_OPERATION, { operationId: null });

        context.commit(SET_FEATURES_STATUS, {
            contextsEnabled: true,
            operationsEnabled: true,
            logoutEnabled: true
        });
    },
    [CHANGE_OPERATION](context, { operationId  }) {
        context.commit(SET_CURRENT_OPERATION, { operationId: operationId });
        context.commit(SET_DEBUG_STATUS, { operationId: operationId });

        context.commit(SET_FEATURES_STATUS, {
            contextsEnabled: true,
            operationsEnabled: true,
            logoutEnabled: true
        });
    }

}

export default actions;