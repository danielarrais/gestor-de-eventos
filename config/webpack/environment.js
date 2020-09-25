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
    }),
    new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/)
);

for (const exposeLoaderKey in exposeLoaders['exposeLoaders']) {
    if (exposeLoaders['exposeLoaders'].hasOwnProperty(exposeLoaderKey)) {
        environment.loaders.append(exposeLoaderKey + '', exposeLoaders['exposeLoaders'][exposeLoaderKey]);
    }
}

environment.config.set('output.library', 'gestor-de-eventos')
environment.config.set('performance.hints', false)

// resolve-url-loader must be used before sass-loader
environment.loaders.get('sass').use.splice(-1, 0, {
    loader: 'resolve-url-loader'
});


module.exports = environment;
