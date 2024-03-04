//
import AuthHandler from "../handlers/AuthHandler.js";

//
function httpBuildQuery(params) {
  if (!params) {
    return "";
  }
  let query = "?";

  Object.keys(params).forEach(function(key, index, array) {
    let value = params[key] ? params[key] : "";
    query += `${key}=${value}`;
    if (index < array.length - 1) {
      query += "&";
    }
  });

  return query;
}

//
export const ApiService = {
  getAll(entity, params) {
    let auth = AuthHandler.getAuth();
    let token = auth.token;

    let url = AuthHandler.getApi();

    const resourceUrl = `${url}${entity}`;
    let query = "";
    if (typeof params === "string" || params instanceof String) {
      query = params;
    }
    if (typeof params === "object" || params instanceof Object) {
      query = httpBuildQuery(params);
    }

    let headers = {
      Accept: "application/json",
      "Content-Type": "application/json"
    };
    if (token != null) {
      headers["Authorization"] = `Bearer ${token}`;
    }

    return fetch(`${resourceUrl}${query}`, {
      headers: headers
    });
  },

  getOne(entity, id, params) {
    let auth = AuthHandler.getAuth();
    let token = auth.token;

    let url = AuthHandler.getApi();

    const resourceUrl = `${url}${entity}`;
    let query = "";
    if (typeof params === "string" || params instanceof String) {
      query = params;
    }
    if (typeof params === "object" || params instanceof Object) {
      query = httpBuildQuery(params);
    }

    let headers = {
      Accept: "application/json",
      "Content-Type": "application/json"
    };
    if (token != null) {
      headers["Authorization"] = `Bearer ${token}`;
    }

    return fetch(`${resourceUrl}/${id}${query}`, {
      headers: headers
    });
  },

  postAll(entity, params, json) {
    let auth = AuthHandler.getAuth();
    let token = auth.token;

    let url = AuthHandler.getApi();

    const resourceUrl = `${url}${entity}`;
    let query = "";
    if (typeof params === "string" || params instanceof String) {
      query = params;
    }
    if (typeof params === "object" || params instanceof Object) {
      query = httpBuildQuery(params);
    }

    let headers = {
      Accept: "application/json",
      "Content-Type": "application/json"
    };
    if (token != null) {
      headers["Authorization"] = `Bearer ${token}`;
    }
    
    return fetch(`${resourceUrl}${query}`, {
      method: "POST",
      headers: headers,
      body: JSON.stringify(json)
    });
  },

  postOne(entity, id, params, json) {
    let auth = AuthHandler.getAuth();
    let token = auth.token;

    let url = AuthHandler.getApi();

    const resourceUrl = `${url}${entity}`;
    let query = "";

    if (typeof params === "string" || params instanceof String) {
      query = params;
    }
    if (typeof params === "object" || params instanceof Object) {
      query = httpBuildQuery(params);
    }

    let headers = {
      Accept: "application/json",
      "Content-Type": "application/json"
    };
    if (token != null) {
      headers["Authorization"] = `Bearer ${token}`;
    }

    return fetch(`${resourceUrl}/${id}${query}`, {
      method: "POST",
      headers: headers,
      body: JSON.stringify(json)
    });
  }

}