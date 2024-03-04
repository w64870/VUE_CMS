//
import ErrorHelper from "../helpers/ErrorHelper.js";

import {
    SET_ERRORS,
    SET_INFO_MESSAGE,
    RESET_ERRORS,
    FETCH_START,
    FETCH_STOP,
} from "./types/mutations.type.js";

//
const mutations = {
    [SET_ERRORS](state, { error, type }) {
        state.isLoading = false;
        
        let err = ErrorHelper.catchError(error, type);
        state.apiErrors = err;
        state.showError = true;

        if (err.error) {
            state.errorLevel = err.error.level;
        } else if(err.error3) {
            state.errorLevel = 1;
        } else {
            state.errorLevel = 0;
        }
        
    },

    [SET_INFO_MESSAGE](state, { message }) {
        state.infoMessage = message;
        state.showInfo = true;
    },

    [RESET_ERRORS](state) {
        state.isLoading = false;
        state.apiErrors = {};
        state.showError = false;
        state.infoMessage = {};
        state.showInfo = false;
    },

    [FETCH_START](state) {
        state.isLoading = true;
    },
    [FETCH_STOP](state) {
        state.isLoading = false;
    }
}

export default mutations;