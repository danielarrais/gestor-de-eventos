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
import 'summernote/dist/summernote.min'

// Import Locais
import '../js/argon-design-system.js?v=1.0.0'

import './custom/ajax.utils' // Carrega funções ajax
import './custom/utils' // Carrega funções ajax
import './custom/nested-fields' // Fucnções para trabalhar com nested forms

import './conf/inputs.conf' // Definição das mascaras de input
import './conf/swal.conf.js' // Fucnções para trabalhar com nested forms

import '../scss/application.scss' // Stylsheet do sistema