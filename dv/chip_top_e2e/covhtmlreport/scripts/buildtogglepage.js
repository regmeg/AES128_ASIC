var tables = document.getElementsByTagName("TABLE");
var newCell, childCell, tmp, newRow, preTxt, columnSpan, alignTxt, titleTxt, classtype, lnktxt, relAtt, celltxt, newElement, hrefLnk, show_excl_button = 0;
var lastRowOdd = 0;
var cellClass      = ["odd",   "even"];
var cellClassRight = ["odd_r", "even_r"];
var cellClassGrey = ["oddGrey", "evenGrey"];
var cellClassRGrey = ["odd_rGrey", "even_rGrey"];
try {
	window.onload = function(){ 
		try {
			$('#ucdb2html_detail').hide();
			$('#ucdb2html_detail').fadeIn(100);
		} catch (err){;}
	};
} catch (err) {;}

table = tables[tables.length - 1]; // the table contains the show/hide buttons may or may not exist
//////////////////////////////////////////////////////////////////////////////////////////
function createCell(row, type, classt, rspan, cspan, txt, lnk, relAttribute, c_align, styleColor, titleText, preTxtVal, exTxt) {
	newCell = document.createElement(type);
	if (classt) {
		newCell.className = classt;
	}
	if (cspan > 1) {
		newCell.colSpan = cspan;
	}
	if (rspan > 1) {
		newCell.rowSpan = rspan;
	}
	if (c_align) {
		newCell.align = c_align;
	}
	if (styleColor) {
		newCell.style.color = styleColor;
	}
	if (titleText) {
		newCell.setAttribute("title", titleText);
	}
	if (lnk) {
		newElement = document.createElement('a');
		newElement.setAttribute("href", lnk);
		if (relAttribute) {
			newElement.setAttribute("rel", relAttribute);
		}
		if (titleText) {
			newElement.setAttribute("title", titleText);
		}
		newElement.innerHTML = txt;
		newCell.appendChild(newElement);
		if (preTxtVal) {
			newCell.innerHTML = newCell.innerHTML + preTxtVal;
		}
	} else {
		newCell.innerHTML = txt;
	}
	if (exTxt) {
		newCell.innerHTML = newCell.innerHTML + '&nbsp;' + exTxt;
	}
	row.appendChild(newCell);
	return;
};
function createToggleCell(row, type, toggleCount, h_count, sTxt) {
	tmp = newRow.getAttribute(toggleCount);
	alignTxt = styleTxt = 0;
	if (tmp) {
		classtype = cellClassRight[lastRowOdd];
		hrefLnk = tmp.match(/^([^$]*)\$([^$]*)$/i);
		if (hrefLnk && hrefLnk.length == 3) {
			lnktxt = "pertest.htm?bin=t" + hrefLnk[1] + "&scope=" + hrefLnk[2];
		} else {
			lnktxt = tmp;
		}
		relAtt = 'popup 200 200';
		celltxt = newRow.getAttribute('h1');
	} else {
		var bin_excluded = 0;
		lnktxt = relAtt = 0;
		tmp = newRow.getAttribute(h_count);
		if (tmp) {
			classtype = cellClassRight[lastRowOdd];
			celltxt = tmp;
			if ((tmp == "E-Hit") || (tmp == "E-Miss")) {
				bin_excluded = 1;
			}
		} else {
			classtype = cellClass[lastRowOdd];
			alignTxt = 'center';
			celltxt = '--';
		}
		if (excluded || bin_excluded)
			styleTxt = "dimGrey";
	}
	createCell(row, type, classtype, 0, 0, celltxt, lnktxt, relAtt, alignTxt, styleTxt, 0, 0, sTxt);
	return;
};
//////////////////////////////////////////////////////////////////////////////////////////
// adjust the table attributes
table.cellspacing = "2";
table.cellpadding = "2";

/****************************** Start of row 0 ***********************************/
// create the table header cells and append them
createCell(table.rows[0], 'TH', 'odd', '2', '2', 'Signal / Value', 0, 0, 0, 0, 0, 0, 0);
createCell(table.rows[0], 'TH', 'odd',   0, '6',           'Hits', 0, 0, 0, 0, 0, 0, 0);
createCell(table.rows[0], 'TH', 'odd', '2',   0,        'ExtMode', 0, 0, 0, 0, 0, 0, 0);
createCell(table.rows[0], 'TH', 'odd', '2',   0,         'Status', 0, 0, 0, 0, 0, 0, 0);
/****************************** End of row 0 ***********************************/
createCell(table.rows[1], 'TH', 'even',  0,   0,         '0L->1H', 0, 0, 0, 0, 0, 0, 0);
createCell(table.rows[1], 'TH', 'even',  0,   0,         '1H->0L', 0, 0, 0, 0, 0, 0, 0);
createCell(table.rows[1], 'TH', 'even',  0,   0,          '0L->Z', 0, 0, 0, 0, 0, 0, 0);
createCell(table.rows[1], 'TH', 'even',  0,   0,          'Z->1H', 0, 0, 0, 0, 0, 0, 0);
createCell(table.rows[1], 'TH', 'even',  0,   0,          '1H->Z', 0, 0, 0, 0, 0, 0, 0);
createCell(table.rows[1], 'TH', 'even',  0,   0,          'Z->0L', 0, 0, 0, 0, 0, 0, 0);
/****************************** End of row 1 ***********************************/
lastRowOdd = 0;
// Loop on the rows of the table
for (var r = 2; r < table.rows.length; r++) {
	var excluded = 0;
	newRow = table.rows[r];
	
	tmp = newRow.getAttribute('s');
	if (tmp)
		columnSpan = tmp;
	else 
		columnSpan = 0;
	
	// row class if existing
	tmp = newRow.getAttribute('cr');
	switch (tmp) {
		case 'c':
			newRow.className = 'covered'; break;
		case 'm':
			newRow.className = 'missing'; break;
		case 'n':
			newRow.className = 'neutral'; break;
		case 'e': //excluded
			excluded = 1; newRow.className = 'excluded'; show_excl_button = 1; break;
		default:
			newRow.className = ''; break;
	}

	tmp = newRow.getAttribute('st');
	if (tmp) {
		/* colSpan is 1 */
		/* simple toggle */
		createCell(newRow, 'TD', 'invisible', 0, columnSpan, '&nbsp;', 0, 0, 0, 0, 0, 0, 0);
		
		createCell(newRow, 'TD', (excluded == 1)? cellClassGrey[lastRowOdd] : cellClass[lastRowOdd], 0, 0, newRow.getAttribute('z'), 0, 0, 0, 0, 0, 0, 0);
	} else {
		classtype = cellClass[lastRowOdd];
		tmp = newRow.getAttribute('lnk');
		if (tmp) {
			lnktxt = tmp;
			tmp = newRow.getAttribute('t');
			celltxt = newRow.getAttribute('z');
			if (tmp) {
				// in case there is a text in the cell i.e  [alias]
				titleTxt = tmp;
				preTxt = '&nbsp;[alias]';
			} else {
				preTxt = titleTxt = 0;
			}
		} else {
			preTxt = lnktxt = 0;
			tmp = newRow.getAttribute('t');
			if (tmp) {
				// in case there is a text in the cell i.e  [alias]
				celltxt = newRow.getAttribute('z') + '&nbsp;[alias]';
				titleTxt = tmp;
			} else {
				celltxt = newRow.getAttribute('z');
				titleTxt = 0;
			}		
		}
		if (excluded == 1) {
			classtype = cellClassGrey[lastRowOdd];
		}
		createCell(newRow, 'TD', classtype, 0, columnSpan, celltxt, lnktxt, 0, 0, 0, titleTxt, preTxt, 0);
	}
/////////////////////////////////////////////////////////////////////////////////////////////////		
	if (columnSpan != 9) { /* i.e. columnSpan == 2 or 1 */
		createToggleCell(newRow, 'TD', 'LH', 'h1', 0);
		createToggleCell(newRow, 'TD', 'HL', 'h2', 0);
		createToggleCell(newRow, 'TD', 'LZ', 'h3', newRow.getAttribute('s1'));
		createToggleCell(newRow, 'TD', 'ZH', 'h4', newRow.getAttribute('s2'));
		createToggleCell(newRow, 'TD', 'HZ', 'h5', newRow.getAttribute('s3'));
		createToggleCell(newRow, 'TD', 'ZL', 'h6', newRow.getAttribute('s4'));

		tmp = newRow.getAttribute('em'); // External Mode
		if (tmp) {
			celltxt = tmp;
		} else {
			celltxt = '--';
		}
		if (!newRow.getAttribute('st')) {
			classtype = cellClassRight[lastRowOdd];
		} else {
			classtype = cellClass[lastRowOdd];
		}
		createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, excluded ? "dimGrey" : 0, 0, 0, 0);
	}
	
	if (excluded == 0) {
		tmp = newRow.getAttribute('c');
		switch (tmp) {
			case 'R':
				classtype = 'bgRed';    celltxt = newRow.getAttribute('p') + "%"; break;
			case 'Y':
				classtype = 'bgYellow'; celltxt = newRow.getAttribute('p') + "%"; break;
			case 'G':
				classtype = 'bgGreen';  celltxt = newRow.getAttribute('p') + "%"; break;
			case 'g':
				classtype = 'green';    celltxt = 'Covered'; 						break;
			case 'r':
				classtype = 'red';      celltxt = 'ZERO'; 						break;
			default:
				classtype = ''; break;
		}
	} else {
		classtype = 'grey'; celltxt = 'Excluded';
	}
	createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0, 0, 0, 0);
	/* end of Row */
	lastRowOdd = lastRowOdd ? 0 : 1;
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
