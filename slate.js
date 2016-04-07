var isPlayingDota = function(){
	return false;
};

slate.bind("1:ctrl", function(){
	if(isPlayingDota()){return;}
	slate.eachApp(function(app){
		if(app.name() == 'Google Chrome'){
			app.eachWindow(function(window){
				if(window.title().match(/Twitica Desktop$/)){
					window.doOperation("corner", {
						"direction": "top-right",
						"width": "screenSizeX/6",
						"height": "screenSizeY"
					});
				}else if(window.screen().isMain()){
					window.doOperation("corner", {
						"direction": "top-left",
						"width": "max({5*screenSizeX/6, 1200})",
						"height": "screenSizeY"
					});
				}
			});
		}
	});
});

slate.bind("2:ctrl", function(){
	if(isPlayingDota()){return;}
	slate.eachApp(function(app){
		if(app.name() == "iTerm"){
			var main = app.mainWindow();
			main.doOperation("move", {
				"x": "screenOriginX+newWindowSizeX/2",
				"y": "screenOriginY+newWindowSizeY/2",
				"width": 570,
				"height": 456
			});
			main.doOperation("focus", {
				"app": "iTerm"
			});
		}
	});
});

slate.bind("3:ctrl", function(window){
	if(isPlayingDota()){return;}
	window.doOperation("grid", {
		"grids": {
			"1440x900": {
				"width": 8,
				"height": 6
			},
			"1280x1024": {
				"width": 6,
				"height": 6
			}
		},
	});
});