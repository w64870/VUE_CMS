<template>
    <div :class="getContainerClass()" :style="getContainerStyles()">
        <span v-html="element.htmlBefore"></span>
        <Button
            v-if="element.type === 'BUTTON'"
            :element="element"
            :formValues="formValues"
            :isActive="isActive()"
            :isDefault="isDefault()"
            @onSubmit="buttonSubmit"
        />
        <Checkbox
            v-if="element.type === 'CHECKBOX'"
            :element="element"
            :formValues="formValues"
            :isActive="isActive()"
        />
        <InfoTable 
            v-if="element.type === 'INFO'" 
            :element="element" 
            :formValues="formValues" 
        />
        <JSScript 
            v-if="element.type === 'JS'" 
            :element="element" 
            :formValues="formValues" 
        />
        <Label 
            v-if="element.type === 'LABEL'" 
            :element="element" 
            :formValues="formValues" 
        />
        <List
            v-if="element.type === 'LIST'"
            :element="element"
            :formValues="formValues"
            :isActive="isActive()"
        />
        <NumberField
            v-if="element.type === 'NUMBER'"
            :element="element"
            :formValues="formValues"
            :isActive="isActive()"
            @onValidate="toggleElementError"
        />
        <Table
            v-if="element.type === 'TABELA_CHECKBOX'"
            :element="element"
            :formValues="formValues"
        />
        <Table
            v-if="element.type === 'TABELA'"
            :element="element"
            :formValues="formValues"
            @onSubmit="tableSubmit"
        />
        <TextField
            v-if="element.type === 'TEXT'"
            :element="element"
            :formValues="formValues"
            :isActive="isActive()"
        />
        <TextArea
            v-if="element.type === 'TEXTAREA'"
            :element="element"
            :formValues="formValues"
            :isActive="isActive()"
        />
        <HiddenValue 
            v-if="element.type === 'VAL'" 
            :element="element" 
            :formValues="formValues" 
        />

        <span v-html="element.htmlAfter"></span>

        <div class="element-error">{{ elementError }}</div>
    </div>
    <!-- .col -->
</template>


<script>
import AppHelper from "../../helpers/AppHelper.js";

import Button from "../screenelements/Button.vue";
import Checkbox from "../screenelements/Checkbox.vue";
import HiddenValue from "../screenelements/HiddenValue.vue";
import InfoTable from "../screenelements/InfoTable.vue";
import JSScript from "../screenelements/JSScript.vue";
import Label from "../screenelements/Label.vue";
import List from "../screenelements/List.vue";
import NumberField from "../screenelements/NumberField.vue";
import Table from "../screenelements/Table.vue";
import TextArea from "../screenelements/TextArea.vue";
import TextField from "../screenelements/TextField.vue";

export default {
    name: "ScreenElement",
    props: [
        "element",
        "formValues",
        "onButtonSubmit",
        "onTableSubmit",
        "classProp",
        "rowNum",
        "innerRow",
        "positionNum",
        "activeElement",
        "defaultElement"
    ],
    components: {
        Button,
        Checkbox,
        HiddenValue,
        InfoTable,
        JSScript,
        Label,
        List,
        NumberField,
        Table,
        TextArea,
        TextField,
    },
    data: function() {
        return {
            form: {},
            elementError: null,
            showElementError: false
        };
    },
    computed: {},
    methods: {
        buttonSubmit: function() {
            this.$emit("onButtonSubmit", this.formValues);
        },
        tableSubmit: function() {
            this.$emit("onTableSubmit", this.formValues);
        },
        getContainerStyles: function() {
            return AppHelper.getStyles(this.element.containerStyle);
        },
        getContainerClass: function() {
            let tables = [
                "INFO",
                "TABELA_CHECKBOX",
                "TABELA"
            ];

            return tables.includes(this.element.type)
                ? this.classProp + " element-table-container"
                : this.classProp + " element-container";
        },
        toggleElementError: function(error) {
            this.elementError = error;
            if (error == null || error.length == 0) {
                this.showElementError = false;
            } else {
                this.showElementError = true;
            }
        },
        isActive: function() {
            if (this.activeElement == this.element.idAttribute) {
                return true;
            }
            return false;
        },
        isDefault: function() {
            if (this.defaultElement == this.element.idAttribute) {
                return true;
            }
            return false;
        }
    }
};
</script>


<style scoped>
</style>