



var myOpts = document.getElementById('fkID').options;

for (var i=0; i &lt; myOpts.length; i++){

	if(myOpts[i].text == ""){
		$(myOpts[i]).hide();
		alert('Winning');
	}
}



//this will hide the the selceted ones 
//need to add and removed selected still in one shot
//do they need to actually stay linked up of can I link them and then unlink them, and claim and filter by link and then show again blah blah balh