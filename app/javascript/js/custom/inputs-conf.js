import flatpickr from 'flatpickr'
import {Portuguese} from 'flatpickr/dist/l10n/pt.js';
import Choices from "choices.js";

// Define as configurações padrões dos data pickers
flatpickr.setDefaults({
    locale: Portuguese,
    dateFormat: 'd/m/Y'
});

// Inicializa inputs
jQuery(function ($) {
    inicializeInputs()

    // Inicializa input de forms nested
    $(document).on("fieldsadded", (event) => {
        inicializeInputs(event.target);
    });
});

// Inicializa inputs
function inicializeInputs(element = 'body') {
    parent = $(element)
    parent.find('.cpf-mask').mask('000.000.000-00', {reverse: true});
    parent.find('select.choices').each((i, element) => {
        new Choices(element, {
            removeItemButton: true,
        });
    })

    parent.find('.flatpickr').each((i, element) => {
        flatpickr(element, {
            defaultDate: getDateOfInput(element),
        })
    })

    parent.find('.datetimepicker').each((i, element) => {
        flatpickr(element, {
            enableTime: true,
            defaultDate: getDateOfInput(element),
            dateFormat: "d/m/Y H:i",
        })
    })
}

function getDateOfInput(element){
    let value = $(element).attr('value')
    if (value !== '' && value !== undefined) {
        return new Date($(element).attr('value'))
    }
    return ''
}

window.inicializeInputs = inicializeInputs