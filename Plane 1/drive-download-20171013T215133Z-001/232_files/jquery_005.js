﻿(function(){function r(i,z,t){i=document.createElementNS(A.svg,i);if(Ba)for(var B in z)i.setAttribute(B,z[B]);else for(B in z){var W=z[B],w=i[B];if(w&&w.constructor==="SVGLength")w.baseVal.value=W;else i.setAttribute(B,W)}t&&t.appendChild(i);return i}var A={svg:"http://www.w3.org/2000/svg",xlink:"http://www.w3.org/1999/xlink"};if(!window.console)window.console=new function(){this.log=function(){};this.dir=function(){}};$.jGraduate={Paint:function(i){i=i||{};this.alpha=isNaN(i.alpha)?100:i.alpha;if(i.copy){this.type=
i.copy.type;this.alpha=i.copy.alpha;this.radialGradient=this.linearGradient=this.solidColor=null;switch(this.type){case "solidColor":this.solidColor=i.copy.solidColor;break;case "linearGradient":this.linearGradient=i.copy.linearGradient.cloneNode(true);break;case "radialGradient":this.radialGradient=i.copy.radialGradient.cloneNode(true)}}else if(i.linearGradient){this.type="linearGradient";this.radialGradient=this.solidColor=null;this.linearGradient=i.linearGradient.cloneNode(true)}else if(i.radialGradient){this.type=
"radialGradient";this.linearGradient=this.solidColor=null;this.radialGradient=i.radialGradient.cloneNode(true)}else if(i.solidColor){this.type="solidColor";this.solidColor=i.solidColor}else{this.type="none";this.radialGradient=this.linearGradient=this.solidColor=null}}};jQuery.fn.jGraduateDefaults={paint:new $.jGraduate.Paint,window:{pickerTitle:"Drag markers to pick a paint"},images:{clientPath:"images/"},newstop:"inverse"};var Ba=navigator.userAgent.indexOf("Gecko/")>=0;jQuery.fn.jGraduate=function(i){var z=
arguments;return this.each(function(){function t(c,a,d,h,f){var l=f||r("stop",{"stop-color":a,"stop-opacity":d,offset:c},g);if(f){a=f.getAttribute("stop-color");d=f.getAttribute("stop-opacity");c=f.getAttribute("offset")}else g.appendChild(l);if(d===null)d=1;f=r("path",{d:"M-6.2,0.9c3.6-4,6.7-4.3,6.7-12.4c-0.2,7.9,3.1,8.8,6.5,12.4c3.5,3.8,2.9,9.6,0,12.3c-3.1,2.8-10.4,2.7-13.2,0C-9.6,9.9-9.4,4.4-6.2,0.9z",fill:"url(#jGraduate_trans)",transform:"translate("+(10+c*j)+", 26)"},fa);var X=r("path",{d:"M-6.2,0.9c3.6-4,6.7-4.3,6.7-12.4c-0.2,7.9,3.1,8.8,6.5,12.4c3.5,3.8,2.9,9.6,0,12.3c-3.1,2.8-10.4,2.7-13.2,0C-9.6,9.9-9.4,4.4-6.2,0.9z",
fill:a,"fill-opacity":d,transform:"translate("+(10+c*j)+", 26)",stroke:"#000","stroke-width":1.5},fa);$(X).mousedown(function(M){B(this);R=F;N.mousemove(la).mouseup(W);S=ga.offset();M.preventDefault();return false}).data("stop",l).data("bg",f).dblclick(function(){$("div.jGraduate_LightBox").show();for(var M=this,I=+l.getAttribute("stop-opacity")||1,C=l.getAttribute("stop-color")||1,Y=(parseFloat(I)*255).toString(16);Y.length<2;)Y="0"+Y;a=C.substr(1)+Y;$("#"+b+"_jGraduate_stopPicker").css({left:100,
bottom:15}).jPicker({window:{title:"Pick the start color and opacity for the gradient"},images:{clientPath:o.images.clientPath},color:{active:a,alphaSupport:true}},function(Z){C=Z.val("hex")?"#"+Z.val("hex"):"none";I=Z.val("a")!==null?Z.val("a")/256:1;M.setAttribute("fill",C);M.setAttribute("fill-opacity",I);l.setAttribute("stop-color",C);l.setAttribute("stop-opacity",I);$("div.jGraduate_LightBox").hide();$("#"+b+"_jGraduate_stopPicker").hide()},null,function(){$("div.jGraduate_LightBox").hide();
$("#"+b+"_jGraduate_stopPicker").hide()})});$(g).find("stop").each(function(){var M=$(this);if(+this.getAttribute("offset")>c){if(!a){var I=this.getAttribute("stop-color"),C=this.getAttribute("stop-opacity");l.setAttribute("stop-color",I);X.setAttribute("fill",I);l.setAttribute("stop-opacity",C===null?1:C);X.setAttribute("fill-opacity",C===null?1:C)}M.before(l);return false}});h&&B(X);return l}function B(c){F&&F.setAttribute("stroke","#000");c.setAttribute("stroke","blue");F=c;F.parentNode.appendChild(F)}
function W(){N.unbind("mousemove",la);if(O.getAttribute("display")!=="none"){O.setAttribute("display","none");var c=$(F),a=c.data("stop");c=c.data("bg");$([F,a,c]).remove()}R=null}function w(){var c=T?"rotate("+T+","+ha+","+ia+") ":"";J===1&&G===1?g.removeAttribute("gradientTransform"):g.setAttribute("gradientTransform",c+"translate("+-ha*(J-1)+","+-ia*(G-1)+") scale("+J+","+G+")")}function la(c){var a=c.pageX-S.left;c=c.pageY-S.top;a=a<10?10:a>j+10?j+10:a;var d="translate("+a+", 26)";if(c<-60||c>
130){O.setAttribute("display","block");O.setAttribute("transform",d)}else O.setAttribute("display","none");R.setAttribute("transform",d);$.data(R,"bg").setAttribute("transform",d);$.data(R,"stop").setAttribute("offset",(a-10)/j);var h=0;$(g).find("stop").each(function(){var f=this.getAttribute("offset"),l=$(this);if(f<h){l.prev().before(l);D=$(g).find("stop")}h=f})}var e=$(this),o=$.extend(true,{},jQuery.fn.jGraduateDefaults,i),b=e.attr("id"),s="#"+e.attr("id")+" ";if(s){var ma=function(){switch(e.paint.type){case "radialGradient":e.paint.linearGradient=
null;break;case "linearGradient":e.paint.radialGradient=null;break;case "solidColor":e.paint.radialGradient=e.paint.linearGradient=null}$.isFunction(e.okCallback)&&e.okCallback(e.paint);e.hide()},na=function(){$.isFunction(e.cancelCallback)&&e.cancelCallback();e.hide()};$.extend(true,e,{paint:new $.jGraduate.Paint({copy:o.paint}),okCallback:$.isFunction(z[1])&&z[1]||null,cancelCallback:$.isFunction(z[2])&&z[2]||null});e.position();var u=null,N=$(window);if(e.paint.type=="none")e.paint=$.jGraduate.Paint({solidColor:"ffffff"});
e.addClass("jGraduate_Picker");e.html('<ul class="jGraduate_tabs"><li class="jGraduate_tab_color jGraduate_tab_current" data-type="col">Solid Color</li><li class="jGraduate_tab_lingrad" data-type="lg">Linear Gradient</li><li class="jGraduate_tab_radgrad" data-type="rg">Radial Gradient</li></ul><div class="jGraduate_colPick"></div><div class="jGraduate_gradPick"></div><div class="jGraduate_LightBox"></div><div id="'+b+'_jGraduate_stopPicker" class="jGraduate_stopPicker"></div>');var Ca=$(s+"> .jGraduate_colPick"),
n=$(s+"> .jGraduate_gradPick");n.html('<div id="'+b+'_jGraduate_Swatch" class="jGraduate_Swatch"><h2 class="jGraduate_Title">'+o.window.pickerTitle+'</h2><div id="'+b+'_jGraduate_GradContainer" class="jGraduate_GradContainer"></div><div id="'+b+'_jGraduate_StopSlider" class="jGraduate_StopSlider"></div></div><div class="jGraduate_Form jGraduate_Points jGraduate_lg_field"><div class="jGraduate_StopSection"><label class="jGraduate_Form_Heading">Begin Point</label><div class="jGraduate_Form_Section"><label>x:</label><input type="text" id="'+
b+'_jGraduate_x1" size="3" title="Enter starting x value between 0.0 and 1.0"/><label> y:</label><input type="text" id="'+b+'_jGraduate_y1" size="3" title="Enter starting y value between 0.0 and 1.0"/></div></div><div class="jGraduate_StopSection"><label class="jGraduate_Form_Heading">End Point</label><div class="jGraduate_Form_Section"><label>x:</label><input type="text" id="'+b+'_jGraduate_x2" size="3" title="Enter ending x value between 0.0 and 1.0"/><label> y:</label><input type="text" id="'+
b+'_jGraduate_y2" size="3" title="Enter ending y value between 0.0 and 1.0"/></div></div></div><div class="jGraduate_Form jGraduate_Points jGraduate_rg_field"><div class="jGraduate_StopSection"><label class="jGraduate_Form_Heading">Center Point</label><div class="jGraduate_Form_Section"><label>x:</label><input type="text" id="'+b+'_jGraduate_cx" size="3" title="Enter x value between 0.0 and 1.0"/><label> y:</label><input type="text" id="'+b+'_jGraduate_cy" size="3" title="Enter y value between 0.0 and 1.0"/></div></div><div class="jGraduate_StopSection"><label class="jGraduate_Form_Heading">Focal Point</label><div class="jGraduate_Form_Section"><label>Match center: <input type="checkbox" checked="checked" id="'+
b+'_jGraduate_match_ctr"/></label><br/><label>x:</label><input type="text" id="'+b+'_jGraduate_fx" size="3" title="Enter x value between 0.0 and 1.0"/><label> y:</label><input type="text" id="'+b+'_jGraduate_fy" size="3" title="Enter y value between 0.0 and 1.0"/></div></div></div><div class="jGraduate_StopSection jGraduate_SpreadMethod"><label class="jGraduate_Form_Heading">Spread method</label><div class="jGraduate_Form_Section"><select class="jGraduate_spreadMethod"><option value=pad selected>Pad</option><option value=reflect>Reflect</option><option value=repeat>Repeat</option></select></div></div><div class="jGraduate_Form"><div class="jGraduate_Slider jGraduate_RadiusField jGraduate_rg_field"><label class="prelabel">Radius:</label><div id="'+
b+'_jGraduate_Radius" class="jGraduate_SliderBar jGraduate_Radius" title="Click to set radius"><img id="'+b+'_jGraduate_RadiusArrows" class="jGraduate_RadiusArrows" src="'+o.images.clientPath+'rangearrows2.gif"></div><label><input type="text" id="'+b+'_jGraduate_RadiusInput" size="3" value="100"/>%</label></div><div class="jGraduate_Slider jGraduate_EllipField jGraduate_rg_field"><label class="prelabel">Ellip:</label><div id="'+b+'_jGraduate_Ellip" class="jGraduate_SliderBar jGraduate_Ellip" title="Click to set Ellip"><img id="'+
b+'_jGraduate_EllipArrows" class="jGraduate_EllipArrows" src="'+o.images.clientPath+'rangearrows2.gif"></div><label><input type="text" id="'+b+'_jGraduate_EllipInput" size="3" value="0"/>%</label></div><div class="jGraduate_Slider jGraduate_AngleField jGraduate_rg_field"><label class="prelabel">Angle:</label><div id="'+b+'_jGraduate_Angle" class="jGraduate_SliderBar jGraduate_Angle" title="Click to set Angle"><img id="'+b+'_jGraduate_AngleArrows" class="jGraduate_AngleArrows" src="'+o.images.clientPath+
'rangearrows2.gif"></div><label><input type="text" id="'+b+'_jGraduate_AngleInput" size="3" value="0"/>deg</label></div><div class="jGraduate_Slider jGraduate_OpacField"><label class="prelabel">Opac:</label><div id="'+b+'_jGraduate_Opac" class="jGraduate_SliderBar jGraduate_Opac" title="Click to set Opac"><img id="'+b+'_jGraduate_OpacArrows" class="jGraduate_OpacArrows" src="'+o.images.clientPath+'rangearrows2.gif"></div><label><input type="text" id="'+b+'_jGraduate_OpacInput" size="3" value="100"/>%</label></div></div><div class="jGraduate_OkCancel"><input type="button" id="'+
b+'_jGraduate_Ok" class="jGraduate_Ok" value="OK"/><input type="button" id="'+b+'_jGraduate_Cancel" class="jGraduate_Cancel" value="Cancel"/></div>');var j=256,oa=j-0,pa=j-0,p,g,aa,q={};$(".jGraduate_SliderBar").width(145);var x=$("#"+b+"_jGraduate_GradContainer")[0],m=r("svg",{id:b+"_jgraduate_svg",width:j,height:j,xmlns:A.svg},x);p=p||e.paint.type;var v=g=e.paint[p],U=e.paint.alpha,ba=p==="solidColor";switch(p){case "solidColor":case "linearGradient":if(!ba){g.id=b+"_lg_jgraduate_grad";v=g=m.appendChild(g)}r("radialGradient",
{id:b+"_rg_jgraduate_grad"},m);if(p==="linearGradient")break;case "radialGradient":if(!ba){g.id=b+"_rg_jgraduate_grad";v=g=m.appendChild(g)}r("linearGradient",{id:b+"_lg_jgraduate_grad"},m)}if(ba){v=g=$("#"+b+"_lg_jgraduate_grad")[0];u=e.paint[p];t(0,"#"+u,1);var K=typeof o.newstop;if(K==="string")switch(o.newstop){case "same":t(1,"#"+u,1);break;case "inverse":K="";for(var y=0;y<6;y+=2){u.substr(y,2);var P=(255-parseInt(u.substr(y,2),16)).toString(16);if(P.length<2)P=0+P;K+=P}t(1,"#"+K,1);break;case "white":t(1,
"#ffffff",1);break;case "black":t(1,"#000000",1)}else if(K==="object")t(1,o.newstop.color||"#"+u,"opac"in o.newstop?o.newstop.opac:1)}u=parseFloat(v.getAttribute("x1")||0);K=parseFloat(v.getAttribute("y1")||0);y=parseFloat(v.getAttribute("x2")||1);P=parseFloat(v.getAttribute("y2")||0);var ca=parseFloat(v.getAttribute("cx")||0.5),da=parseFloat(v.getAttribute("cy")||0.5),qa=parseFloat(v.getAttribute("fx")||ca),ra=parseFloat(v.getAttribute("fy")||da);aa=r("rect",{id:b+"_jgraduate_rect",x:0,y:0,width:oa,
height:pa,fill:"url(#"+b+"_jgraduate_grad)","fill-opacity":U/100},m);var sa=$("<div/>").attr({"class":"grad_coord jGraduate_lg_field",title:"Begin Stop"}).text(1).css({top:K*j,left:u*j}).data("coord","start").appendTo(x),Da=sa.clone().text(2).css({top:P*j,left:y*j}).attr("title","End stop").data("coord","end").appendTo(x),ta=$("<div/>").attr({"class":"grad_coord jGraduate_rg_field",title:"Center stop"}).text("C").css({top:da*j,left:ca*j}).data("coord","center").appendTo(x),V=ta.clone().text("F").css({top:ra*
j,left:qa*j,display:"none"}).attr("title","Focus point").data("coord","focus").appendTo(x);V[0].id=b+"_jGraduate_focusCoord";$(s+" .grad_coord");$.each(["x1","y1","x2","y2","cx","cy","fx","fy"],function(c,a){var d=g.getAttribute(a),h=isNaN(a[1]);d||(d=h?"0.5":a==="x2"?"1.0":"0.0");q[a]=$("#"+b+"_jGraduate_"+a).val(d).change(function(){if(isNaN(parseFloat(this.value))||this.value<0)this.value=0;else if(this.value>1)this.value=1;if(!(a[0]==="f"&&!E))if(h&&p==="radialGradient"||!h&&p==="linearGradient")g.setAttribute(a,
this.value);var f=h?a[0]==="c"?ta:V:a[1]==="1"?sa:Da,l=a.indexOf("x")>=0?"left":"top";f.css(l,this.value*j)}).change()});var D,fa,ga=$("#"+b+"_jGraduate_StopSlider"),F,H,R,O=r("path",{d:"m9.75,-6l-19.5,19.5m0,-19.5l19.5,19.5",fill:"none",stroke:"#D00","stroke-width":5,display:"none"},H),S,J=1,G=1,T=0,ha=ca,ia=da;H=r("svg",{width:"100%",height:45},ga[0]);x=r("pattern",{width:16,height:16,patternUnits:"userSpaceOnUse",id:"jGraduate_trans"},H);r("image",{width:16,height:16},x).setAttributeNS(A.xlink,
"xlink:href",o.images.clientPath+"map-opacity.png");$(H).click(function(c){S=ga.offset();if(c.target.tagName!=="path"){var a=c.pageX-S.left-8;a=a<10?10:a>j+10?j+10:a;t(a/j,0,0,true);c.stopPropagation()}});$(H).mouseover(function(){H.appendChild(O)});fa=r("g",{},H);r("line",{x1:10,y1:15,x2:j+10,y2:15,"stroke-width":2,stroke:"#000"},H);var ua=n.find(".jGraduate_spreadMethod").change(function(){g.setAttribute("spreadMethod",$(this).val())}),Q=null,va=function(c){var a=c.pageX-ja.left,d=c.pageY-ja.top;
a=a<0?0:a>j?j:a;d=d<0?0:d>j?j:d;Q.css("left",a).css("top",d);a=a/oa;d=d/pa;var h=Q.data("coord"),f=g;switch(h){case "start":q.x1.val(a);q.y1.val(d);f.setAttribute("x1",a);f.setAttribute("y1",d);break;case "end":q.x2.val(a);q.y2.val(d);f.setAttribute("x2",a);f.setAttribute("y2",d);break;case "center":q.cx.val(a);q.cy.val(d);f.setAttribute("cx",a);f.setAttribute("cy",d);ha=a;ia=d;w();break;case "focus":q.fx.val(a);q.fy.val(d);f.setAttribute("fx",a);f.setAttribute("fy",d);w()}c.preventDefault()},wa=
function(){Q=null;N.unbind("mousemove",va).unbind("mouseup",wa)};D=g.getElementsByTagNameNS(A.svg,"stop");if(k<2){for(;k<2;){g.appendChild(document.createElementNS(A.svg,"stop"));++k}D=g.getElementsByTagNameNS(A.svg,"stop")}var k=D.length;for(y=0;y<k;y++)t(0,0,0,0,D[y]);ua.val(g.getAttribute("spreadMethod")||"pad");var ja,E=false;aa.setAttribute("fill-opacity",U/100);$("#"+b+" div.grad_coord").mousedown(function(c){c.preventDefault();Q=$(this);Q.offset();ja=Q.parent().offset();N.mousemove(va).mouseup(wa)});
$("#"+b+"_jGraduate_Ok").bind("click",function(){e.paint.type=p;e.paint[p]=g.cloneNode(true);e.paint.solidColor=null;ma()});$("#"+b+"_jGraduate_Cancel").bind("click",function(){na()});if(p==="radialGradient")if(E)V.show();else{V.hide();q.fx.val("");q.fy.val("")}$("#"+b+"_jGraduate_match_ctr")[0].checked=!E;var xa,ya;$("#"+b+"_jGraduate_match_ctr").change(function(){E=!this.checked;V.toggle(E);q.fx.val("");q.fy.val("");var c=g;if(E){var a=xa||0.5,d=ya||0.5;c.setAttribute("fx",a);c.setAttribute("fy",
d);q.fx.val(a);q.fy.val(d)}else{xa=c.getAttribute("fx");ya=c.getAttribute("fy");c.removeAttribute("fx");c.removeAttribute("fy")}});D=g.getElementsByTagNameNS(A.svg,"stop");k=D.length;if(k<2){for(;k<2;){g.appendChild(document.createElementNS(A.svg,"stop"));++k}D=g.getElementsByTagNameNS(A.svg,"stop")}var L;U=n=0;if(p==="radialGradient"){m=g.gradientTransform.baseVal;if(m.numberOfItems===2){k=m.getItem(0);m=m.getItem(1);if(k.type===2&&m.type===3){k=m.matrix;if(k.a!==1)n=Math.round(-(1-k.a)*100);else if(k.d!==
1)n=Math.round((1-k.d)*100)}}else if(m.numberOfItems===3){x=m.getItem(0);k=m.getItem(1);m=m.getItem(2);if(x.type===4&&k.type===2&&m.type===3){U=Math.round(x.angle);k=m.matrix;if(k.a!==1)n=Math.round(-(1-k.a)*100);else if(k.d!==1)n=Math.round((1-k.d)*100)}}}n={radius:{handle:"#"+b+"_jGraduate_RadiusArrows",input:"#"+b+"_jGraduate_RadiusInput",val:(g.getAttribute("r")||0.5)*100},opacity:{handle:"#"+b+"_jGraduate_OpacArrows",input:"#"+b+"_jGraduate_OpacInput",val:e.paint.alpha||100},ellip:{handle:"#"+
b+"_jGraduate_EllipArrows",input:"#"+b+"_jGraduate_EllipInput",val:n},angle:{handle:"#"+b+"_jGraduate_AngleArrows",input:"#"+b+"_jGraduate_AngleInput",val:U}};$.each(n,function(c,a){var d=$(a.handle);d.mousedown(function(h){var f=d.parent();L={type:c,elem:d,input:$(a.input),parent:f,offset:f.offset()};N.mousemove(za).mouseup(Aa);h.preventDefault()});$(a.input).val(a.val).change(function(){var h=+this.value,f=0,l=p==="radialGradient";switch(c){case "radius":l&&g.setAttribute("r",h/100);f=Math.pow(h/
100,0.4)/2*145;break;case "opacity":e.paint.alpha=h;aa.setAttribute("fill-opacity",h/100);f=h*1.45;break;case "ellip":J=G=1;if(h===0){f=72.5;break}if(h>99.5)h=99.5;if(h>0)G=1-h/100;else J=-(h/100)-1;f=145*((h+100)/2)/100;l&&w();break;case "angle":T=h;f=T/180;f+=0.5;f*=145;l&&w()}if(f>145)f=145;else if(f<0)f=0;d.css({"margin-left":f-5})}).change()});var za=function(c){var a=c.pageX-L.offset.left-parseInt(L.parent.css("border-left-width"));if(a>145)a=145;if(a<=0)a=0;var d=a-5;a/=145;switch(L.type){case "radius":a=
Math.pow(a*2,2.5);if(a>0.98&&a<1.02)a=1;if(a<=0.01)a=0.01;g.setAttribute("r",a);break;case "opacity":e.paint.alpha=parseInt(a*100);aa.setAttribute("fill-opacity",a);break;case "ellip":G=J=1;if(a<0.5){a/=0.5;J=a<=0?0.01:a}else if(a>0.5){a/=0.5;a=2-a;G=a<=0?0.01:a}w();a-=1;if(G===a+1)a=Math.abs(a);break;case "angle":a-=0.5;T=a*=180;w();a/=100}L.elem.css({"margin-left":d});a=Math.round(a*100);L.input.val(a);c.preventDefault()},Aa=function(){N.unbind("mousemove",za).unbind("mouseup",Aa);L=null};for(n=
(e.paint.alpha*255/100).toString(16);n.length<2;)n="0"+n;n=n.split(".")[0];u=e.paint.solidColor=="none"?"":e.paint.solidColor+n;ba||(u=D[0].getAttribute("stop-color"));$.extend($.fn.jPicker.defaults.window,{alphaSupport:true,effects:{type:"show",speed:0}});Ca.jPicker({window:{title:o.window.pickerTitle},images:{clientPath:o.images.clientPath},color:{active:u,alphaSupport:true}},function(c){e.paint.type="solidColor";e.paint.alpha=c.val("ahex")?Math.round(c.val("a")/255*100):100;e.paint.solidColor=
c.val("hex")?c.val("hex"):"none";e.paint.radialGradient=null;ma()},null,function(){na()});var ka=$(s+" .jGraduate_tabs li");ka.click(function(){ka.removeClass("jGraduate_tab_current");$(this).addClass("jGraduate_tab_current");$(s+" > div").hide();var c=$(this).attr("data-type");$(s+" .jGraduate_gradPick").show();if(c==="rg"||c==="lg"){$(".jGraduate_"+c+"_field").show();$(".jGraduate_"+(c==="lg"?"rg":"lg")+"_field").hide();$("#"+b+"_jgraduate_rect")[0].setAttribute("fill","url(#"+b+"_"+c+"_jgraduate_grad)");
p=c==="lg"?"linearGradient":"radialGradient";$("#"+b+"_jGraduate_OpacInput").val(e.paint.alpha).change();var a=$("#"+b+"_"+c+"_jgraduate_grad")[0];if(g!==a){var d=$(g).find("stop");$(a).empty().append(d);g=a;a=ua.val();g.setAttribute("spreadMethod",a)}E=c==="rg"&&g.getAttribute("fx")!=null&&!(ca==qa&&da==ra);$("#"+b+"_jGraduate_focusCoord").toggle(E);if(E)$("#"+b+"_jGraduate_match_ctr")[0].checked=false}else{$(s+" .jGraduate_gradPick").hide();$(s+" .jGraduate_colPick").show()}});$(s+" > div").hide();
ka.removeClass("jGraduate_tab_current");var ea;switch(e.paint.type){case "linearGradient":ea=$(s+" .jGraduate_tab_lingrad");break;case "radialGradient":ea=$(s+" .jGraduate_tab_radgrad");break;default:ea=$(s+" .jGraduate_tab_color")}e.show();setTimeout(function(){ea.addClass("jGraduate_tab_current").click()},10)}else alert("Container element must have an id attribute to maintain unique id strings for sub-elements.")})}})();