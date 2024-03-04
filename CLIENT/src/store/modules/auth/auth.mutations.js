//
import AuthHandler from "../../../handlers/AuthHandler.js";


//
import {
    SET_APIDATA,
    SET_APIINFO,

    SET_TOKEN,
    SET_AUTH_CHECKPARAMS, 
    SET_AUTH,
    PURGE_AUTH,

    SET_USERNAME

} from "../../types/mutations.type.js";

//
const mutations = {
    //
    [SET_APIDATA](state, { url }) {
        AuthHandler.setApi(url);
    },
    [SET_APIINFO](state, { info }) {
        state.apiInfo = info;
    },

    //
    [SET_TOKEN](state, payload) {
        AuthHandler.setToken({
            token: payload.token,
            expires: payload.expires,
        });
    },
    [SET_AUTH_CHECKPARAMS](state, payload) {
        state.wrongUsername = payload.wrongUsername,
        state.wrongPassword = payload.wrongPassword
    },

    [SET_AUTH](state, payload) {
        state.user = payload.user;
        state.modifyAllowed = payload.isModifyAllowed

        AuthHandler.setLoginStatus(true);
        AuthHandler.setAuth({
            user: payload.user,
            token: payload.token,
            expires: payload.expires,
            modifyAllowed: payload.isModifyAllowed,
        });
    },
    [PURGE_AUTH](state) {
        state.apiInfo = {};
        
        state.user = null;
        state.username = null;
        state.wrongUsername = true;
        state.wrongPassword = false;
        state.isModifyAllowed = false;

        AuthHandler.setLoginStatus(false);
        AuthHandler.purgeAuth();
    },

    [SET_USERNAME](state, payload) {
        state.username = payload.username;
    }

}

export default mutations;