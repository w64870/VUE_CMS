<template>
    <div class="login-form">
        <b-form ref="form" class="screen-form" @submit.prevent="changePassword">
            <div class="row">
                <ErrorAlert class="col-12 col-md-8 offset-md-2"/>
            </div>
            <b-form-group id="oldPasswordGroup" label="Podaj aktualne hasło:" label-for="oldPassword">
                <b-form-input
                    id="oldPassword"
                    type="password"
                    v-model="oldPassword"
                    placeholder="Podaj aktualne hasło"
                />
            </b-form-group>
            <b-form-group id="newPasswordGroup" label="Podaj nowe hasło:" label-for="newPassword">
                <b-form-input
                    id="newPassword"
                    type="password"
                    v-model="newPassword"
                    placeholder="Podaj nowe hasło"
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
            <br/>
            <b-form-checkbox
                id="debugMode"
                value = "YES"
                unchecked-value = "NO"
                v-model="debugMode"
            >
                Tryb debugowania
            </b-form-checkbox>
            <div class="d-flex justify-content-center">
                <b-button
                    type="submit"
                    class="login-button"
                    variant="primary"
                >Zmień hasło</b-button>
            </div>
        </b-form>
    </div>
</template>



<script>
import ErrorAlert from "./ErrorAlert.vue";

export default {
    name: "ChangePassword",
    props: [],
    components: {
        ErrorAlert
    },
    data: function() {
        return{
            oldPassword: "",
            newPassword: "",
            checkPassword: "YES",
            debugMode: "NO",
        }
    },
    computed: {},
    methods: {
        changePassword() {
            // change password
            var md5 = require('md5');
            
            if (this.newPassword !== ""){
               this.newPassword = md5(this.newPassword);
            }
            
            if (this.oldPassword !== ""){
                this.oldPassword = md5(this.oldPassword);
            }

            this.$emit("onChangePassword", {
                oldPassword: this.oldPassword,
                newPassword: this.newPassword, 
                checkPassword: this.checkPassword,
                debugMode: this.debugMode
            });

            this.oldPassword = "";
            this.newPassword = "";
            this.checkPassword = "YES";
            this.debugMode = "NO";
        },
    },
};
</script>


<style scoped>
</style>