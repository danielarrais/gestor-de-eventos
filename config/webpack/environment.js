const {environment} = require('@rails/webpacker');
const webpack = require('webpack');

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

const jqueryExpose = {
    test: require.resolve('jquery'),
    use: [{
        loader: 'expose-loader',
        options: 'jQuery'
    }, {
        loader: 'expose-loader',
        options: '$'
    }]
};

const  choisesExpose = {
    test: require.resolve('choices.js'),
    use: [{
        loader: 'expose-loader',
        options: 'Choices'
    }]
};

const  icheckExpose = {
    test: require.resolve('icheck'),
    use: [{
        loader: 'expose-loader',
        options: 'icheck'
    }]
};

environment.loaders.append('jqueryExpose', jqueryExpose);
environment.loaders.append('choisesExpose', choisesExpose);
environment.loaders.append('choisesExpose', icheckExpose);

module.exports = environment;
