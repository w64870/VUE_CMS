<template>
    <b-form-select
        ref="input"
        class="mb-3 lista"
        :class="element.classAttribute"
        :style="getStyles(element.styleAttribute)"
        :id="element.idAttribute"
        :select-size="Number(findAttribute(attributes, 'size'))"
        v-model="formValues[element.nameAttribute]"
    >
        <option
            v-for="(row, index) in element.content.rows"
            :key="index"
            :value="row.id"
            :style="getStyles(row.css)"
        >{{ row.opis}}</option>
    </b-form-select>
</template>


<script>
import AppHelper from "../../helpers/AppHelper.js";

export default {
    name: "List",
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