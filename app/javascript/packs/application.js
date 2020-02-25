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
import '../js/plugins/choices.min.js'
import '../js/plugins/bootstrap-switch.js'
import '../js/plugins/datetimepicker.js'
import '../js/plugins/headroom.min.js'
import '../js/argon-design-system.js?v=1.0.0'

//Bootstrap 4
import '../stylesheets/application'



// Icones
import '@fortawesome/fontawesome-free/js/all';


// Mensagens de alerta
global.toastr = require('toastr');