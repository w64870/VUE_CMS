<template>
    <div :class="divClass">
        <template v-if="info">
            <b-alert
                :show="showInfo"
                :variant="info.variant"
                dismissible
                @dismissed="dismissMessage"
            >
                <span class="font-weight-bold" v-html="info.message"></span>
            </b-alert>
        </template>
    </div>
</template>


<script>

import { HIDE_ERRORS } from "../../store/types/actions.type.js";

export default {
    name: "InfoAlert",
    props: ["divClass"],
    data: function() {
        return {
            details: false
        };
    },
    computed: {
        showInfo: function() {
            return this.$store.getters.isInfo();
        },
        info: function() {
            return this.$store.getters.getInfoMessage();
        }
    },
    methods: {
        dismissMessage: function() {
            this.$store.dispatch(HIDE_ERRORS);
        }
    }
};
</script>


<style scoped>
</style>
