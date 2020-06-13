const path = require('path')

module.exports.exposeLoaders = {
    'jquery': {
        test: require.resolve('jquery'),
        use: [{
            loader: 'expose-loader',
            options: 'jQuery'
        }, {
            loader: 'expose-loader',
            options: '$'
        }]
    },
    'choises': {
        test: require.resolve('choices.js'),
        use: [{
            loader: 'expose-loader',
            options: 'Choices'
        }]
    },
    'icheck': {
        "test": require.resolve('icheck', {path}),
        "use": [{
            "loader": 'expose-loader',
            "options": 'iCheck'
        }]
    }
}