const { environment } = require('@rails/webpacker');
const webpack = require('webpack');
const expose = require('./loaders/expose')

environment.plugins.append(
    "Provide",
    new webpack.ProvidePlugin({
        '$': "jquery",
        'jQuery': "jquery",
        'Popper': ["popper.js", "default"]
    })
);

environment.loaders.prepend('expose', expose)

module.exports = environment;
