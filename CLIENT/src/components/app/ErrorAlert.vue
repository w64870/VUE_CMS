<template>
    <div :class="divClass">
        <b-alert :show="showError" :variant="setVariant" dismissible @dismissed="dismissError">
            <span>
                <font-awesome-icon icon="exclamation-triangle" class="m-1" size="2x"/>
            </span>
            <span class="error-toggle-details" @click="toggleDetails()">
                    <font-awesome-icon icon="angle-down" v-if="!details" size="2x"/>
                    <font-awesome-icon icon="angle-up" v-if="details" size="2x"/>
            </span
            >&nbsp;
            <template v-if="apiErrors.error">
                <span v-html="apiErrors.error.code"></span> 
                <span v-html="apiErrors.error.message"></span>
                <p v-if="details" v-html="apiErrors.error.sqltext"></p>
            </template>
            <template v-if="apiErrors.error2">
                <span v-html="apiErrors.error2.errstr"></span>
                <p v-if="details" v-html="apiErrors.error2.errfile"></p>
                <p v-if="details" v-html="apiErrors.error2.errline"></p>
                <p v-if="details"><pre>{{ apiErrors.error2.errcontext }}</pre></p>
            </template>
            <template v-if="apiErrors.error3">
                <span class="font-weight-bold" v-html="apiErrors.error3"></span>
            </template>
            <template v-if="apiErrors.requestError">
                <span class="font-weight-bold" v-html="apiErrors.requestError"></span>
            </template>
        </b-alert>
    </div>
</template>


<script>

import { HIDE_ERRORS } from "../../store/types/actions.type.js";

export default {
    name: "ErrorAlert",
    props: ["divClass"],
    data: function() {
        return {
            details: false
        };
    },
    computed: {
        showError: function() {
            return this.$store.getters.isError();
        },
        apiErrors: function() {
            return this.$store.getters.getApiErrors();
        },
        errorLevel: function() {
            return this.$store.getters.getErrorLevel();
        },
        setVariant:function() {
            let level = this.$store.getters.getErrorLevel();

            let variant = "danger";
            switch(level) {
                case 0:
                    variant = "danger";
                    break;
                case 1:
                    variant = "warning";
                    break;
                case 2:
                    variant = "info";
                    break;
                default:
                    variant = "danger";
                    break;
            }
            return variant
        }
    },
    methods: {
        dismissError: function() {
            this.$store.dispatch(HIDE_ERRORS);
        },
        toggleDetails: function() {
            this.details = !this.details;
        }
    }
};

</script>


<style scoped>
</style>

