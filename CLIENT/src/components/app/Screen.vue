<template>
    <div :class="screenClassName" id="screen">
        <div class="container-fluid screeninfo-div">
            <div class="row">
                <div class="col-12 col-sm-6 text-left">
                    {{ screenData.operation_description }}
                </div>
                <div class="col-12 col-sm-6 text-right">
                    {{ (apiInfo) ? apiInfo.version : ''}};
                    {{ browser ? browserStr : '' }};
                    {{ screenData.screen_name ? screenStr : '' }};
                </div>
            </div>
        </div>
        <div v-if="currentOperation" class="container-fluid screen-container">
            <div class="row">
                <ErrorAlert
                    :apiErrors="apiErrors"
                    :showError="showError"
                    class="col-12 col-md-12"
                    @onDismiss="dismissError"
                />
            </div>
            <div class="row">
                <InfoAlert
                    :info="infoMessage"
                    :showInfo="showInfo"
                    class="col-12 col-md-12"
                    @onDismiss="dismissInfo"
                />
            </div>
            <div class="row">
                <ScreenForm
                    :screenData="screenData"
                    :formValues="formValues"
                    @onSubmit="submitScreen"
                />
            </div>
            <div class="row">
                <div
                    class="col-4 offset-4 col-md-4 offset-md-4 op-version"
                >{{ screenData.version ? "Wersja operacji: "+screenData.version : null }}</div>
            </div>
            <div class="row">
                <DebugInfo
                    v-if="debug"
                    :screenData="screenData"
                    :currentContext="currentContext"
                    :currentOperation="currentOperation"
                />
                <b-button v-if="debug" type="button" variant="secondary" class="scroll-btn" @click="scrollToTop()">
                    <font-awesome-icon icon="angle-up" size="2x" />
                </b-button>
            </div>
        </div>
        <div v-else class="container-fluid screen-container">
            <div class="row">
                <ErrorAlert
                    :apiErrors="apiErrors"
                    :showError="showError"
                    class="col-12 col-md-12"
                    @onDismiss="dismissError"
                />
            </div>
            <div class="row">
                <InfoAlert
                    :info="infoMessage"
                    :showInfo="showInfo"
                    class="col-12 col-md-12"
                    @onDismiss="dismissInfo"
                />
            </div>
        </div>
    </div>
</template>


<script>
const { detect } = require("detect-browser");
const browser = detect();

import ErrorAlert from "./ErrorAlert.vue";
import InfoAlert from "./InfoAlert.vue";

import ScreenForm from "../app/ScreenForm.vue";
import DebugInfo from "../app/DebugInfo.vue";

export default {
    name: "Screen",
    props: [
        "apiInfo",
        "currentContext",
        "currentOperation",
        "isOpMenuOpen",
        "screenData",
        "formValues",
        "debug",
        "apiErrors",
        "showError",
        "infoMessage",
        "showInfo",
        "isLoading"
    ],
    components: { ErrorAlert, InfoAlert, ScreenForm, DebugInfo },
    data: function() {
        return {
            browser: browser,
            
        };
    },
    computed: {
        screenClassName: function() {
            return this.isOpMenuOpen
                ? "col-12 col-md-9 screen"
                : "col-12 col-md-12 screen";
        },
        browserStr: function() { 
            return ' ' + this.browser.name + ' ' + this.browser.version;
        },
        screenStr: function() { 
            return ' EKROP:' + this.screenData.screen_id + ':' + this.screenData.screen_name;
        }
    },
    methods: {
        submitScreen: function(formData) {
            this.$emit("onSubmit", formData);
        },
        dismissError: function() {
            
        },
        dismissInfo: function() {
            
        },
        getClass: function(num) {
            let suffix = Math.floor(12 / num);
            return `col-12 col-md-${suffix}`;
        },
        scrollToTop: function() {
            document.querySelector('#screen').scrollTop = 0;
        }
    },
    watch: {
        showError: function() {
            if (this.showError) {
                this.scrollToTop();
            }
        },
        screenData: function() {
            this.scrollToTop();
        }
    }
};
</script>


<style scoped>
</style>
