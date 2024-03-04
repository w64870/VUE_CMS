//
import actions from "./auth/auth.actions.js";
import mutations from "./auth/auth.mutations.js";

import AuthHandler from "../../handlers/AuthHandler.js";


const auth = {
    state: {
        apiInfo: {},

        user: null,
        wrongUsername: true,
        wrongPassword: false,
        modifyAllowed: false,

        username: null
    },

    mutations: mutations,
    actions: actions,

    getters: {
        getApiInfo: state => () => {
            return state.apiInfo;
        },
        getApiUrl: state => () => {
            return AuthHandler.getApi();
        },
        getUser: state => () => {
            return state.user;
        },
        isLoggedIn: state => () => {
            return AuthHandler.getLoginStatus();
        },
        isWrongUsername:  state => () => {
            return state.wrongUsername;
        },
        isWrongPassword: state => () => {
            return state.wrongPassword;
        },
        getUsername: state => () => {
            return state.username;
        },
        isModifyAllowed: state => () => {
            return state.modifyAllowed;
        }
    }

};

export default auth;