//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .


// $(document).ready(function() {
//   $('ul.nav.nav-pills li a').click(function() {           
//       $(this).parent().addClass('active').siblings().removeClass('active');           
//   });
// });


window.DeleteTechnologyInput = (function() {
  var handleInput;
  handleInput = function(el, pre_id) {
    var $button, input, input_form, previus_technology;
    previus_technology = $(el).find('#' + pre_id);
    previus_technology.find('.btn.btn-primary').css('display', 'block');
    input = $(el).find('.technology_input');
    input_form = $(el).find('.technology_input_form');
    if (!input.val() && !input_form.val()) {
      $button = $(el).find('.btn.btn-success');
      return $button.show();
    }
  };
  return {
    init: function(el, pre_id) {
      return handleInput(el, pre_id);
    }
  };
})();
