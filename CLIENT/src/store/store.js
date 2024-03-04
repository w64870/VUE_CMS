//
import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

//
import actions from "./actions.js"
import getters from "./getters.js"
import mutations from "./mutations.js"

//
import auth from "./modules/auth.js"
import main from "./modules/main.js"


const store = new Vuex.Store({
    modules: {
        auth: auth,
        main: main,
    },

    state: {
        isLoading: false,
        
        apiErrors: {},
        showError: false,
        errorLevel: 0,
        
        infoMessage: {},
        showInfo: false,
    },
    
    mutations: mutations,
    actions: actions,
    getters: getters

});

export default store;