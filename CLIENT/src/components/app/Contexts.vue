<template>
    <b-navbar type="dark" variant="dark" expand="md" fixed="top" class="context-navbar">
        <b-navbar-nav class="context-nav">
            <b-nav-item class="nav-btn" @click="selectContext(null)" :disabled="disabled">
                <font-awesome-icon icon="home" class="m-2" style="color: #d6d6d6" />
            </b-nav-item>
            <b-nav-item class="nav-btn" @click="resetOperations()" :disabled="disabled">
                <font-awesome-icon icon="sync" class="m-2" style="color: #d6d6d6" />
            </b-nav-item>
            <b-nav-item 
                v-if="isModifyAllowed === true" 
                class="nav-btn" 
                @click="modifyOperations()" 
                :disabled="disabled">
                    <font-awesome-icon icon="edit" class="m-2" style="color: #d6d6d6" />
            </b-nav-item>
            <b-nav-item class="nav-btn" @click="toggleOperations">
                <font-awesome-icon icon="bars" class="m-2" style="color: #d6d6d6" />
            </b-nav-item>
        </b-navbar-nav>
        <b-navbar-toggle target="collapse-cxt" />
        <b-collapse id="collapse-cxt" is-nav>
            <b-navbar-nav tabs fill class="context-nav context-nav-mg">
            </b-navbar-nav>
        </b-collapse>

        <div class="nav-loader-div">
            <vue-simple-spinner
                v-if="isLoading"
                size="medium"
                message="Wczytywanie..."
                line-bg-color="#ff8533"
                line-fg-color="#343a40"
                text-fg-color="#ff8533"
            ></vue-simple-spinner>
        </div>

        <AppInfo
            :apiInfo="apiInfo"
            :time="time"
            :user="user"
            :username="username"
            :logoutDisabled="logoutDisabled"
            @onLogout="logout"
            @onUpsertUser="upsertUser()"
        />

        <div class="logout-btn" v-on:click="logout">
            <font-awesome-icon icon="power-off" class="m-2" />
        </div>
    </b-navbar>
</template>


<script>
import AppInfo from "./AppInfo.vue";

export default {
    name: "Contexts",
    props: [
        "apiInfo",
        "currentContext",
        "onToggleOperations",
        "onSelectContext",
        "contexts",
        "onLogout",
        "time",
        "user",
        "username",
        "isModifyAllowed",
        "disabled",
        "logoutDisabled",
        "isLoading"
    ],
    components: {
        AppInfo
    },
    data: function() {
        return {
            isOpen: false,
            selectedContext: this.currentContext
        };
    },
    computed: {},
    methods: {
        selectContext: function(id) {
            if (!this.disabled) {
                this.selectedContext = id;
                this.$emit("onSelectContext", this.selectedContext);
            }
        },
        resetOperations: function() {
            this.$emit("onResetOperations", true);
        },
        modifyOperations: function() {
            this.$emit("onModifyOperations", true);
        },
        upsertUser: function() {
            this.$emit("onUpsertUser", true);
        },
        toggleOperations: function(state) {
            this.$emit("onToggleOperations", state);
        },
        logout: function() {
            if (!this.logoutDisabled) {
                this.$emit("onLogout", true);
            }
        }
    },
    created() {}
};
</script>


<style scoped>
</style>
