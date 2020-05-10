const {environment} = require('@rails/webpacker');
const webpack = require('webpack');
const exposeLoaders = require('./expose-loaders/expose-loader');

environment.plugins.append(
    "Provide",
    new webpack.ProvidePlugin({
        '$': "jquery",
        'jQuery': "jquery",
        'window.jQuery': "jquery",
        'window.$': "jquery",
        'Popper': ["popper.js", "default"]
    })
);

for (const exposeLoaderKey in exposeLoaders['exposeLoaders']) {
    if (exposeLoaders['exposeLoaders'].hasOwnProperty(exposeLoaderKey)) {
        environment.loaders.append(exposeLoaderKey + '', exposeLoaders['exposeLoaders'][exposeLoaderKey]);
    }
}

environment.config.set('output.library', 'seu')
environment.config.set('performance.hints', false)

module.exports = environment;
