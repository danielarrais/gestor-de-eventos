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

    $(document).ready(function () {
        $('.summernote').each((i, value) => {
            const element = $(value)
            const height = element.prop('rows') * 10 || 200

            element.summernote({
                height: height,
                toolbar: [
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['font', ['fontname', 'strikethrough', 'superscript', 'subscript']],
                    ['fontsize', ['8', '9', '10', '11', '12', '14', '18', '20', '22', '24', '26', '28', '30']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                    ['tags', ['tags']]
                ]
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
        // console.log(choices_ajax.attr("placeholder"))
        const search_mask = choices_ajax.attr('data-search-mask')
        const search_url = choices_ajax.attr('data-search-url')
        const search_text = choices_ajax.attr('data-search-text') || 'Digite o termo para busca'
        const search_min = choices_ajax.attr('data-search-min') || 2
        const max_items = choices_ajax.attr('data-max-items') || -1

        const choices = new Choices(element, {
            removeItemButton: true,
            placeholder: true,
            duplicateItemsAllowed: false,
            searchEnabled: true,
            placeholderValue: 'fvzxcvzxcv',
            searchPlaceholderValue: 'xcvzxcvzxcvzxc',
            maxItemCount: max_items,
            loadingText: 'Buscando...',
            noResultsText: 'Nenhum resultado encontrado',
            noChoicesText: search_text,
            itemSelectText: 'Clique para selecionar',
            maxItemText: (maxItemCount) => {
                return `Só ${maxItemCount} itens podem ser selecionados`;
            },
        });

        if (choices.getValue().length !== 0) {
            addPlaceholderChoices(choices_ajax, '')
        }

        addPlaceholderChoices(choices_ajax, '')

        if (search_mask !== undefined) {
            choices_ajax.parent().find('.choices__input').mask(search_mask, {reverse: true});
        }

        element.addEventListener(
            'search',
            function (event) {
                if (event.detail.value.length >= search_min) {
                    choices.clearChoices();
                    ajaxGet(search_url,
                        {
                            value: event.detail.value,
                            selecteds: [choices.getValue(true)]
                        },
                        (response) => {
                            choices.setChoices(response);
                        });
                }
            },
            true,
        );

        element.addEventListener(
            'removeItem',
            function () {
                choices.clearChoices();
                if (choices.getValue().length === 0) {
                    addPlaceholderChoices(choices_ajax)
                }
            },
            true,
        );

        element.addEventListener(
            'choice',
            function () {
                addPlaceholderChoices(choices_ajax, ' ')
            },
            true,
        );
    })

    parent.find('select.choices').each((i, element) => {
        new Choices(element, {
            // removeItemButton: true
            placeholder: true,
            searchPlaceholderValue: "Filtro",
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

function addPlaceholderChoices(element, value) {
    element.closest('.choices__inner').find('.choices__input--cloned').attr('placeholder', value || element.attr("placeholder"))
}

function getDateOfInput(element) {
    let value = $(element).attr('value')
    if (value !== '' && value !== undefined) {
        return new Date($(element).attr('value'))
    }
    return ''
}

window.inicializeInputs = inicializeInputs