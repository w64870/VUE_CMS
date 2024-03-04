<template>
    <b-form-textarea
        ref="input"
        type="text"
        class="pole_tekstowe"
        :id="element.idAttribute"
        :name="element.nameAttribute"
        :value="value"
        :tabindex="element.tabIndex"
        :class="element.classAttribute"
        :style="getStyles(element.styleAttribute)"
        :rows="Number(findAttribute(attributes, 'rows'))"
        :max-rows="Number(findAttribute(attributes, 'maxRows'))"
        v-model="formValues[element.nameAttribute]"
        :clearContent="clearContent"
        v-b-tooltip.hover.topright :title="element.tooltip"
    ></b-form-textarea>
</template>


<script>
import AppHelper from "../../helpers/AppHelper.js";

export default {
    name: "TextArea",
    props: ["element", "formValues", "isActive"],
    components: {},
    data: function() {
        return {
            value: this.element.value,
            clearContent: "",
            attributes: AppHelper.getAttributes(this.element.otherAttributes)
        };
    },
    methods: {
        getStyles: function(text) {
            let styles = AppHelper.getStyles(text);
            return styles;
        },
        findAttribute: function(attributes, attr) {
            return AppHelper.findAttribute(attributes, attr);
        }
    },
    created: function() {
        this.value = this.element.clearContent ? "" : this.element.value;
        this.clearContent = this.element.clearContent ? "Tak" : "Nie";
    },
    mounted: function() {
        if (this.isActive) {
            this.$refs.input.focus();
        }
    } 
};
</script>


<style scoped>
</style>