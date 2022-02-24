$(document).on('turbolinks:load', function(){
  console.log($('.answers, .best-answer'));
  $('.answers, .best-answer').on('click', '.edit-answer-link', function(e) {
      e.preventDefault()
      $(this).hide()
      let answerId = $(this).data('answerId')
      $('form#edit-answer-' + answerId).removeClass('hidden')
  })
})