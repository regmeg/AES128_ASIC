 var tables = document.getElementsByTagName("TABLE");
var table, newRow, celltxt, classtype, lnktxt, relAtt, newCell, alignTxt, styleTxt, newElement, childCell, tmp, hrefLnk, show_excl_button = 0;
var t = 0, lastRowOdd = 0;
var cellClass      = ["odd",   "even"];
var cellClassRight = ["odd_r", "even_r"];
try {
	window.onload = function(){ 
		try {
			$('#ucdb2html_detail').hide();
			$('#ucdb2html_detail').fadeIn(100);
		} catch (err){;}
	};
} catch (err) {;}

if (tables[0].className.match('buttons')) {
	// ignore the 1st table which is the table for show/hide buttons
	t = 1;
}

/////////////////////////////////////////////////////////////////////////////////////
/* creats cell and add it to row.*/
function createCell(row, type, classt, span, txt, lnk, spanTag, relAttribute, filterLabel, c_align, styleColor) {
	newCell = document.createElement(type);
	if (classt) {
		newCell.className = classt;
	}
	if (span > 1) {
		newCell.colSpan = span;
	}
	if (c_align) {
		newCell.align = c_align;
	}
	if (spanTag) {
		newElement = document.createElement('span');
		newElement.style.color = "red";
		newElement.innerHTML = row.getAttribute(spanTag) + ":&nbsp;&nbsp;";
		newCell.appendChild(newElement);
	}
	if (lnk) {
		newElement = document.createElement('a');
		newElement.setAttribute("href", lnk);
		if (relAttribute) {
			newElement.setAttribute("rel", relAttribute);
		}
		newElement.innerHTML = txt;
		newCell.appendChild(newElement);
	} else {
		newCell.innerHTML = txt;
	}
	if (filterLabel) {
		newCell.innerHTML = newCell.innerHTML + '&nbsp;';
		newElement = document.createElement('font');
		newElement.color = "#006699";
		newElement.innerHTML = "(Filtering Active)";
		newCell.appendChild(newElement);
	}
	if (styleColor) {
		newCell.style.color = styleColor;
	}
	
	row.appendChild(newCell);
	return;
};

/////////////////////////////////////////////////////////////////////////////////////
for (; t < tables.length; t++) {
	var grey = 0;
	table = tables[t];
	table.cellspacing = "2";
	table.cellpadding = "2";
	
	newRow = table.rows[0];
	
	tmp = newRow.getAttribute('ch'); // ch is coverHead
	if (tmp) {
		celltxt = tmp + ' ';
	} else {
		celltxt = "";
	}
	lnktxt = newRow.getAttribute('lnk');
	name = newRow.getAttribute('z');
	if (name) {
		if (name.match(/^<.*>$/)) {
			celltxt = name.replace(">","&gt;").replace("<","&lt;");				
		} else {
			celltxt = name;
		}
	}
	createCell(newRow, "TD", 0, 4, celltxt, lnktxt, 'l', 0, 0, 0, 0);
	
	tmp = newRow.getAttribute('c');
	switch (tmp) {
		case 'R':
			classtype = 'bgRed'; 			 						break;
		case 'Y':
			classtype = 'bgYellow'; 								break;
		case 'G':
			classtype = 'bgGreen'; 		 						break;
		case 'e':
			classtype = 'grey';  grey = 1; show_excl_button = 1;  break;
		default:
			classtype = ''; 				 						break;
	}
	if (grey == 0) {
		celltxt = newRow.getAttribute('p') + "%";
	} else {
		celltxt = 'Excluded';
		newRow.className = 'excluded';
	}
	createCell(newRow, "TD", classtype, 0, celltxt, 0, 0, 0, 0, 0, 0);
	
	newRow = table.rows[1];
	
	createCell(newRow, "TH", 'even', 2, 'Branch', 0, 0, 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0, 'Source', 0, 0, 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0, 'Hits', 0, 0, 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0, 'Status', 0, 0, 0, 0, 0, 0);
	
	lastRowOdd = 0;
	for (var r = 2; r < table.rows.length; r++) {
		var excluded = 0;
		newRow = table.rows[r];
		// row class if existing
		tmp = newRow.getAttribute('cr');
		switch (tmp) {
			case 'c':
				newRow.className = 'covered'; break;
			case 'm':
				newRow.className = 'missing'; break;
			case 'e': //excluded
				excluded = 1; newRow.className = 'excluded'; show_excl_button = 1; break;
			default:
				newRow.className = ''; break;
		}
		classtype = 'invisible';
		celltxt = '&nbsp;';
		createCell(newRow, "TD", classtype, 0, celltxt, 0, 0, 0, 0, 0, 0);
		
		// t is branch type
		tmp = newRow.getAttribute('t');
		switch (tmp) {
			case 'I':
				celltxt = "IF"; break;
			case 'E':
				celltxt = "ELSE"; break;
			case 'T':
				celltxt = "TRUE"; break;
			case 'F':
				celltxt = "FALSE"; break;
			case 'A':
				celltxt = "ALL FALSE"; break;
			default:
				celltxt = "&nbsp;"; break;
		}
		createCell(newRow, "TD", cellClass[lastRowOdd], 0, celltxt, 0, 0, 0, 0, 0, 0);
		
		lnktxt = newRow.getAttribute('lnk');
		name = newRow.getAttribute('z');
		if (name) {
			if (name.match(/^<.*>$/)) {
				celltxt = name.replace(">","&gt;").replace("<","&lt;");				
			} else {
				celltxt = name;
			}
		}
		createCell(newRow, "TD", cellClass[lastRowOdd], 0, celltxt, 0, 'l', 0, 0, 0, 0);
		
		tmp = newRow.getAttribute('h');
		if (tmp) {
			classtype = cellClassRight[lastRowOdd];
			if (newRow.getAttribute('k')) {
				newElement = document.createElement('a');
				hrefLnk = newRow.getAttribute('k').match(/^([^$]*)\$([^$]*)$/i);
				if (hrefLnk && hrefLnk.length == 3) {
					lnktxt = "pertest.htm?bin=b" + hrefLnk[1] + "&scope=" + hrefLnk[2];
				} else {
					lnktxt = newRow.getAttribute('k');
				}
				relAtt = 'popup 200 200';
			} else {
				relAtt = 0;
				lnktxt = 0;
			}
			celltxt = tmp;
			alignTxt = 0;
		} else {
			classtype = cellClass[lastRowOdd];
			alignTxt = "center";
			celltxt = "--";
		}
		if (excluded) {
			styleTxt = "dimGrey";
		}
		createCell(newRow, "TD", classtype, 0, celltxt, 0, 0, 0, 0, alignTxt, styleTxt);
		
		if (excluded == 0) {
			tmp = newRow.getAttribute('c');
			switch (tmp) {
				case 'g':
					classtype = 'green'; celltxt = 'Covered'; break;
				case 'r':
					classtype = 'red'; celltxt = 'ZERO'; break;
				default:
					classtype = ''; break;
			}
		} else {
			classtype = 'grey'; celltxt = 'Excluded';
		}
		createCell(newRow, "TD", classtype, 0, celltxt, 0, 0, 0, 0, 0, 0);
		
		lastRowOdd = lastRowOdd ? 0 : 1;
	}
}
if (show_excl_button == 1) {
	if (tables[0].className.match('buttons')) {
		newCell = document.createElement('TD');
		newCell.id = "showExcl";
		newCell.width = 106;
		newCell.setAttribute("onclick", "showExcl()");
		newCell.className = "button_off";
		newCell.title = "Display only excluded scopes and bins.";
		newCell.innerHTML = "Show Excluded";
		tables[0].rows[0].appendChild(newCell);
	}
}
