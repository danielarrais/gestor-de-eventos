require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

import 'jquery'

import '../js/core/popper.min.js'
import '../js/core/bootstrap.min.js'
import '../js/plugins/perfect-scrollbar.jquery.min.js'
import '../js/plugins/bootstrap-switch.js'
import '../js/plugins/nouislider.min.js'
import '../js/plugins/glide.js'
import 'choices.js'
import '../js/plugins/bootstrap-switch.js'
import 'flatpickr'
import '../js/plugins/headroom.min.js'
import '../js/plugins/jquery.mask'
import '../js/argon-design-system.js?v=1.0.0'

// Definição das mascaras de input
import '../js/custom/inputs-conf'

// Bootstrap 4
import '../stylesheets/application'

// Icones
import '@fortawesome/fontawesome-free/js/all';

// Mensagens de alerta
global.toastr = require('toastr');
