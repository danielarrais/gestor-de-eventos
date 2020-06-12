const path = require('path')

module.exports.exposeLoaders = {
    'jqueryExpose': {
        test: require.resolve('jquery'),
        use: [{
            loader: 'expose-loader',
            options: 'jQuery'
        }, {
            loader: 'expose-loader',
            options: '$'
        }]
    },

    'choisesExpose': {
        test: require.resolve('choices.js'),
        use: [{
            loader: 'expose-loader',
            options: 'Choices'
        }]
    },

    'icheckExpose': {
        "test": require.resolve('icheck', {path}),
        "use": [{
            "loader": 'expose-loader',
            "options": 'iCheck'
        }]
    },

    'toastr': {
        "test": require.resolve('toastr'),
        "use": [{
            "loader": 'expose-loader',
            "options": 'toastr'
        }]
    },
}