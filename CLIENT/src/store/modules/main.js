//
import actions from "./main/main.actions.js";
import getters from "./main/main.getters.js";
import mutations from "./main/main.mutations.js";

const main = {
    state: {
        operationsVisible: true,
        currentContext: null,
        currentOperation: null,
        
        contexts: [],
        operations: [],
        screenData: [],
        
        formValues: [],

        debugStatus: false,
        settings: null,

        contextsEnabled: true,
        operationsEnabled: true,
        logoutEnabled: true
    },

    mutations: mutations,
    actions: actions,
    getters: getters

};

export default main;