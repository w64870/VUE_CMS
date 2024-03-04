<template>
    <div class="login-form">
        <b-form ref="form" class="screen-form" @submit.prevent="createUser">
            <div class="row">
                <ErrorAlert class="col-12 col-md-8 offset-md-2"/>
            </div>
            <b-form-group id="usernameGroup" label="Nazwę użytkownika:" label-for="username">
                <b-form-input
                    id="username"
                    type="text"
                    v-model="username"
                    placeholder="Nazwę użytkownika"
                />
            </b-form-group>
            <b-form-group id="userDescGroup" label="Imię i nazwisko użytkownika:" label-for="userDesc">
                <b-form-input
                    id="userDesc"
                    type="text"
                    v-model="userDesc"
                    placeholder="Imię i nazwisko użytkownika"
                />
            </b-form-group>
            <b-form-group id="passwordGroup" label="Podaj hasło:" label-for="password">
                <b-form-input
                    id="password"
                    type="password"
                    v-model="password"
                    placeholder="Podaj hasło"
                />
            </b-form-group>
            <b-form-checkbox
                id="checkPassword"
                value = "YES"
                unchecked-value = "NO"
                v-model="checkPassword"
            >
                Sprawdzaj hasło przy logowaniu
            </b-form-checkbox>
            <b-form-checkbox
                id="canModify"
                value = "YES"
                unchecked-value = "NO"
                v-model="canModify"
            >
                Możliwość edycji zadań
            </b-form-checkbox>
            <div class="d-flex justify-content-center">
                <b-button
                    type="submit"
                    class="login-button"
                    variant="primary"
                >Twórz użytkownika</b-button>
            </div>
        </b-form>
    </div>
</template>



<script>
import ErrorAlert from "./ErrorAlert.vue";

export default {
    name: "CreateUser",
    props: [],
    components: {
        ErrorAlert
    },
    data: function() {
        return{
            username: "",
            userDesc: "",
            password: "",
            checkPassword: "YES",
            canModify: "NO"
        }
    },
    computed: {},
    methods: {
        createUser() {
            // add user
            var md5 = require('md5');
            this.$emit("onCreateUser", {
                username: this.username,
                userDesc: this.userDesc,
                password: md5(this.password),
                checkPassword: this.checkPassword,
                canModify: this.canModify
            });

            this.username = "";
            this.userDesc = "";
            this.password = "";
            this.checkPassword = "YES";
            this.canModify = "NO";

        },
    },
};
</script>


<style scoped>
</style>