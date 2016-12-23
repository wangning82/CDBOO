function userTreeselectCallBack(v, h, f){
	var userId = $('#userId').val();
	$.ajax({
        type: "post",
        async: false,
        url: "getMusicList",
        data: {
            userId: userId
        },
        dataType: "json",
        success: function (data) {
        	$('#musicId').empty();
			$('#musicId').append('<option value="" selected>请选择</option>');
			
	       	var dataArray = eval(data);
	       	for(var i = 0;i<dataArray.length;i++){
	       		var musicId = dataArray[i].id;
	       		var musicName = dataArray[i].musicName;
	       		$('#musicId').append('<option value="'+musicId+'">'+musicName+'</option>');
	       	}
        }
    });
}