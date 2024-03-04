//
const getters = {
    isOperationsVisible: state => () => {
        return state.operationsVisible;
    },
    getCurrentContext: state => () => {
        return state.currentContext;
    },
    getCurrentOperation: state => () => {
        return state.currentOperation;
    },
    getContexts: state => () => {
        return state.contexts;
    },
    getOperations: state => () => {
        return state.operations;
    },
    getScreenData: state => () => {
        return state.screenData;
    },
    getFormValues: state => () => {
        return state.formValues;
    },
    getDebugStatus: state => () => {
        return state.debugStatus;
    },
    getSettings: state => () => {
        return state.settings;
    },
    isContextsEnabled: state => () => {
        return state.contextsEnabled;
    },
    isOperationsEnabled: state => () => {
        return state.operationsEnabled;
    },
    isLogoutEnabled: state => () => {
        return state.logoutEnabled;
    }
}

export default getters;
