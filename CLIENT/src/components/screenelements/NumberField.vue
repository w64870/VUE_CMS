<template>
    <b-form-input
        ref="input"
        type="text"
        class="liczba"
        :id="element.idAttribute"
        :name="element.nameAttribute"
        :value="value"
        :tabindex="element.tabIndex"
        :class="element.classAttribute"
        :style="getStyles(element.styleAttribute)"
        :minlength="element.minLength"
        :maxlength="element.maxLength"
        :required="element.minLength > 0"
        v-model="formValues[element.nameAttribute]"
        v-validate="'isnumeric'"
        @change="validate()"
    />
</template>


<script>
import AppHelper from "../../helpers/AppHelper.js";

import { Validator } from 'vee-validate';
Validator.extend('isnumeric', {
    getMessage: field => 'Podana wartość nie jest liczbą.',
    validate: value => {
        let numStr = value.replace(' ', '');
        numStr = value.replace(',', '.');
        return !isNaN(numStr);
    }
});

export default {
    name: "NumberField",
    props: ["element", "formValues", "isActive"],
    components: {},
    data: function() {
        return {
            value: this.element.value,
            attributes: AppHelper.getAttributes(this.element.otherAttributes)
        };
    },
    methods: {
        getStyles: function(text) {
            return AppHelper.getStyles(text);
        },
        findAttribute: function(attributes, attr) {
            return AppHelper.findAttribute(attributes, attr);
        },
        validate: function() {
            let error = this.errors.first(this.element.nameAttribute);
            this.$emit("onValidate", error);
        }
    },
    created: function() {
        this.value = this.element.clearContent ? "" : this.element.value;
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