"#time".onClick(function(event) {
  event.stop();
  $('monster').load("/time");
});

"#server".onClick(function(event) {
  event.stop();
  $('monster').load("/response");
});

"#sethero".onSubmit(function(event) {
	event.stop()
	this.send({
		onSuccess: function() {
ç		}
	});
});

"#chooseculture".onSubmit(function(event) {
	event.stop()
	this.send({
		onSuccess: function() {
			$('monster').update(this.responseText);
			var s = document.getElementById("choosebackground");
			for(var i=s.length-1;i>=0;i--){
				s.remove(i);
			}
//			var a = JSON.parse('["One", "Two", "Three"]');
			for (var i=0;i<5;i++){
				var option = document.createElement("option");
				option.text = "Test " + i;
				s.add(option);
			}
		}
	});
});

"#reverse".onSubmit(function(event) {
  event.stop();
  this.send({
    onSuccess: function() {
      $('monster').update(this.responseText);
    }
  });
});