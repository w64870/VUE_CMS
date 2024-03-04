<template>
    <div class="container-fluid">
        <div class="row">
            <Contexts
                :contexts="contexts"
                :apiInfo="apiInfo"
                :currentContext="currentContext"
                @onToggleOperations="toggleOperations"
                @onSelectContext="changeContext"
                @onResetOperations="resetOperations"
                @onModifyOperations="modifyOperations"
                @onUpsertUser="upsertUser"
                @onLogout="logout"
                :time="time"
                :user="user"
                :username="username"
                :isModifyAllowed="isModifyAllowed"
                :disabled="contextsDisabled"
                :logoutDisabled="logoutDisabled"
                :isLoading="isLoading"
            />
        </div>
        <div v-if="isUpsertUser === false" class="row content">
            <Operations
                :operations="operations"
                :currentContext="currentContext"
                :currentOperation="currentOperation"
                :isOpMenuOpen="isOpMenuOpen"
                @onSelectOperation="changeOperation"
                :disabled="operationsDisabled"
            />
            <Screen
                :apiInfo="apiInfo"
                :currentContext="currentContext"
                :currentOperation="currentOperation"
                :isOpMenuOpen="isOpMenuOpen"
                :screenData="screenData"
                :formValues="formValues"
                :debug="debug"
                
                :isLoading="isLoading"

                @onSubmit="submitForm"
            />
        </div>
        <div v-else class="row content">
            <UserMenu
                :isModifyAllowed="isModifyAllowed"
                @onChangePassword="changePassword"
                @onCreateUser="creatUser"
                @onAssignOpUser="assingOpUser"
            />
        </div>
    </div>
</template>


<script>
import version from "../../strings/version.js";

import AuthHandler from "../../handlers/AuthHandler.js";

import Contexts from "../../components/app/Contexts.vue";
import Operations from "../../components/app/Operations.vue";
import Screen from "../../components/app/Screen.vue";

import UserMenu from "../../components/app/UserMenu.vue";

import {
    LOGOUT,
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
} from "../../store/types/actions.type.js";


//
export default {
    name: "MainView",
    props: ["apiUrl"],
    components: {
    Contexts,
    Operations,
    Screen,
    UserMenu
},
    data: function() {
        return {
            version: version,
            timer: null,
            time: 0,
            isUpsertUser: false
        };
    },
    computed: {
        isLoading: function() {
            return this.$store.getters.isLoading();
        },
        apiInfo: function() {
            return this.$store.getters.getApiInfo();
        },
        //
        isOpMenuOpen: function() {
            return this.$store.getters.isOperationsVisible();
        },
        currentContext: function() {
            return this.$store.getters.getCurrentContext();
        },
        currentOperation: function() {
            return this.$store.getters.getCurrentOperation();
        },
        contexts: function() {
            return this.$store.getters.getContexts();
        },
        operations: function() {
            return this.$store.getters.getOperations();
        },
        screenData: function() {
            return this.$store.getters.getScreenData();
        },
        //
        formValues: function() {
            return this.$store.getters.getFormValues();
        },
        debug: function() {
            return this.$store.getters.getDebugStatus();
        },
        settings: function() {
            return this.$store.getters.getSettings();
        },
        user: function() {
            return this.$store.getters.getUser();
        },
        username: function() {
            return this.$store.getters.getUsername();
        },
        isModifyAllowed: function() {
            return this.$store.getters.isModifyAllowed();
        },
        contextsDisabled: function() {
            return !this.$store.getters.isContextsEnabled();
        },
        operationsDisabled: function() {
            return !this.$store.getters.isOperationsEnabled();
        },
        logoutDisabled: function() {
            return !this.$store.getters.isLogoutEnabled();
        },
        
        
    },
    methods: {
        toggleOperations: function() {
            if (this.isUpsertUser) this.isUpsertUser = false;

            this.$store.dispatch(TOGGLE_OPERATIONS);
        },
        changeContext: function(contextId) {
            if (this.isUpsertUser) this.isUpsertUser = false;

            this.$store.dispatch(CHANGE_CONTEXT, { contextId: contextId });
            this.getApp();
        },
        changeOperation: function(operationId) {
            this.$store.dispatch(CHANGE_OPERATION, { operationId: operationId });

            if (!this.currentOperation) {
                this.getApp();
            } else {
                this.getScreenData();
            }
        },
        //
        resetOperations: function() {
            if (!this.isLoading) {
                this.$store.dispatch(RESET_OPERATIONS)
                    .then((data) => {
                        this.setTimer(data.timeout);
                        this.changeContext();
                    });
            }
        },
        //
        modifyOperations: function() {
            if (this.isUpsertUser) this.isUpsertUser = false;
            this.$store.dispatch(CHANGE_OPERATION, { operationId: "UPSERT_OP" });

            if (!this.currentOperation) {
                this.getApp();
            } else {
                this.getScreenData();
            }
        },
        //
        assingOpUser: function() {
            if (this.isUpsertUser) this.isUpsertUser = false;
            this.$store.dispatch(CHANGE_OPERATION, { operationId: "UPSERT_USER" });

            if (!this.currentOperation) {
                this.getApp();
            } else {
                this.getScreenData();
            }
        },
        //
        upsertUser: function() {
            this.isUpsertUser = true;
        },
        //
        getApp: function() {
            if (!this.isLoading) {
                this.$store.dispatch(GET_APP)
                    .then((data) => {
                        this.setTimer(data.timeout);
                    });
            }
        },
        getScreenData: function() {
            if (!this.isLoading) {
                this.$store.dispatch(GET_SCREENDATA)
                    .then((data) => {
                        this.setTimer(data.timeout);
                    });
            }
        },
        //
        submitForm: function(submitData) {
            //console.log("submitData", submitData);
            this.submitScreen(submitData.formValues);
        },
        submitScreen: function(formValues, alert={}) {
            //console.log("SUBMIT_FORM: ", formValues); // eslint-disable-line no-console
            if (!this.isLoading) {

                let payload = {
                    formValues: formValues,
                    alert: alert
                }

                this.$store.dispatch(SUBMIT_SCREEN, payload)
                    .then((data) => {
                        if(data.timeout) {
                            this.setTimer(data.timeout);
                        }

                        if(data.isRedirect) {
                            switch (data.redirect.action) {
                                case "logout":
                                    this.logout();
                                    break;
                                case "menu":
                                    this.changeOperation();
                                    break;
                                case "operation":
                                    this.changeOperation(
                                        data.redirect.params.id
                                    );
                                    break;
                                default:
                                    window.location.href = data.redirect.url;
                                    break;
                            }
                        }
                    });
            }
        },
        //
        changePassword: function(changePasswordData){
            this.$store.dispatch(CHANGE_PASSWORD, { changePasswordData: changePasswordData });
        },
        creatUser: function(createUserData){
            this.$store.dispatch(CREATE_USER, { createUserData: createUserData });
        },
        //
        logout: function() {
            this.$store.dispatch(LOGOUT)
                .then(() => {
                    console.log("API: LOGOUT"); // eslint-disable-line no-console
                });

            this.$store.dispatch(PURGE_APP);
            clearInterval(this.timer);
            this.$emit("onLogout", { loggedIn: false });
        },
        //
        setTimer: function(expireTime) {
            let now = Math.floor(Date.now() / 1000);
            this.time = expireTime - now;
        },
        startTimer: function() {
            if (!this.timer) {
                this.timer = setInterval(() => {
                    if (this.time > 0) {
                        this.time--;
                    } else {
                        this.stopTimer();
                    }
                }, 1000);
            }
        },
        stopTimer: function() {
            this.logout();
        }
    },

    created() {
        this.getApp();

        let auth = AuthHandler.getAuth();
        this.setTimer(auth.expires);
        this.startTimer();
    }
};
</script>


<style>
</style>

