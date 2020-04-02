require('@rails/ujs').start();
require('@rails/activestorage').start();
require('channels');

// Import YARN
import 'jquery'
import 'bootstrap'
import 'popper.js'
import 'jasny-bootstrap'
import 'bootstrap-switch'
import 'choices.js'
import 'icheck'
import 'flatpickr'
import 'animejs'
import 'moment'
import '@glidejs/glide'
import 'slick-carousel'
import 'nouislider'
import 'perfect-scrollbar'
import 'headroom.js'
import 'jquery-mask-plugin'

// Import Locais
import '../js/argon-design-system.js?v=1.0.0'

// Definição das mascaras de input
import '../js/custom/inputs-conf'

// Stylsheet do sistema
import '../scss/application.scss'

// Mensagens de alerta
global.toastr = require('toastr');
