<template>
    <span></span>
</template>


<script>

export default {
    name: "JSScript",
    props: ["element", "formValues"],
    components: {},
    data: function() {
        return {};
    },
    mounted() {
        let jsScript = document.createElement('script');
        jsScript.setAttribute('id', this.element.idAttribute);
        jsScript.innerText = this.element.content;
        document.head.appendChild(jsScript);
    },
    methods: {}
};
</script>


<style scoped>
</style>