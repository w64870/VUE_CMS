//
import { DateTime } from "luxon";
import AppHelper from "../../../helpers/AppHelper";

//
import {
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

    RESET_VALUES,
} from "../../types/mutations.type.js";

//
const formInputs = [
    "CHECKBOX",
    "LIST",
    "NUMBER",
    "TABELA_CHECKBOX",
    "TEXT",
    "TEXTAREA",
    "VAL"
];

//
const mutations = {
    [SET_CURRENT_CONTEXT](state, { contextId  }) {
        state.currentContext = contextId;
    },
    [SET_CURRENT_OPERATION](state, { operationId  }) {
        state.currentOperation = operationId;
    },
    [HIDE_OPERATIONS](state) {
        state.operationsVisible = false;
    },
    [SHOW_OPERATIONS](state) {
        state.operationsVisible = true;
    },
    [SET_CONTEXTS](state, { contexts }) {
        state.contexts = contexts;

        let contextFound = false;
        for (let i = 0; i < state.contexts.length; i++) {
            if (state.contexts[i].id == state.currentContext) {
                contextFound = true;
                break;
            }
        }
        if (!contextFound) { state.currentContext = null; }
    },
    [SET_OPERATIONS](state, { operations }) {
        state.operations = operations;
    },
    [SET_SCREENDATA](state, { screenData }) {
        state.screenData = screenData;
    },
    //
    [SET_SETTINGS](state, { settings }) {
        state.settings = settings;
    },
    [SET_FEATURES_STATUS](state, payload) {
        state.contextsEnabled = payload.contextsEnabled;
        state.operationsEnabled = payload.operationsEnabled;
        state.logoutEnabled = payload.logoutEnabled;
    },
    [SET_DEBUG_STATUS](state, { operationId }) {
        for (let op of state.operations) {
            if (op.id == operationId) {
                state.debugStatus = op.isDebugMode === true ? true : false;
                break;
            }
        }
    },
    //
    [SET_FORM_VALUES](state, { screenElements }) {
        state.formValues = {};

        let createFormElement = element => {
            if (formInputs.indexOf(element["type"]) != -1) {
                state.formValues[element["nameAttribute"]] =
                    element["value"];
            }
            if (element.type == "DATA" || element.type == "DATETIME") {
                let dateStr = !AppHelper.isEmptyStr(element["value"])
                    ? new DateTime.fromFormat(element["value"], element["format"]).toISO()
                    : new DateTime.local().toISO();

                state.formValues[element["nameAttribute"]] = dateStr;
            }
        };

        screenElements.forEach(row => {
            row.first_elements.forEach(createFormElement);
            row.middle_elements.forEach(createFormElement);
            row.last_elements.forEach(createFormElement);
        });
    },
    [FILTER_FORM_VALUES](state, { screenElements }) {
        let filterFormElement = element => {
            if (formInputs.indexOf(element["type"]) == -1) {
                delete state.formValues[element["nameAttribute"]];
            }
        };

        screenElements.forEach(row => {
            row.first_elements.forEach(filterFormElement);
            row.middle_elements.forEach(filterFormElement);
            row.last_elements.forEach(filterFormElement);
        });
    },
    //
    [RESET_VALUES](state) {
        state.operationsVisible = true;
        state.currentContext = null;
        state.currentOperation = null;
        
        state.contexts = [];
        state.operations = [];
        state.screenData = [];
        
        state.formValues = [];

        state.debugStatus = false;
        state.settings = null;

        state.contextsEnabled = true;
        state.operationsEnabled = true;
        state.logoutEnabled = true;
    }
    
    
}

export default mutations;