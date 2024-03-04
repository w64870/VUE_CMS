//
import "@babel/polyfill";
import "isomorphic-fetch";

//
import Vue from 'vue';

//
import VueResource from 'vue-resource';
Vue.use(VueResource);
Vue.http.options.root = CONFIG.defaultCmsApi.url;

//
import VueRouter from 'vue-router';
import routes from "./routes/routes.js";

Vue.use(VueRouter);
const router = new VueRouter({
  base: CONFIG.baseUrl,
  routes: routes,
  mode: 'history'
});

//
import VeeValidate, { Validator } from 'vee-validate';
//// import pl from 'vee-validate/dist/locale/pl';

Vue.use(VeeValidate);
//
import BootstrapVue from 'bootstrap-vue';
Vue.use(BootstrapVue);

//
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';

//
import Spinner from 'vue-simple-spinner';
Vue.component('vue-simple-spinner', Spinner);

//
import VueQrcode from '@chenfengyuan/vue-qrcode';
Vue.component(VueQrcode.name, VueQrcode);

//
import FontAwesomeIcon from './styles/fa_icons.js';
Vue.component('font-awesome-icon', FontAwesomeIcon);

Vue.config.productionTip = false;

//
import './styles/css/app.css';
import './styles/css/mes.css';
import './styles/css/screenelements.css'

//
import store from "./store/store.js";

//
import App from './App.vue';

//
new Vue({
  store: store,
  router: router,
  render: h => h(App),
}).$mount('#app');
