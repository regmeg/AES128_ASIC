var tables = document.getElementsByTagName("TABLE");
var table, classtype, lnktxt, relAtt, celltxt, newRow, newCell, newElement, tmp, tmp2, hrefLnk, show_excl_button = 0;
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
/////////////////////////////////////////////////////////////////////////////////////
/* creats cell and add it to row.*/
function createCell(row, type, classt, span, txt, lnk, relAttribute, filterLabel, c_align) {
	newCell = document.createElement(type);
	newCell.className = classt;
	if (span > 1) {
		newCell.colSpan = span;
	}
	if (c_align) {
		newCell.align = c_align;
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
	
	row.appendChild(newCell);
	return;
};

function createAssertCell(row, tableCellType, countType, type, h_number, isexcluded) {
	// newCell
	tmp = newRow.getAttribute(countType);
	if (tmp) {
		switch (tmp) {
			case 'Gr':
				classtype = 'bgGreen_r'; break;
			case 'Rr':
				classtype = 'bgRed_r'; break;
			case 'er':
				classtype = cellClassRight[lastRowOdd];
				break;
			case 'or':
				classtype = cellClassRight[lastRowOdd];
				break;
			default:
				classtype = ''; break;
		}
		tmp = newRow.getAttribute(type);
		if (tmp) {
			hrefLnk = tmp.match(/^([^$]*)\$([^$]*)$/i);
			if (hrefLnk && hrefLnk.length == 3) {
				lnktxt = "pertest.htm?bin=a" + hrefLnk[1] + "&scope=" + hrefLnk[2];
			} else {
				lnktxt = tmp;
			}
			relAtt = 'popup 200 200';
		} else {
			lnktxt = 0;
			relAtt = 0;
		}
		celltxt = newRow.getAttribute('h' + h_number);
	} else {
		classtype = cellClassRight[lastRowOdd];
		celltxt = '-';
	}
	if (isexcluded) {
		// if excluded override the class name
		classtype = cellClassRGrey[lastRowOdd];
	}
	createCell(row, tableCellType, classtype, 0, celltxt, lnktxt, relAtt, 0, 0);	
};

function createNormalAssertCell(row, tableCellType, countType, h_number, isexcluded) {
	// newCell
	classtype = cellClassRight[lastRowOdd];

	tmp2 = newRow.getAttribute('h' + h_number);
	if (tmp2) {
		tmp = newRow.getAttribute(countType);
		if (tmp) {
			newElement = document.createElement('a');
			hrefLnk = tmp.match(/^([^$]*)\$([^$]*)$/i);
			if (hrefLnk && hrefLnk.length == 3) {
				lnktxt = "pertest.htm?bin=a" + hrefLnk[1] + "&scope=" + hrefLnk[2];
			} else {
				lnktxt = tmp;
			}
			relAtt = 'popup 200 200';
		} else {
			lnktxt = 0;
			relAtt = 0;
		}
		celltxt = tmp2; // newRow.getAttribute('h3')
	} else {
		celltxt = '-';
	}
	if (excluded) {
		// if excluded override the class name
		classtype = cellClassRGrey[lastRowOdd];
	}
	createCell(row, tableCellType, classtype, 0, celltxt, lnktxt, relAtt, 0, 0);
};
/////////////////////////////////////////////////////////////////////////////////////
for (; t < tables.length; t++) {
	table = tables[t];
	table.cellspacing = "2";
	table.cellpadding = "2";
	
	newRow = table.rows[0];
	
	createCell(newRow, "TH", 'even', 0,   'Assertions', 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0,        'Failure Count', 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0,        'Pass Count', 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0,    'Attempt Count', 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0,     'Vacuous Count', 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0,    'Disable Count', 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0,      'Active Count', 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0, 'Peak Active Count', 0, 0, 0, 0);
	createCell(newRow, "TH", 'even', 0,      'Status', 0, 0, 0, 0);

	lastRowOdd = 0;	
	// loop on the rest of the rows	
	for (var r = 1; r < table.rows.length; r++) {
		var excluded = 0;
		newRow = table.rows[r];

		// row class if existing
		tmp = newRow.getAttribute('cr');
		switch (tmp) {
			case 'c':
				newRow.className = 'covered'; break;
			case 'm':
				newRow.className = 'missing'; break;
			case 'e':
				newRow.className = 'excluded'; excluded = 1; show_excl_button = 1; break;
			default:
				newRow.className = ''; break;
		}
		
		classtype = cellClass[lastRowOdd];
		lnktxt = newRow.getAttribute('lnk');
		
		name = newRow.getAttribute('z');
		if (name) {
			if (name.match(/^<.*>$/)) {
				celltxt = name.replace(">","&gt;").replace("<","&lt;");				
			} else {
				celltxt = name;
			}
		}
		createCell(newRow, "TD", classtype, 0, celltxt, lnktxt, 0, 0, 0);
		
		createAssertCell(newRow, "TD", 'fc', 'F', 1, excluded);
		createAssertCell(newRow, "TD", 'pc', 'P', 2, excluded);		

		createNormalAssertCell(newRow, "TD", 'At', 3, excluded);
		createNormalAssertCell(newRow, "TD",  'V', 4, excluded);
		createNormalAssertCell(newRow, "TD",  'D', 5, excluded);
		createNormalAssertCell(newRow, "TD",  'A', 6, excluded);
		createNormalAssertCell(newRow, "TD", 'PA', 7, excluded);
		
		if (excluded == 0) {
			tmp = newRow.getAttribute('c');
			switch (tmp) {
				case 'F':
					classtype = 'red';   celltxt = "Failed"; break;
				case 'Z':
					classtype = 'red';   celltxt = "ZERO"; break;
				case 'g':
					classtype = 'green'; celltxt = "Covered"; break;
				default:
					classtype = ''; break;
			}
		} else {
			classtype = 'grey'; celltxt = "Excluded";
		}
		createCell(newRow, "TD", classtype, 0, celltxt, 0, 0, 0, 0);

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
