<template>
    <input
        type="hidden"
        :id="element.id"
        :name="element.nameAttribute"
        :value="element.value"
        :minlength="element.minLength"
        :maxlength="element.maxLength"
    >
</template>


<script>

export default {
    name: "HiddenValue",
    props: ["element", "formValues"],
    components: {},
    data: function() {
        return {};
    },
    methods: {}
};
</script>


<style scoped>
</style>