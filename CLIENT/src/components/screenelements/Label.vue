<template>
    <div>
        <span
            :id="element.idAttribute"
            v-html="convertSquareToAngleBrackets(element.value)"
            class="etykieta"
            :class="element.classAttribute"
            :style="getStyles(element.styleAttribute)"
            
        ></span>
    </div>
</template>


<script>
import AppHelper from "../../helpers/AppHelper.js";

export default {
    name: "Label",
    props: ["element", "formValues"],
    components: {},
    data: function() {
        return {
            attributes: AppHelper.getAttributes(this.element.otherAttributes)
        };
    },
    methods: {
        convertSquareToAngleBrackets: function(text) {
            return AppHelper.convertSquareToAngleBrackets(text);
        },
        getStyles: function(text) {
            return AppHelper.getStyles(text);
        },
        findAttribute: function(attributes, attr) {
            return AppHelper.findAttribute(attributes, attr);
        }
    }
};
</script>


<style scoped>
</style>