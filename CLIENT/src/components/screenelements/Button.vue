<template>
    <b-button
        :ref="element.idAttribute"
        type="submit"
        variant="primary"
        class="przycisk"
        :id="element.idAttribute"
        :name="element.nameAttribute"
        :value="element.value"
        :tabindex="element.tabIndex"
        :class="element.classAttribute"
        :style="getStyles(element.styleAttribute)"
        @click="onClick"
    >
    <span v-html="element.value"></span>
    </b-button>
</template>


<script>
import AppHelper from "../../helpers/AppHelper.js";

export default {
    name: "Button",
    props: ["element", "formValues", "isActive", "isDefault", "onButtonSubmit"],
    components: {},
    data: function() {
        return {
            attributes: AppHelper.getAttributes(this.element.otherAttributes)
        };
    },
    methods: {
        onClick: function() {
            this.formValues[this.element.nameAttribute] = this.element.value;
        },
        getStyles: function(text) {
            return AppHelper.getStyles(text);
        },
        findAttribute: function(attributes, attr) {
            return AppHelper.findAttribute(attributes, attr);
        },
        setKeyEventListener: function(e) {
            if (e.which == 13 || e.keyCode == 13) {
                this.$refs[this.element.idAttribute].focus();
                this.$refs[this.element.idAttribute].click();
            }
        }
    },
    created: function() {
        if (this.isDefault) {
            window.addEventListener("keyup", this.setKeyEventListener);
        }
        
    },
    mounted: function() {
        if (this.isActive) {
            this.$refs[this.element.idAttribute].focus();
        }
    },
    beforeDestroy: function() {
        window.removeEventListener('keyup', this.setKeyEventListener);
    }
};
</script>


<style scoped>
</style>