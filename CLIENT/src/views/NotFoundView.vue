<template>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12 col-md-8 offset-md-2 center">
                <h1>404</h1>
                <h2>Nie odnaleziono strony</h2>
                <p>Spróbuj jeden z poniższych linków:</p>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-md-8 offset-md-2 center">
                <router-link to="/">CMS</router-link>
            </div>
        </div>
    </div>
</template>


<script>
export default {
    name: "NotFoundView",
    data: function() {
        return {
            noticesUrl: {
                name: "notices",
                params: {
                    api: CONFIG.defaultCmsApi.name
                }
            }
        };
    },
};
</script>