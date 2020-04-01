require('@rails/ujs').start();
require('@rails/activestorage').start();
require('channels');

// Import NPM
import 'jquery'
import 'jasny-bootstrap'
import 'choices.js'
import 'icheck'
import 'flatpickr'
import 'bootstrap'
import 'popper.js'
import '@glidejs/glide'
import 'nouislider'
import 'bootstrap-switch'
import 'perfect-scrollbar'
import 'headroom.js'
import 'jquery.maskedinput'

// Import Locais
import '../js/argon-design-system.js?v=1.0.0'

// Definição das mascaras de input
import '../js/custom/inputs-conf'

// Bootstrap 4
import '../stylesheets/application'

// Mensagens de alerta
global.toastr = require('toastr');
