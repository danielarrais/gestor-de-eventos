import flatpickr from 'flatpickr'
import {Portuguese} from 'flatpickr/dist/l10n/pt.js';

// Cria definições de máscaras
jQuery(function($){
   $('.cpf-mask').mask('000.000.000-00', {reverse: true});
   $('.cellphone-mask').mask('(00) 0000-0000');
});

// Define as configurações padrões dos data pickers
flatpickr.setDefaults({
   'locale': Portuguese,
   'dateFormat': 'd/m/Y'
});