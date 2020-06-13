window.showSpinner = function hideSpinner() {
    $('.hide-for-spinner').hide()
    $('.container-spinner').css( 'display', 'table-cell')
}

window.hideSpinner = function showSpinner() {
    $('.hide-for-spinner').show()
    $('.container-spinner').css( 'display', 'none')
}