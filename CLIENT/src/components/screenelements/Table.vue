<template>
    <table class="tabela_wyboru" cellspacing="0" cellpadding="0"
        :id="element.idAttribute"
        :name="element.nameAttribute"
        :class="element.classAttribute"
    >
        <thead>
            <tr>
                <th class="table-heading">
                    <label class="table-heading" v-if="element.type === 'TABELA_CHECKBOX'">
                        <input
                            type="checkbox"
                            class=""
                            :name="element.nameAttribute"
                            :value="true"
                            :unchecked-value="false"
                            v-model="allSelected"
                            @click="onClickSelectAll"
                        >
                    </label>
                </th>
                <template v-for="(header, idx) in element.content.headers">
                    <th v-if="checkKey(header)" :key="idx" class="table-heading">{{ initCap(header) }}</th>
                </template>
            </tr>
        </thead>
        <tbody>
            <tr v-for="(row, i) in element.content.rows" :key="i" :class="getRowClass(i)" :style="getStyles(row.css)" @click="onClickRow(element.content.rows[i].id_g)">
                <td
                    v-if="element.type === 'TABELA_CHECKBOX'"
                >
                    <label class="">
                        <input
                            type="checkbox"
                            class=""
                            :name="element.nameAttribute"
                            :value="element.content.rows[i].id_g"
                            :unchecked-value="null"
                            v-model="selectedCheckboxes"
                            @change="onClickCheckbox(element.content.rows[i].id_g)"
                        >
                    </label>
                </td>
                <td v-if="element.type === 'TABELA'">
                    <label class="">
                        <input
                            type="radio"
                            class=""
                            :name="element.nameAttribute"
                            :value="element.content.rows[i].id_g"
                            v-model="selectedRadio"
                            @change="onClickRadio(element.content.rows[i].id_g)"
                        >
                    </label>
                </td>
                <template v-for="(value, key) in row">
                    <td v-if="checkKey(key)" :key="key" v-html="convertSquareToAngleBrackets(value)"></td>
                </template>
            </tr>
        </tbody>
    </table>
</template>


<script>
import AppHelper from "../../helpers/AppHelper.js";

export default {
    name: "Table",
    props: ["element", "formValues", "onTableSubmit"],
    components: {},
    data: function() {
        return {
            selectedCheckboxes: [],
            selectedRadio: null,
            allSelected: false,
            attributes: AppHelper.getAttributes(this.element.otherAttributes)
        };
    },
    methods: {
        checkKey: function(key) {
            return !AppHelper.isEmptyStr(key) && key!='id_g' && !key.includes('placeholder') && !key.includes('css');
        },
        getStyles: function(text) {
            return AppHelper.getStyles(text);
        },
        findAttribute: function(attributes, attr) {
            return AppHelper.findAttribute(attributes, attr);
        },
        initCap: function(s) {
            let strArr = s.split(" ");
            strArr.forEach( (str, index, array) => {
                array[index] = str.substr(0, 1).toLocaleUpperCase() + str.substr(1, str.length).toLocaleLowerCase();
            });
            return strArr.join(" ");
        },
        getRowClass: function(i) {
            return i % 2 === 0 ? "even_row" : "odd_row";
        },
        convertSquareToAngleBrackets: function(text) {
            return AppHelper.convertSquareToAngleBrackets(text);
        },
        onClickCheckbox: function(id) {
            if(this.selectedCheckboxes.includes(id)) {
                this.selectedCheckboxes = this.selectedCheckboxes.filter(function(val) {
                    return (val != id);
                });
            } else {
                this.selectedCheckboxes.push(id);
            }
            this.formValues[this.element.nameAttribute] = this.selectedCheckboxes;
        },
        onClickRadio: function(id) {
            this.formValues[this.element.nameAttribute] = id;
            this.$emit("onSubmit", this.formValues);
        },
        onClickSelectAll: function() {
            this.selectedCheckboxes = [];
            if(!this.allSelected) {
                for (let i in this.element.content.rows) {
                    this.selectedCheckboxes.push(this.element.content.rows[i].id_g);
				}
            }
            this.formValues[this.element.nameAttribute] = this.selectedCheckboxes;
        },
        onClickRow: function(id) {
            switch (this.element.type) {
                case 'TABELA':
                    this.onClickRadio(id);
                    break;
                case 'TABELA_CHECKBOX':
                    this.onClickCheckbox(id);
                    break;
                default:
                    break;  
            } 
        }
    }
};
</script>


<style scoped>
</style>