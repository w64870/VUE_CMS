<template>
    <div class="operation-container overflow-auto" :class="operationsClassName">
        <b-collapse id="collapse-op" visible>
            <div>
                <b-nav vertical class="operation-nav">
                    <b-nav-item
                        :class="getNavitemClass(op.id)"
                        v-for="op in operations"
                        :key="op.id"
                        class="operation-btn text-left"
                        @click="selectOperation(op.id)"
                        :style="getStyle(op)"
                        :disabled="disabled"
                    >
                        <span
                            :style="getStyle(op)"
                            class="operation-text"
                        >{{ op.description.substr(0,50) }}</span>
                    </b-nav-item>
                </b-nav>
            </div>
        </b-collapse>
    </div>
</template>


<script scoped>
export default {
    name: "Operations",
    props: [
        "currentContext",
        "currentOperation",
        "isOpMenuOpen",
        "onSelectOperation",
        "operations",
        "disabled"
    ],
    data: function() {
        return {
            isLoading: true,
            selectedOperation: this.currentOperation
        };
    },
    computed: {
        operationsClassName: function() {
            return this.isOpMenuOpen
                ? "col-12 col-md-3"
                : "d-none";
        }
    },
    methods: {
        selectOperation: function(id) {
            if (!this.disabled) {
                this.selectedOperation = id;
                this.$emit("onSelectOperation", this.selectedOperation);
            }
        },
        getNavitemClass: function(id) {
            if (this.disabled) {
                return "operation-disabled";
            }
            return id === this.currentOperation ? "operation-selected" : "";
        },
        getStyle: function(op) {
            return !this.disabled
                ? { backgroundColor: op.buttonColor, color: op.buttonTextColor }
                : {};
        }
    },
    created() {}
};
</script>


<style>
</style>
