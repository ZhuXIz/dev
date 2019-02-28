function init(){
	var _height=getScreenWindwoHeight();
	var _width=getScreenWindwoWidth();
	
	if(_width >=480) {
		_width = 480;
		jQuery("html").css("cssText","font-size:" +(_width*0.0375)+"px !important");
	} else {
		jQuery("html").css("cssText","font-size:" +(_width*0.0375)+"px");
	}
 	
}
jQuery(function(){
	init();
	
	$('.m-popup').on('click', '.close-popup', function() {
		$(this).parents('.m-popup').closeMyPopup();
	})
});
window.onresize=function(){
	init();
}
function getScreenWindwoHeight(){
	var swh=0;
	if(window.innerHeight){
		swh=window.innerHeight;
	}else if(document.body&&document.body.clientHeight){
		swh=document.body.clientHeight;
	}
	if(document.documentElement&&document.documentElement.clientHeight){
		swh=document.documentElement.clientHeight;
	}
	return swh;
}
function getScreenWindwoWidth(){
	var swh=0;
	if(window.innerWidth){
		swh=window.innerWidth;
	}else if(document.body&&document.body.clientWidth){
		swh=document.body.clientWidth;
	}
	if(document.documentElement&&document.documentElement.clientWidth){
		swh=document.documentElement.clientWidth;
	}
	return swh;
}

$.fn.openMyPopup = function() {
	var _pop = this;
	var _modal = _pop.find('.pop_modal');
	_pop.show();
	_modal.addClass('animated bounceInUp');
}
$.fn.closeMyPopup = function() {
	var _pop = this;
	var _modal = _pop.find('.pop_modal');
	_pop.hide();
	_modal.removeClass('animated bounceInUp');
}

//楠岃瘉鎵嬫満鍙�
// var phoneValiateRule = /^(13[0-9]|14[5-9]|15[012356789]|166|17[0-8]|18[0-9]|19[0-9])[0-9]{8}$/;
var phoneValiateRule = /^1[3-9][0-9]{9}$/;
function is_mobile(value){
	if(phoneValiateRule.test(value)){
	   return true;
	}else{
	   return false;
	}
}