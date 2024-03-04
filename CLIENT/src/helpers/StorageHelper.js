//
import Vue from 'vue'
import VueCookies from 'vue-cookies';
Vue.use(VueCookies);
VueCookies.config('1d');


class StorageHelper {
    constructor() {}

    static get(itemName, {mode}) {
        let item = "";

        switch (mode) {
            case 'SESSION':
                item = sessionStorage.getItem(itemName);
                break;

            case 'LOCAL':
                item = localStorage.getItem(itemName);
                break;

            case 'COOKIE':
                item =  Vue.$cookies.get(itemName);
                break;

            default:
                break;
        }

        return item;
    }

    static set(itemName, value, {mode}) {
        switch (mode) {
            case 'SESSION':
                sessionStorage.setItem(itemName, value);
                break;

            case 'LOCAL':
                localStorage.setItem(itemName, value);
                break;

            case 'COOKIE':
                Vue.$cookies.set(itemName, value);
                break;

            default:
                break;
        }
    }

    static remove(itemName, {mode}) {
        switch (mode) {
            case 'SESSION':
                sessionStorage.removeItem(itemName);
                break;

            case 'LOCAL':
                localStorage.removeItem(itemName);
                break;

            case 'COOKIE':
                Vue.$cookies.remove(itemName);
                break;

            default:
                break;
        }
    }
}

export default StorageHelper;