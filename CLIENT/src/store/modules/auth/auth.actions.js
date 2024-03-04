//
import CmsApiService from "../../../api/CmsApiService.js";

//
import {
    CHANGE_API,
    GET_APIINFO,
    LOGIN,
    LOGOUT,
    RESET_TOKEN
    
} from "../../types/actions.type.js";

//
import {
    SET_ERRORS,
    FETCH_START,
    FETCH_STOP,

    SET_APIDATA,
    SET_APIINFO,

    SET_TOKEN,
    SET_AUTH_CHECKPARAMS,
    SET_AUTH,
    PURGE_AUTH

} from "../../types/mutations.type.js";

//
const actions = {
	
	[CHANGE_API](context, { url }) {
        context.commit(SET_APIDATA, { url: url });
        //return context.dispatch(GET_APIINFO);
    },

    [GET_APIINFO](context) {
        context.commit(FETCH_START, null, { root: true });

        return new Promise((resolve) => {
            CmsApiService.endpoints.info.get()
                .then(response => response.json())
                .then(data => {
                    //console.log(JSON.stringify(data.result)); // eslint-disable-line no-console

                    context.commit(FETCH_STOP, null, { root: true });
                    switch(data.status) {
                        case "OK":
                            if (data.result) {
                                context.commit(SET_APIINFO, { info: data.result });
                                resolve({ info: data.result });
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

    [LOGIN](context, { loginData }) {
        context.commit(FETCH_START, null, { root: true });

        return new Promise((resolve) => {
            CmsApiService.endpoints.auth.login(loginData)
                .then(response => response.json())
                .then(data => {
                    //console.log(JSON.stringify(data.result)); 

                    context.commit(FETCH_STOP, null, { root: true });
                    switch(data.status) {
                        case "OK":
                            if (data.result) {

                                context.commit(SET_AUTH_CHECKPARAMS, {
                                    wrongUsername: data.result.wrongUsername,
                                    wrongPassword: data.result.wrongPassword
                                });
        
                                if (data.result.token) {
                                    context.commit(SET_AUTH, {  
                                        user: loginData.username, 
                                        token: data.result.token, 
                                        expires: data.result.expires, 
                                        isModifyAllowed: data.result.isModifyAllowed
                                    });
                                    resolve({loggedIn: true});
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
    [LOGOUT](context) {
        context.commit(FETCH_START, null, { root: true });
        
        return new Promise((resolve) => {
            CmsApiService.endpoints.auth.logout()
                .then(response => response.json())
                .then(data => {
                    //console.log(JSON.stringify(data.result)); // eslint-disable-line no-console

                    context.commit(FETCH_STOP, null, { root: true });
                    switch(data.status) {
                        case "OK":
                            if (data.result) {
                                resolve({loggedIn: false});
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
                    context.commit(FETCH_STOP, null, { root: true });
                    context.commit(PURGE_AUTH);
                })
                .catch(error => {
                    context.commit(SET_ERRORS, { error: error, type: 0 }, { root: true });
                    context.commit(FETCH_STOP, null, { root: true });
                    context.commit(PURGE_AUTH);
                });
        });
    },

    [RESET_TOKEN](context, { tokendata }) {
        context.commit(SET_TOKEN, {
            token: tokendata.token, 
            expires: tokendata.expires 
        });
    }


}

export default actions;