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

    $(document).ready(function() {
        $('.summernote').each((i, value) => {
            const element = $(value)
            console.log(element.prop('rows')*10)
            const height = element.prop('rows')*10 || 200
            element.summernote({
                height: height
            })
        })
    });

    // Inicializa input de forms nested
    $(document).on("fieldsadded", (event) => {
        inicializeInputs(event.target);
    });
});

// Inicializa inputs
function inicializeInputs(element = 'body') {
    parent = $(element)
    parent.find('.cpf-mask').mask('000.000.000-00', {reverse: true});

    parent.find('select.choices-ajax').each((i, element) => {
        const choices_ajax = $(element)

        const search_mask = choices_ajax.attr('data-search-mask')
        const search_url = choices_ajax.attr('data-search-url')
        const search_text = choices_ajax.attr('data-search-text') || 'Digite o termo para busca'
        const search_min = choices_ajax.attr('data-search-min') || 2

        const choices = new Choices(element, {
            removeItemButton: true,
            placeholder: true,
            noChoicesText: search_text,
            duplicateItemsAllowed: false,
            searchEnabled: true,
        });

        if (search_mask !== undefined) {
            choices_ajax.parent().find('.choices__input').mask(search_mask, {reverse: true});
        }

        element.addEventListener(
            'search',
            function (event) {
                console.log(event.detail.value)
                if (event.detail.value.length >= search_min) {
                    choices.clearChoices();
                    ajaxGet(search_url,
                        {
                            cpf: event.detail.value,
                            selecteds: [choices.getValue(true)]
                        },
                        (response) => {
                            choices.setChoices(response);
                        });
                }
            },
            true,
        );
    })

    parent.find('select.choices').each((i, element) => {
        new Choices(element, {
            removeItemButton: true,
            search: true,
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

function getDateOfInput(element) {
    let value = $(element).attr('value')
    if (value !== '' && value !== undefined) {
        return new Date($(element).attr('value'))
    }
    return ''
}

window.inicializeInputs = inicializeInputs