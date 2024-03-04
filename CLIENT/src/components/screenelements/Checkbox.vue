<template>
    <div>
        <label
            class="etykieta"
            :class="element.classAttribute"
            :style="getStyles(element.styleAttribute)"
        >
            <input
                ref="input"
                type="checkbox"
                class="checkbox-single"
                :id="element.idAttribute"
                :name="element.nameAttribute"
                :value="formValues[element.nameAttribute]"
                :tabindex="element.tabIndex"
                v-model="formValues[element.nameAttribute]"
            >
            &nbsp;
            {{ element.label }}
        </label>
    </div>
</template>


<script>
import AppHelper from "../../helpers/AppHelper.js";

export default {
    name: "Checkbox",
    props: ["element", "formValues", "isActive"],
    components: {},
    data: function() {
        return {
            attributes: AppHelper.getAttributes(this.element.otherAttributes)
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
    mounted: function() {
        if (this.isActive) {
            this.$refs.input.focus();
        }
    } 
};
</script>


<style scoped>
</style>