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

import '../js/custom/inputs-conf' // Definição das mascaras de input
import '../js/custom/ajax-functions' // Carrega funções ajax

import '../js/custom/nested-fields' // Fucnções para trabalhar com nested forms

import '../scss/application.scss' // Stylsheet do sistema

global.toastr = require('toastr'); // Mensagens de alerta
