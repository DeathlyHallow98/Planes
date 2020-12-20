$.fn.SpinButton=function(b){function f(a,c){for(var e=a[c],d=document.body;(a=a.offsetParent)&&a!=d;)if(!$.browser.msie||a.currentStyle.position!="relative")e+=a[c];return e}return this.each(function(){this.repeating=false;this.spinCfg={min:b&&!isNaN(parseFloat(b.min))?Number(b.min):null,max:b&&!isNaN(parseFloat(b.max))?Number(b.max):null,step:b&&b.step?Number(b.step):1,stepfunc:b&&b.stepfunc?b.stepfunc:false,page:b&&b.page?Number(b.page):10,upClass:b&&b.upClass?b.upClass:"up",downClass:b&&b.downClass?
b.downClass:"down",reset:b&&b.reset?b.reset:this.value,delay:b&&b.delay?Number(b.delay):500,interval:b&&b.interval?Number(b.interval):100,_btn_width:20,_direction:null,_delay:null,_repeat:null,callback:b&&b.callback?b.callback:null};this.spinCfg.smallStep=b&&b.smallStep?b.smallStep:this.spinCfg.step/2;this.adjustValue=function(a){a=isNaN(this.value)?this.spinCfg.reset:$.isFunction(this.spinCfg.stepfunc)?this.spinCfg.stepfunc(this,a):Number((Number(this.value)+Number(a)).toFixed(5));if(this.spinCfg.min!==
null)a=Math.max(a,this.spinCfg.min);if(this.spinCfg.max!==null)a=Math.min(a,this.spinCfg.max);this.value=a;$.isFunction(this.spinCfg.callback)&&this.spinCfg.callback(this)};$(this).addClass(b&&b.spinClass?b.spinClass:"spin-button").mousemove(function(a){var c=a.pageX||a.x,e=a.pageY||a.y;a=a.target||a.srcElement;var d=svgEditor.tool_scale||1,g=$(a).height()/2;c=c>f(a,"offsetLeft")+a.offsetWidth*d-this.spinCfg._btn_width?e<f(a,"offsetTop")+g*d?1:-1:0;if(c!==this.spinCfg._direction){switch(c){case 1:$(this).removeClass(this.spinCfg.downClass).addClass(this.spinCfg.upClass);
break;case -1:$(this).removeClass(this.spinCfg.upClass).addClass(this.spinCfg.downClass);break;default:$(this).removeClass(this.spinCfg.upClass).removeClass(this.spinCfg.downClass)}this.spinCfg._direction=c}}).mouseout(function(){$(this).removeClass(this.spinCfg.upClass).removeClass(this.spinCfg.downClass);this.spinCfg._direction=null;window.clearInterval(this.spinCfg._repeat);window.clearTimeout(this.spinCfg._delay)}).mousedown(function(a){if(a.button===0&&this.spinCfg._direction!=0){var c=this,
e=a.shiftKey?c.spinCfg.smallStep:c.spinCfg.step,d=function(){c.adjustValue(c.spinCfg._direction*e)};d();c.spinCfg._delay=window.setTimeout(function(){d();c.spinCfg._repeat=window.setInterval(d,c.spinCfg.interval)},c.spinCfg.delay)}}).mouseup(function(){window.clearInterval(this.spinCfg._repeat);window.clearTimeout(this.spinCfg._delay)}).dblclick(function(){$.browser.msie&&this.adjustValue(this.spinCfg._direction*this.spinCfg.step)}).keydown(function(a){switch(a.keyCode){case 38:this.adjustValue(this.spinCfg.step);
break;case 40:this.adjustValue(-this.spinCfg.step);break;case 33:this.adjustValue(this.spinCfg.page);break;case 34:this.adjustValue(-this.spinCfg.page)}}).keypress(function(a){if(this.repeating)switch(a.keyCode){case 38:this.adjustValue(this.spinCfg.step);break;case 40:this.adjustValue(-this.spinCfg.step);break;case 33:this.adjustValue(this.spinCfg.page);break;case 34:this.adjustValue(-this.spinCfg.page)}else this.repeating=true}).keyup(function(a){this.repeating=false;switch(a.keyCode){case 38:case 40:case 33:case 34:case 13:this.adjustValue(0)}}).bind("mousewheel",
function(a){if(a.wheelDelta>=120)this.adjustValue(this.spinCfg.step);else a.wheelDelta<=-120&&this.adjustValue(-this.spinCfg.step);a.preventDefault()}).change(function(){this.adjustValue(0)});this.addEventListener&&this.addEventListener("DOMMouseScroll",function(a){if(a.detail>0)this.adjustValue(-this.spinCfg.step);else a.detail<0&&this.adjustValue(this.spinCfg.step);a.preventDefault()},false)})};