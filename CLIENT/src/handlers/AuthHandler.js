//
import StorageHelper from "../helpers/StorageHelper.js";
const DEFAULT_MODE = "LOCAL";

class AuthHandler {
    constructor() {}

    //
    static setToken(tokenData) {
        StorageHelper.set("TOKEN", tokenData.token, { mode: DEFAULT_MODE});
        StorageHelper.set("EXPIRES", tokenData.expires, { mode: DEFAULT_MODE});
    }

    //
    static setAuth(tokenData) {
        StorageHelper.set("USER", tokenData.user, { mode: DEFAULT_MODE});
        StorageHelper.set("TOKEN", tokenData.token, { mode: DEFAULT_MODE});
        StorageHelper.set("EXPIRES", tokenData.expires, { mode: DEFAULT_MODE});
        StorageHelper.set("MODIFYALLOWED", tokenData.modifyAllowed, {mode: DEFAULT_MODE});
    }

    static getAuth() {
        const user = StorageHelper.get("USER", { mode: DEFAULT_MODE});
        const token = StorageHelper.get("TOKEN", { mode: DEFAULT_MODE})
        const expires = StorageHelper.get("EXPIRES", { mode: DEFAULT_MODE});
        const modifyAllowed = StorageHelper.get("MODIFYALLOWED", {mode: DEFAULT_MODE});

        let auth = {
            user: user,
            token: token,
            expires: expires,
            modifyAllowed: modifyAllowed
        };

        return auth;
    }

    static purgeAuth() {
        StorageHelper.remove("USER", { mode: DEFAULT_MODE});
        StorageHelper.remove("TOKEN", { mode: DEFAULT_MODE});
        StorageHelper.remove("EXPIRES", { mode: DEFAULT_MODE});
        StorageHelper.remove("MODIFYALLOWED", { mode: DEFAULT_MODE});
    }

    //
    static setApi(url) {
        StorageHelper.set("API_URL", url, { mode: DEFAULT_MODE});
    }

    static getApi() {
        return StorageHelper.get("API_URL", { mode: DEFAULT_MODE});
    }

    //
    static setLoginStatus(status) {
        
        if(status === true) {
            StorageHelper.set("LOGGED_IN", true, { mode: DEFAULT_MODE});
        } else {
            StorageHelper.remove("LOGGED_IN", { mode: DEFAULT_MODE});
        }
    }

    static getLoginStatus() {
        return StorageHelper.get("LOGGED_IN", { mode: DEFAULT_MODE});
    }

}

export default AuthHandler;