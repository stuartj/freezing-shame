"#time".onClick(function(event) {
  event.stop();
  $('monster').load("/time");
});

"#server".onClick(function(event) {
  event.stop();
  $('monster').load("/response");
});

"#makehero".onSubmit(function(event) {
	event.stop()
	this.send({
		onSuccess: function() {
ç		}
	});
});

"#setculture".onSubmit(function(event) {
	event.stop()
	this.send({
		onSuccess: function() {
			$('herodetails').update(this.responseText);
		}
	});
});


"#setbackground".onSubmit(function(event) {
	event.stop()
	this.send({
		onSuccess: function() {
			$('weaponform').update(this.responseText);
		}
	});
});

"#sethero".onSubmit(function(event) {
	event.stop()
	this.send({
		onSuccess: function() {
			$('herosummary').update(this.responseText);
		}
	});
});


"#setfeatsandbackground".onSubmit(function(event) {
	event.stop()
	this.send({
		onSuccess: function() {
			$('weaponform').update(this.responseText);
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