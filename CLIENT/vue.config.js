const Env = process.env.NODE_ENV;
const AppMode = process.env.VUE_APP_MODE;

const publicPath = "/cms"
const scriptsDirectory = "js";
const stylesDirectory = "css";

const CopyPlugin = require("copy-webpack-plugin");


const prodVueConfig = {
  publicPath: publicPath,
  css: {
    extract: {
      filename: stylesDirectory + '/[name].css',
      chunkFilename: stylesDirectory + '/[name].css',
    },
  },
  configureWebpack: {
    output: {
      filename: scriptsDirectory + "/[name].js",
      chunkFilename: scriptsDirectory + "/[name].js"
    },
    plugins: [
      new CopyPlugin([
        {
          from: "config/*.sample",
          context: "."
        }
      ]),
    ]
  }
};

const devVueConfig = {
  publicPath: "",
  configureWebpack: {
    plugins: [
      new CopyPlugin([
        {
          from: "config/*.js",
          context: "."
        }
      ])
    ]
  }
};


module.exports =
  AppMode === "web"
    ? Env === "production"
      ? prodVueConfig
      : devVueConfig
    : {};
