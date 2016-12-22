function userTreeselectCallBack(v, h, f){
	var isLinkMusic = $('#isLinkMusic').val();
	if(isLinkMusic){
		$('#tb').empty();
	}
	
	var userId = $('#userId').val();
	 $.ajax({
        type: "post",
        async: false,
        url: "getChannelList",
        data: {
            userId: userId
        },
        dataType: "json",
        success: function (data) {
        	$('#channelId').empty();
			$('#channelId').append('<option value="" selected>请选择</option>');
			
	       	var dataArray = eval(data);
	       	for(var i = 0;i<dataArray.length;i++){
	       		var channelId = dataArray[i].id;
	       		var channelName = dataArray[i].channelName;
	       		$('#channelId').append('<option value="'+channelId+'">'+channelName+'</option>');
	       	}
        }
    });
}			

function linkMusic(){
	
	$('#tb').empty();
	
	//用户id
	var userId = $('#userId').val();
	//频道id
	var channelId = $('#channelId option:selected').val();
	
	if(userId&&channelId){
		var owner_type_public = $('#owner_type_public').val();
		var owner_type_private = $('#owner_type_private').val();
		$.ajax({
	        type: "post",
	        async: false,
	        url: "getMusicList",
	        data: {
	            userId: userId,
	            channelId:channelId
	        },
	        dataType: "json",
	        success: function (data) {
				var dataArray = eval(data);
	        	var tpl = $("#musicTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				for (var i = 0; i < dataArray.length; i++) {
					var entity = dataArray[i];
					var musicOwner = entity.musicOwner;
					if(musicOwner == owner_type_public){
						entity.musicOwner = '公有';
					}
					if(musicOwner == owner_type_private){
						entity.musicOwner = '私有';
					}
					//alert(entity.id+":"+entity.name+":"+entity.actor+":"+entity.special+":"+entity.musicOwner+":"+entity.volume)
					$('#tb').append(Mustache.render(tpl, {row: entity}));
				}
	        }
	   });
	}
}