$(document).on('turbo:load', () => {
  $('.alert').delay(5000).fadeOut();
})

$(document).on('turbo:before-stream-render', () => {
  setTimeout(() => {
    $('.alert').fadeOut('close');
  }, 10000)
})
