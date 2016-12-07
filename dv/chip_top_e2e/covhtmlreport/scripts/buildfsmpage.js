var tables = document.getElementsByTagName("TABLE");
var table, newRow, columnSpan, alignTxt,newCell, classtype, lnktxt, relAtt, celltxt, newElement, childCell, tmp, hrefLnk, show_excl_button = 0;
var t = 0, lastRowOdd = 0;
var cellClass      = ["odd",   "even"];
var cellClassRight = ["odd_r", "even_r"];
var cellClassRGrey = ["odd_rGrey", "even_rGrey"];
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
//////////////////////////////////////////////////////////////////////////////////////////
function createCell(row, type, classt, span, txt, lnk, relAttribute, c_align, styleColor) {
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
	if (styleColor) {
		newCell.style.color = styleColor;
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
	
	row.appendChild(newCell);
	return;
};
//////////////////////////////////////////////////////////////////////////////////////////
for (; t < tables.length; t++) {
	var grey = 0;
	table = tables[t];
	table.cellspacing = "2";
	table.cellpadding = "2";
	
	newRow = table.rows[0];

	if(!pa_scope){
		celltxt = "FSM: ";
	}
	
	celltxt = newRow.getAttribute('z');
	createCell(newRow, 'TD', 0, "3", celltxt, newRow.getAttribute('lnk'), 0, 0, 0);

	tmp = newRow.getAttribute('c');
	switch (tmp) {
		case 'R':
			classtype = 'bgRed'; break;
		case 'Y':
			classtype = 'bgYellow'; break;
		case 'G':
			classtype = 'bgGreen'; break;
		case 'e':
			classtype = 'grey';  grey = 1; show_excl_button = 1;  break;			
		default:
			classtype = ''; break;
	}
	if (grey == 0) {
		celltxt = newRow.getAttribute('p') + "%";
	} else {
		celltxt = 'Excluded';
		newRow.className = 'excluded';
	}
	createCell(newRow, 'TD', classtype, 0, celltxt, 0, 0, 0, 0);
	
	newRow = table.rows[1];
	
	createCell(newRow, 'TH', 'even', "2", 'States / Transitions', 0, 0, 0, 0);
	createCell(newRow, 'TH', 'even',   0,                 'Hits', 0, 0, 0, 0);
	createCell(newRow, 'TH', 'even',   0,               'Status', 0, 0, 0, 0);

	lastRowOdd = 0;
	// loop on the rest of the rows	
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

		if (newRow.getAttribute('s')) {
			classtype = cellClass[lastRowOdd];
			columnSpan = "2";
			celltxt = 'State: ' + newRow.getAttribute('z');
		} else {
			createCell(newRow, 'TD', 'invisible', 0, '&nbsp;', 0, 0, 0, 0);
			
			classtype = cellClass[lastRowOdd];
			columnSpan = 0;
			celltxt = 'Trans: ' + newRow.getAttribute('z');
		}
		createCell(newRow, 'TD', classtype, columnSpan, celltxt, 0, 0, 0, 0);

		tmp = newRow.getAttribute('h');
		if (tmp) {
			classtype = cellClassRight[lastRowOdd];
			if (newRow.getAttribute('lnk')) {
				hrefLnk = newRow.getAttribute('lnk').match(/^([^$]*)\$([^$]*)$/i);
				if (hrefLnk && hrefLnk.length == 3) {
					lnktxt = "pertest.htm?bin=f" + hrefLnk[1] + "&scope=" + hrefLnk[2];
				} else {
					lnktxt = newRow.getAttribute('lnk');
				}
				relAtt = 'popup 200 200';
			} else {
				lnktxt = relAtt = 0;
			}
			celltxt = tmp;
			alignTxt = 0;
		} else {
			classtype = cellClass[lastRowOdd];
			alignTxt = "center";
			celltxt = "--";
			lnktxt = relAtt = 0;
		}
		createCell(newRow, 'TD', classtype, 0, celltxt, lnktxt, relAtt, alignTxt, excluded ? "dimGrey": 0);

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
		createCell(newRow, 'TD', classtype, 0, celltxt, 0, 0, 0, 0);
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
