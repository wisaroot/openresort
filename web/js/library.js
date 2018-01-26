/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/* grab the height of the header and footer */
function adjustHeight() {
	document.getElementById('contentWrapper').style.height=(document.body.clientHeight-fixedHeight)+"px";
}

/* setting this here means script off, we get 'normal' behavior */
document.getElementById('container').style.overflow="hidden";

var fixedHeight=
	document.getElementById('header').offsetHeight+
	document.getElementById('footer').offsetHeight+
	1; /* extra px for bottom border */

var v=document.body.offsetHeight; /* fix Safari bug when switching scroll behavior */


/* Trap window resizes */
if (window.addEventListener){ 
	window.addEventListener('resize',adjustHeight,false);
} else if (window.attachEvent){ 
		window.attachEvent("onresize",adjustHeight); 
} else { 
		window.onresize=adjustHeight;
} 

/* Do it once at load */
adjustHeight();


