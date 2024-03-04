<template>
    <div class="col-md-12">
        <b-form ref="form" class="screen-form" @submit="submit" @reset="reset" @submit.prevent>
            <div class="container-fluid screen-form-container">
                <template v-for="(row, idx) in screenData.screen_elements">
                    <div :key="idx" class="row screen-form-row">
                        <template v-for="(element, j) in row.first_elements">
                            <ScreenElement
                                :key="element.id"
                                :element="element"
                                :formValues="formValues"
                                class="col-md-12"
                                :rowNum="idx"
                                :innerRow="0"
                                :positionNum="j"
                                :activeElement="screenData.active_element_id"
                                :defaultElement="screenData.default_element_id"
                                @onButtonSubmit="buttonSubmit"
                                @onTableSubmit="tableSubmit"
                            />
                        </template>

                        <template v-for="(element, j) in row.middle_elements">
                            <ScreenElement
                                :key="element.id"
                                :element="element"
                                :formValues="formValues"
                                :class="getClass(row.positions)"
                                :rowNum="idx"
                                :innerRow="1"
                                :positionNum="j"
                                :activeElement="screenData.active_element_id"
                                :defaultElement="screenData.default_element_id"
                                @onButtonSubmit="buttonSubmit"
                                @onTableSubmit="tableSubmit"
                            />
                        </template>

                        <template v-for="(element, j) in row.last_elements">
                            <ScreenElement
                                :key="element.id"
                                :element="element"
                                :formValues="formValues"
                                class="col-md-12"
                                :rowNum="idx"
                                :innerRow="2"
                                :positionNum="j"
                                :activeElement="screenData.active_element_id"
                                :defaultElement="screenData.default_element_id"
                                @onButtonSubmit="buttonSubmit"
                                @onTableSubmit="tableSubmit"
                            />
                        </template>
                    </div>
                    <!-- .row -->
                </template>
            </div>
            <!-- .container -->
        </b-form>
    </div>
</template>



<script>
import ScreenElement from "./ScreenElement.vue";
import AppHelper from "../../helpers/AppHelper.js";

export default {
    name: "ScreenForm",
    props: ["screenData", "formValues", "onSubmit"],
    components: {
        ScreenElement
    },
    data: function() {
        return {
            form: {}
        };
    },
    computed: {},
    methods: {
        submit: function(e) {
            e.preventDefault();
            let formData = {
                formValues: this.formValues
            }
            this.$emit("onSubmit", formData);
            this.reset();
        },
        buttonSubmit: function() {
            let formData = {
                formValues: this.formValues
            }
            this.$emit("onSubmit", formData);
            this.reset();
        },
        tableSubmit: function(e) {
            let formData = {
                formValues: this.formValues
            }
            this.$emit("onSubmit", formData);
        },
        reset: function() {
            for (let element in this.formValues){
                let el = element.substr(1,element.length-2);
                if (document.querySelector('#' + el ) !== null){
                    if (document.querySelector('#' + el ).nodeName === 'INPUT'
                        && document.querySelector('#' + el ).attributes.clearcontent.value === "Tak"){
                        document.querySelector('#' + el ).value = '';
                    }
                }    
            }
        },
        getClass: function(num) {
            let suffix = Math.floor(12 / num);
            return `col-12 col-md-${suffix}`;
        }
    },
    mounted() {
        // console.log(this.screenData.custom_css); // eslint-disable-line no-console
        if (this.screenData.custom_css) {
            let file = document.createElement('link');
            file.rel = 'stylesheet';
            file.href = this.screenData.custom_css;
            document.head.appendChild(file);
        }
    },
    updated() {
        // console.log(this.screenData.custom_css); // eslint-disable-line no-console
        if (this.screenData.custom_css) {
            let file = document.createElement('link');
            file.id = 'custom-css'
            file.rel = 'stylesheet';
            file.href = this.screenData.custom_css;
            document.head.appendChild(file);
        } else {
            let customCss = document.head.querySelector("#custom-css");
            if(customCss) {
                customCss.parentNode.removeChild(customCss);
            }
        }
    }
};
</script>


<style scoped>
</style>