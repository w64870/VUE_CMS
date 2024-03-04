<template>
    <div class="col-12 col-md-8 offset-md-2">
        <div v-if="apiInfo.page_data">
            <div class="text-center">
                <img
                    v-if="apiInfo.page_data.logo_file_path"
                    id="id_logo"
                    :src="apiInfo.page_data.logo_file_path"
                    alt="Logo"
                />
            </div>
            <div
                v-if="apiInfo.page_data.text_under_logo"
                id="id_text_under_logo"
                class="text-center"
            >{{ apiInfo.page_data.text_under_logo }}</div>
            <h1 class="text-center">CMS</h1>
            <div
                v-if="apiInfo.page_data.show_current_date"
                id="id_current_date"
                class="text-center"
            >
                <Clock element :format="apiInfo.page_data.date_format" />
            </div>
            <template v-for="(item, idx) in apiInfo.page_data.text_data">
                <div :key="idx" class="text-center">{{ item.label + item.text }}</div>
            </template>
        </div>
        
        <div class="login-form">
            <b-form @submit="submit" @reset="reset">

                <b-form-group id="usernameGroup" label="Użytkownik:" label-for="username">
                    <b-form-input
                        ref="loginUsername"
                        id="username"
                        type="text"
                        v-model="username"
                        placeholder="Podaj nazwę użytkownika"
                        :autocomplete="autocomplete"
                    />
                </b-form-group>

                <b-form-group id="passwordGroup" label="Hasło:" label-for="password">
                    <b-form-input
                        ref="loginPassword"
                        id="password"
                        type="password"
                        v-model="password"
                        placeholder="Podaj hasło"
                    />
                </b-form-group>
                <div class="d-flex justify-content-center">
                    <b-button
                        ref="loginButton"
                        type="submit"
                        class="login-button"
                        variant="primary"
                    >Zaloguj</b-button>
                </div>
            </b-form>
        </div>
        <div v-if="apiInfo">
            <div v-if="apiInfo.ip" class="text-center">Adres IP: {{ apiInfo.ip }}</div>
            <div
                class="text-center text-bold"
            >Wersja webklienta: &lt;{{ version.number }} ({{ version.date }})&gt;</div>
            <div
                v-if="apiInfo.version"
                class="text-center text-bold"
            >Wersja API: {{ apiInfo.version }}</div>
            
        </div>
        <div class="center">
            <b-button
                    type="button"
                    class="login-button api-qr-btn"
                    variant="secondary"
                    @click="toggleTechInfo"
                >{{ showTechInfo ? "Schowaj informacje techniczne" : "Pokaż informacje techniczne" }}</b-button>
        </div>
        <div v-if="apiInfo && showTechInfo" class="text-center">
            <div v-if="apiInfo.techInfo" class="text-center text-bold">Dane techniczne</div>
            <div v-if="apiInfo.techInfo" class="text-center">Wersja PHP: {{ apiInfo.techInfo.phpVersion }}</div>
            <div v-if="apiInfo.techInfo" class="text-center">Wersja Oracle: {{ apiInfo.techInfo.oracleVersion }}</div>
            <div v-if="apiInfo.techInfo" class="text-center">Wersja serwera: {{ apiInfo.techInfo.serverVersion }}</div>
            <div v-if="apiInfo.techInfo" class="text-center">Wersja OS: {{ apiInfo.techInfo.osVersion }}</div>

            <div v-if="apiInfo.dbInfo" class="text-center text-bold">Dane bazy danych</div>
            <div v-if="apiInfo.dbInfo" class="text-center">Host: {{ apiInfo.dbInfo.dbHost }}</div>
            <div v-if="apiInfo.dbInfo" class="text-center">Użytkownik: {{ apiInfo.dbInfo.dbUser }}</div>
            <div v-if="apiInfo.dbInfo" class="text-center">SID: {{ apiInfo.dbInfo.dbSid }}</div>
        </div>
    </div>
</template>


<script>

import ApiHelper from "../../helpers/ApiHelper.js";
import AppHelper from "../../helpers/AppHelper.js";
//
import Clock from "../screenelements/Clock.vue";

export default {
    name: "LoginForm",
    props: [
        "apiInfo",
        "apiName",
        "apiUrl",
        "apiList",
        "defaultApi",
        "onSubmit",
        "onChangeApi",
        "version",
        "wrongUsername",
        "wrongPassword",
        "autocomplete"
    ],
    components: {
        Clock
    },
    data: function() {
        return {
            username: "",
            password: "",
            cardNo: "",
            chosenApi: this.apiUrl,
            showQR: false,
            showUrlInfo: false,
            showTechInfo: false,
            publicUrl: ApiHelper.getBaseUrl(this.apiUrl) + "public",
            qrData: this.apiUrl +";"+ this.apiName,
        };
    },
    methods: {
        showApiList(apiList) {
            return !AppHelper.isEmptyArr(apiList);
        },
        submit: function(e) {
            
            e.preventDefault();
            var md5 = require('md5');
            console.log(md5(this.password));
            this.$emit("onSubmit", {
                username: this.username.trim(),
                password: md5(this.password)
            });
        },
        reset: function() {},
        changeApi: function() {
            let api = ApiHelper.getApiName(this.chosenApi);
            this.publicUrl = ApiHelper.getBaseUrl(this.chosenApi) + "public";
            this.qrData = this.chosenApi +";"+ api;

            this.$emit("onChangeApi", this.chosenApi);
        },
        setKeyEventListener: function(e) {
            if (e.which == 13 || e.keyCode == 13) {
                this.$refs.loginButton.focus();
                this.$refs.loginButton.click();
            }
        },
        toggleQR: function() {
            this.showQR = !this.showQR;
        },
        toggleUrlInfo: function() {
            this.showUrlInfo = !this.showUrlInfo;
        },
        toggleTechInfo: function() {
            this.showTechInfo = !this.showTechInfo;
        }
    },
    watch: {
        wrongUsername: function() {
            if (this.wrongUsername && AppHelper.isEmptyStr(this.username)) {
                this.$refs.loginUsername.focus();
            }
        },
        wrongPassword: function() {
            if (this.wrongPassword && AppHelper.isEmptyStr(this.password)) {
                this.$refs.loginPassword.focus();
            }
        }
    },
    created: function() {
        window.addEventListener("keyup", this.setKeyEventListener);
    },
    beforeDestroy: function() {
        window.removeEventListener("keyup", this.setKeyEventListener);
    }
};
</script>


<style scoped>
</style>