//
const getters = {
    isLoading: state => () => {
        return state.isLoading;
    },
    isError: state => () => {
        return state.showError;
    },
    getApiErrors: state => () => {
        return state.apiErrors;
    },
    getErrorLevel: state => () => {
        return state.errorLevel;
    },
    getInfoMessage: state => () => {
        return state.infoMessage;
    },
    isInfo: state => () => {
        return state.showInfo;
    },
}

export default getters;