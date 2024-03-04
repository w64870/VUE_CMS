//
import CmsApp from "../views/cms/CmsApp.vue";
import NotFoundView from "../views/NotFoundView.vue";


const routes = [
    { path: '/', name: 'cms', component: CmsApp },
    { path: '*', name: 'notFound', component: NotFoundView }
];


export default routes;