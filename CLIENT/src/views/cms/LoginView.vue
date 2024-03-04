<template>
    <div id="app" class="container-fluid">
        <div class="row">
            <div class="col-12 col-md-8 offset-md-2 center loader-div">
                <vue-simple-spinner v-if="isLoading" size="large" message="Wczytywanie..."></vue-simple-spinner>
            </div>
        </div>
        <div class="row">
            <ErrorAlert class="col-12 col-md-8 offset-md-2"/>
        </div>
        <div class="row">
            <LoginForm
                :apiInfo="apiInfo"
                :apiName="apiName"
                :apiUrl="apiUrl"
                :apiList="CmsApiList"
                :defaultApi="defaultApi"
                :version="version"
                :wrongUsername="wrongUsername"
                :wrongPassword="wrongPassword"
                @onSubmit="login"
                @onChangeApi="changeApi"
                :autocomplete="autoComplete"
            />
        </div>
    </div>
</template>


<script>
import version from "../../strings/version.js";
import CmsApiService from "../../api/CmsApiService.js";

import AuthHandler from "../../handlers/AuthHandler.js";
import ErrorHelper from "../../helpers/ErrorHelper.js";

import ErrorAlert from "../../components/app/ErrorAlert.vue";
import LoginForm from "../../components/app/LoginForm.vue";

import {
    CHANGE_API,
    GET_APIINFO,
    LOGIN
} from "../../store/types/actions.type.js";

export default {
    name: "LoginView",
    props: [],
    components: {
        ErrorAlert,
        LoginForm
    },
    data: function() {
        return {
            version: version,
            
            CmsApiList: CONFIG.CmsApiList,
            defaultApi: CONFIG.defaultCmsApi,
            apiName: CONFIG.defaultCmsApi.name,
            autoComplete: CONFIG.AutoComplete,
        
            wrongUsername: this.$store.getters.isWrongUsername(),
            wrongPassword: this.$store.getters.isWrongPassword()
        };
    },
    computed: {
        isLoading: function() {
            return this.$store.getters.isLoading();
        },
        apiInfo: function() {
            return this.$store.getters.getApiInfo();
        },
        apiUrl: function() {
            return this.$store.getters.getApiUrl();
        },
        user: function() {
            return this.$store.getters.getUser();
        }
    },
    methods: {
        changeApi: function(url) {
            this.$store.dispatch(CHANGE_API, { url: url });
            this.$store.dispatch(GET_APIINFO, { url: url })
                .then(data => {
                    this.$emit("onChangeApi", url);
                });
        },
        login: function(loginData) {
            this.$store.dispatch(LOGIN, { loginData: loginData } )
                .then(data => {
                    this.$emit("onLogin", { loggedIn: data.loggedIn });
                })
                .catch(() => {
                    this.$emit("onLogin", { loggedIn: false });
                });
        }
    },
    created: function() {
        this.changeApi(this.defaultApi.url);
    }
};
</script>


<style>
</style>
