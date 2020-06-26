window.showSpinner = function hideSpinner() {
    $('.hide-for-spinner').hide()
    $('.container-spinner').css( 'display', 'table-cell')
}

window.hideSpinner = function showSpinner() {
    $('.hide-for-spinner').show()
    $('.container-spinner').css( 'display', 'none')
}

window.submit = function submit(form) {
    $(`#${form}`).submit();
}

window.clearForm = function clearForm(form) {
    $(form).find(':input').each(function() {
        switch(this.type) {
            case 'password':
            case 'select-multiple':
            case 'select-one':
            case 'text':
            case 'textarea':
                $(this).val('');
                break;
            case 'checkbox':
            case 'radio':
                this.checked = false;
        }
    });

    $(form).find('select').each(function(i, element) {
        $(element).val('');
    });

    $(form).submit();
}