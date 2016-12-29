function resizeSelectAsNeeded(){}
var select = document.getElementById('select');
select.size = select.length;*/

//editable combo box code
/*var initialText = $('.editable').val();
$('.editOption').val(initialText);

$('#city').change(function(){
var selected = $('option:selected', this).attr('class');
var optionText = $('.editable').text();

if(selected == "editable"){
  $('.editOption').show();


  $('.editOption').keyup(function(){
      var editText = $('.editOption').val();
      $('.editable').val(editText);
      $('.editable').html(editText);
  });

}else{
  $('.editOption').hide();
}
});