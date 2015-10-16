$(document).ready(fucntion() {

  $('.endorsements-link').on('click', function(event) {
    event.preventDefault();

    var endoresmentCount = $(this).siblings('.endorsements_count');

    $.post(this.href, function(response{
      endorsementCount.text(response.new_edorsement_count);
    })
  })
})
