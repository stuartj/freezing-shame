function updateFavoured(button) {
	//you can get the value from arguments itself
	console.log( "updateFavoured fired!" );
	var a = button.id.split("_");
	var attribute = a.shift();
	var value = a.shift();
	//alert(parseInt(value) + 2);
	for(var i=1;i<4;i++) {
		if( i != value ){
			var elementID = attribute + "_" + i;
			var element = document.getElementById(elementID);

			//console.log(element);
			element.checked = false; // button.checked ? false : true;
		}
	}
	updateFavouredValues();
}

function updateFavouredValues(){
	var attributes = ['body','heart','wits'];
	for(var y=0;y<3;y++) {
		var attribute = attributes[y];
		var outputField = document.getElementById( "favoured_" + attribute );
		var base = parseInt( document.getElementById(attribute).innerHTML );
		for(var x=1;x<4;x++) {
			var button = document.getElementById(attribute + "_" + x);
			if ( button.checked ) {
				outputField.innerHTML = "( " + (base + x) + " )";
			}
		}
	}

}


function setattributes(select)
{
	var option = select.options[select.selectedIndex];
	document.getElementById("body").innerHTML = (option.getAttribute("body"));
	document.getElementById("heart").innerHTML = (option.getAttribute("heart"));
	document.getElementById("wits").innerHTML = (option.getAttribute("wits"));
	updateFavouredValues();
}
