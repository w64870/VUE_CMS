<template>
    <div class="d-flex flex-column appinfo-container">
        <div class="d-flex flex-row appinfo">
            <div class="px-3" v-on:click="upsertUser()">
                <span> 
                <font-awesome-icon icon="user" />
                <span class="ml-2">{{ user }}</span>
                </span>
            </div>
            <div class="px-3 font-weight-bold d-none d-sm-inline-block">
                <span class="info-text">{{ username }}</span>
            </div>
        </div>
        <div class="d-flex flex-row appinfo">
            <div class="px-3 d-none d-sm-inline-block">
                <span> 
                <font-awesome-icon icon="clock" />
                <span class="ml-2">{{ convertIntToTime(time) }}</span>
                </span>
            </div>
            <div class="px-3 d-none d-sm-inline-block">
                <span>
                <font-awesome-icon icon="desktop" />
                <span class="ml-2">{{ (apiInfo) ? apiInfo.ip : ''}}</span>
                </span>
            </div>
        </div>
    </div>
</template>


<script>
export default {
    name: "AppInfo",
    props: [
        "apiInfo",
        "time",
        "user",
        "username",
        "logoutDisabled",
        "onLogout"
    ],
    data: function() {
        return {};
    },
    methods: {
        convertIntToTime: function(pNum) {
            let num = parseInt(pNum, 10);
            var minutes = Math.floor(num / 60);
            var seconds = num - minutes * 60;

            if (minutes < 10) {
                minutes = "0" + minutes;
            }
            if (seconds < 10) {
                seconds = "0" + seconds;
            }

            return minutes + ":" + seconds;
        },
        upsertUser: function() {
            this.$emit("onUpsertUser", true);
        }
    }
};
</script>

<style scoped>
</style>