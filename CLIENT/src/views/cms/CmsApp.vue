<template>
    <div>
        <MainView
            v-if="isLoggedIn"
            :apiUrl="apiUrl"
            @onLogout="logout"
        />
        <LoginView
            v-else
            @onLogin="login"
            @onChangeApi="changeApi"
        />
    </div>
</template>


<script>
import MainView from "./MainView.vue";
import LoginView from "./LoginView.vue";

import AuthHandler from "../../handlers/AuthHandler.js";

export default {
    name: "CmsApp",
    components: {
        MainView,
        LoginView
    },
    data: function() {
        return {
            apiUrl: AuthHandler.getApi() || CONFIG.defaultCmsApi.url,
            isLoggedIn: AuthHandler.getLoginStatus() || false
        };
    },
    methods: {
        changeApi: function(data) {
            this.apiUrl = data.apiUrl;
        },
        login: function(data) {
            this.isLoggedIn = data.loggedIn;
        },
        logout: function(data) {
            this.isLoggedIn = data.loggedIn;
        }
    }
};
</script>


<style>
</style>
