import flatpickr from 'flatpickr'
import {Portuguese} from 'flatpickr/dist/l10n/pt.js';
import Choices from "choices.js";

// Cria definições de máscaras
jQuery(function($){
   $('.cpf-mask').mask('000.000.000-00', {reverse: true});
   $('.cellphone-mask').mask('(00) 0000-0000');
   loadingChoices();
});

// Define as configurações padrões dos data pickers
flatpickr.setDefaults({
   'locale': Portuguese,
   'dateFormat': 'd/m/Y'
});

// Cria choices
function loadingChoices() {
   $('select.choices').each((i, element) => {
      new Choices(element, {
         removeItemButton: true,
      });
   })
}