
/* AUTHOR:  GHS 3/13/2016
* NOTE: THIS PLUGIN IS INCOMPLETE !!!!!
*
*/

(function ( $ ) {
	'use strict';
//===================================================================	
    $.fn.paginate = function( options ) {
        var opt = $.extend({
            // These are the defaults.
			elementid: "#paginate",
            total: 0,
            perpage: 1,
			display: 5
        }, options );
		
		console.log(this);
		
		var currentpage = 1;
		
		var _qstr = parseQstring();
		console.log(_qstr);
		var cp = getCurrentPage();
		console.log(cp);
		
		
		//render(opt.elementID, _qstr, opt.total, opt.perpage);
    }; // end paginate func
	
	// helper functions
	function parseQstring() {	
		var qStr = window.location.search.substring(1).toLowerCase();
		var qStrArray = qStr.split('&');
		for(var i = 0; i < qStrArray.length; i++){	
			var keyval = qStrArray[i];
			var key = qStrArray[i].split("=")[0];
			if (i === 0) {
					querystring = "?" + keyval;
				} else {
					querystring = querystring +"&"+ keyval;
			}
			
		}	
		return querystring;
	}	// end parseQstring func
	
	
	function getCurrentPage() {	
		var qStr = window.location.search.substring(1).toLowerCase();
		var qStrArray = qStr.split('&');
		var currentpage = 1;
		for(var i = 0; i < qStrArray.length; i++){	
			var keyval = qStrArray[i];
			var key = qStrArray[i].split("=")[0];
			var val = qStrArray[i].split("=")[1];
			if( key === "p" && val.length() ) {
				currentpage = qStrArray[i].split("=")[1];
			}
		}	
		return currentpage
	}	// end getCurrentPage func

	
	function render(id, qstr, total, perpage) {
		var anchor = "";
		var pages = total / perpage;
		var st = 1;
		var p = 1;
			for (i = 0; i < pages; i++) {
				st = i * perpage;
				p = i;
				qstr = qstr + "&p=" p +"&st="+ st;
				/*
				anchor =  window.location.protocol + "//" + window.location.hostname + "/" + window.location.pathname + qstr;
				if (pages > 3) {
					$(id).append("<li class="first"><a href="+ anchor +">First</a></li>");
					if (currentpage === 1) {
						$(id +".first").addClass("disabled");
					}
				}
				if (pages > 3) {
					$(id).append("<li class="last"><a href="#">Last</a></li>");
					if (currentpage >= pages) {
						$(id +".last").addClass("disabled");
					}
				}
				*/
			}
	}// end render func
	
 //====================================================================
}( jQuery ));
 