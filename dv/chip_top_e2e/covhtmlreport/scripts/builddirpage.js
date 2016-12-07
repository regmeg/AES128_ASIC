var tables = document.getElementsByTagName("TABLE");
var table, newRow, newCell, newElement, classtype, lnktxt, relAtt, celltxt, styleTxt, alignTxt, tmp, hrefLnk, show_excl_button = 0;
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
	if (styleColor) {
		newCell.style.color = styleColor;
	}
	
	row.appendChild(newCell);
	return;
};
//////////////////////////////////////////////////////////////////////////////////////////
for (; t < tables.length; t++) {
	table = tables[t];
	table.cellspacing = "2";
	table.cellpadding = "2";
	
	newRow = table.rows[0];
	
	createCell(newRow, 'TH', 'even', 0, 'Cover Directive', 0, 0, 'left', 0);
	createCell(newRow, 'TH', 'even', 0, 'Hits', 0, 0, 0, 0);
	createCell(newRow, 'TH', 'even', 0, 'Status', 0, 0, 0, 0);

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
			case 'n':
				newRow.className = 'neutral'; break;
			case 'e': //excluded
				excluded = 1; newRow.className = 'excluded'; show_excl_button = 1; break;	
			default:
				newRow.className = ''; break;
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
		createCell(newRow, 'TD', cellClass[lastRowOdd], 0, celltxt, lnktxt, 0, 0, 0);
		
		tmp = newRow.getAttribute('h');
		if (tmp) {
			if (newRow.getAttribute('k')) {
				hrefLnk = newRow.getAttribute('k').match(/^([^$]*)\$([^$]*)$/i);
				if (hrefLnk && hrefLnk.length == 3) {
					lnktxt = "pertest.htm?bin=d" + hrefLnk[1] + "&scope=" + hrefLnk[2];
				} else {
					lnktxt = newRow.getAttribute('k');
				}
				relAtt = 'popup 200 200';
			} else {
				lnktxt = relAtt = 0;
			}
			celltxt = tmp;
			createCell(newRow, 'TD', cellClassRight[lastRowOdd], 0, celltxt, lnktxt, relAtt, 0, excluded ? "dimGrey" : 0);

			if (excluded == 0) {
				tmp = newRow.getAttribute('c');
				switch (tmp) {
					case 'r':
						classtype = 'red';   celltxt = "ZERO"; break;
					case 'g':
						classtype = 'green'; celltxt = "Covered"; break;
					default:
						classtype = ''; break;
				}
			} else {
				classtype = 'grey'; celltxt = 'Excluded';
			}
			alignTxt = styleTxt = 0;
		} else {
			createCell(newRow, 'TD', cellClass[lastRowOdd], 0, "--", 0, 0, "center", excluded ? "dimGrey" : 0);

			classtype = cellClass[lastRowOdd];
			alignTxt = "center";
			celltxt = "--";
			if (excluded) {
				styleTxt = "dimGrey";
			} else {
				styleTxt = 0;
			}
		}
		createCell(newRow, 'TD', classtype, 0, celltxt, 0, 0, alignTxt, styleTxt);
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
