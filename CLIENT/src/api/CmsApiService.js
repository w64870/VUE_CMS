//
import { ApiService} from "./ApiService.js";

//
const CmsApiService = {
    endpoints: {
        auth: {
            login(data) {
                return ApiService.postAll("login", null, data);
            },
            logout() {
                return ApiService.postAll("logout", null, {});
            },
            token() {
                return ApiService.postAll("token", null, {});
            },
            changePassword(data){
                return ApiService.postAll("changepasswd", null, data)
            },
            createUser(data){
                return ApiService.postAll("createuser", null, data)
            }
        },
        info: {
            get() {
                return ApiService.getAll("apiinfo", null);
            }
        },
        app: {
            getAll(params) {
                return ApiService.getAll("app", params);
            }
        },
        contexts: {
            getAll(params) {
                return ApiService.getAll("contexts", params);
            }
        },
        operations: {
            reset(params, data) {
                return ApiService.postAll("operations/reset", params, data);
            },
            getAll(params) {
                return ApiService.getAll("operations", params);
            },
            getOne(id, params) {
                return ApiService.getOne("operations", id, params);
            },
            postOne(id, params, data) {
                return ApiService.postOne("operations", id, params, data);
            }
        },
        screens: {
            getOne(id, params) {
                return ApiService.getOne("screens", id, params);
            }
        },
    }
}

export default CmsApiService;

