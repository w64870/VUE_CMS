//
import {
    HIDE_ERRORS
} from "./types/actions.type.js";

import {
    RESET_ERRORS
} from "./types/mutations.type.js";

//
const actions = {

    [HIDE_ERRORS](context) {
        context.commit(RESET_ERRORS);
    }

}

export default actions;