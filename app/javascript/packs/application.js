require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

//Bootstrap 4
import 'bootstrap'
import '../stylesheets/application'

// Icones
import '@fortawesome/fontawesome-free/js/all';

// Argon design
import 'argon-design-system-free/assets/js/argon.min'

// Mensagens de alerta
global.toastr = require('toastr');