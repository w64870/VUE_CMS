<template>
    <div class="clock-div">
        <span class="clock"
            id
            :class="element.classAttribute"
            :style="getStyles(element.styleAttribute)"
        >{{ time }}</span>
    </div>
</template>


<script>
import AppHelper from "../../helpers/AppHelper.js";
import { DateTime } from "luxon";

export default {
    name: "Clock",
    props: ["element", "format"],
    components: {},
    data: function() {
        return {
            attributes: AppHelper.getAttributes(this.element.otherAttributes),
            clock: null,
            time: null
        };
    },
    methods: {
        getStyles: function(text) {
            return AppHelper.getStyles(text);
        },
        findAttribute: function(attributes, attr) {
            return AppHelper.findAttribute(attributes, attr);
        }
    },
    created: function() {
        this.clock = setInterval(() => {
            let format = !AppHelper.isEmptyStr(this.format) ? this.format.toString() : 'yyyy-MM-dd HH:mm:ss';
            this.time = DateTime.local().toFormat(format);
            //console.log(this.time);
        }, 1000);
    },
    beforeDestroy: function() {
        clearInterval(this.clock);
    }
};
</script>


<style scoped>
</style>