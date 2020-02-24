require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

//Bootstrap 4
import '../js/argon-design-system'
import '../stylesheets/application'

// Icones
import '@fortawesome/fontawesome-free/js/all';


// Mensagens de alerta
global.toastr = require('toastr');