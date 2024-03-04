<template>
    <table class="tabela_info" cellspacing="0" cellpadding="0"
        :id="element.idAttribute"
        :name="element.nameAttribute"
        :class="element.classAttribute"
    >
        <thead>
            <tr>
                <template v-for="(header, idx) in element.content.headers">
                    <th v-if="checkKey(header)" :key="idx" class="table-heading">{{ initCap(header) }}</th>
                </template>
            </tr>
        </thead>
        <tbody>
            <tr v-for="(row, i) in element.content.rows" :key="i" :class="getRowClass(i)" :style="getStyles(row.css)">
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
    name: "InfoTable",
    props: ["element", "formValues"],
    components: {},
    data: function() {
        return {
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
        }
    }
};
</script>


<style scoped>
</style>