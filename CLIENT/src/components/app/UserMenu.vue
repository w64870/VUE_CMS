<template>
    <div id="app" class="container-fluid">
        <div class="row">
            <div class="col-12 col-md-8 offset-md-2">
                <div v-if="isModifyAllowed === true" class="row">
                    <b-navbar type="dark"  expand="md" class="context-navbar">
                        <b-navbar-nav class="context-nav">
                            <b-nav-item 
                                class="nav-btn" 
                                @click="onClick()">
                                    <font-awesome-icon v-if="insert_mode === false" icon="user-plus" class="m-2" style="color: #d6d6d6" />
                                    <font-awesome-icon v-else icon="user-edit" class="m-2" style="color: #d6d6d6" />
                            </b-nav-item>
                            <b-nav-item 
                                class="nav-btn" 
                                @click="assignOpUser()">
                                    <font-awesome-icon icon="wrench" class="m-2" style="color: #d6d6d6" />
                            </b-nav-item>
                        </b-navbar-nav>
                    </b-navbar>
                </div>
                <div v-if="insert_mode !== true">
                    <ChangePassword 
                        @onChangePassword="changePassword"
                    />
                </div>
                <div v-else>
                    <CreateUser 
                        @onCreateUser="createUser"
                    />
                </div>
            </div>
        </div>
    </div>
</template>



<script>
import ChangePassword from "./ChangePassword.vue";
import CreateUser from "./CreateUser.vue";

export default {
    name: "UserMenu",
    props: [
        "isModifyAllowed"
    ],
    components: {
        ChangePassword, CreateUser
    },
    data: function() {
        return{
            oldPassword: "",
            newPassword: "",
            checkPassword: "YES",
            insert_mode: false,
            buttonName: "Tworzenie użytkowników"
        }
    },
    computed: {},
    methods: {
        changePassword: function(changePasswordData) {
            // change password
            this.$emit("onChangePassword", changePasswordData);
        },
        createUser: function(createUserData)
        {
            this.$emit("onCreateUser", createUserData);
        },
        onClick(){
            this.insert_mode = !this.insert_mode;
            if (this.insert_mode){
                this.buttonName = "Zmiana hasła";
            }
            else{
                this.buttonName = "Tworzenie użytkowników";
            }
        },
        assignOpUser: function() {
            this.$emit("onAssignOpUser", true);
        },
    },
};
</script>


<style scoped>
</style>