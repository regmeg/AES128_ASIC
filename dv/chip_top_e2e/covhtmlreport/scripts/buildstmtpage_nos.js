var tables = document.getElementsByTagName("TABLE");
var table, newRow, newCell, newElement, childCell, tmp, hrefLnk, show_excl_button = 0;
var t = 0, newlook = 0, lastRowOdd = 0;
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

try {
	if (undefined != $) {
		newlook = 1;
	}
} catch (err) {;}

if (tables[0].className.match('buttons')) {
	// ignore the 1st table which is the table for show/hide buttons
	t = 1;
}

for (; t < tables.length; t++) {
	table = tables[t];
	table.cellspacing = "2";
	table.cellpadding = "2";
	
	newRow = table.rows[0];
	
	newCell = document.createElement('TH');
	newCell.className = newlook ? 'even' : 'odd';
	newCell.innerHTML = 'Statement';
	newRow.appendChild(newCell);
	
	newCell = document.createElement('TH');
	newCell.className = 'even';
	newCell.innerHTML = 'Hits';
	newRow.appendChild(newCell);
	
	newCell = document.createElement('TH');
	newCell.className = newlook ? 'even' : 'odd';
	newCell.innerHTML = 'Coverage';
	newRow.appendChild(newCell);
	if (newlook) {
		lastRowOdd = 0;
	}
	
	for (var r = 1; r < table.rows.length; r++) {
		var excluded = 0;
		newRow = table.rows[r];
		newCell = document.createElement('TD');	
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
		
		if (!excluded) {
			if (newlook) {
				newCell.className = cellClass[lastRowOdd];
			} else {
				newCell.className = "odd";
			}
		} else {
			if (newlook) {
				newCell.className = cellClassGrey[lastRowOdd];
			} else {
				newCell.className = "oddGrey";
			}
		}
		
		tmp = newRow.getAttribute('lnk');
		if (tmp) {
			newElement = document.createElement('a');
			newElement.setAttribute("href",tmp);
			name = newRow.getAttribute('z');
			if (name) {
				if (name.match(/^<.*>$/)) {
					newElement.innerHTML = name.replace(">","&gt;").replace("<","&lt;");				
				} else {
					newElement.innerHTML = name;
				}
			}
			newCell.appendChild(newElement);
		} else {
			newCell.innerHTML = newRow.getAttribute('z');
		}
		newRow.appendChild(newCell);
		
		newCell = document.createElement('TD');
		tmp = newRow.getAttribute('h');
		if (tmp) {
			if (!excluded) {
				if (newlook) {
					newCell.className = cellClassRight[lastRowOdd];
				} else {
					newCell.className = "even_r";
				}
			} else{
				if (newlook) {
					newCell.className = cellClassRGrey[lastRowOdd];
				} else {
					newCell.className = "even_rGrey";
				}
			}

			newCell.innerHTML = tmp;
		} else {
			if (!excluded) {
				if (newlook) {
					newCell.className = cellClass[lastRowOdd];
				} else {
					newCell.className = "even";
				}
			} else {
				if (newlook) {
					newCell.className = cellClassGrey[lastRowOdd];
				} else {
					newCell.className = "evenGrey";
				}
			}

			newCell.align = "center";
			newCell.innerHTML = "--";
		}
		newRow.appendChild(newCell);
		
		newCell = document.createElement('TD');
		if (!excluded) {
			tmp = newRow.getAttribute('c');
			switch (tmp) {
				case 'g':
					newCell.className = 'green'; newCell.innerHTML = 'Covered'; break;
				case 'r':
					newCell.className = 'red'; newCell.innerHTML = 'ZERO'; break;
				default:
					newCell.className = ''; break;
			}
		} else {
			newCell.className = "grey"; newCell.innerHTML = 'Excluded';
		}
		newRow.appendChild(newCell);
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
