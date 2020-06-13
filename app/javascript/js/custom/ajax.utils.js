export function ajaxGet(url, data, done_function, input_loading = undefined) {
    $.ajax(url,
        {
            data: data,
            beforeSend: function () {
                if (input_loading !== undefined) {
                    input_loading.attr('disabled', 'true')
                    input_loading.closest('div').append('<div class="icon-container"><i class="loader"></i></div>')
                    input_loading.css('background-color', '#ffffff');
                    $('.icon-container').css('background-color', '#ffffff');
                }
            }
        }).done((response) => {
        done_function(response)

        if (input_loading !== undefined) {
            input_loading.removeAttr('disabled');
            input_loading.focus();
            $('.icon-container').remove().val(input_loading.val());
        }
    });
}

window.ajaxGet = ajaxGet