var tables = document.getElementsByTagName("TABLE");
var table, celltxt, preTxt, classtype, lnktxt, relAtt, alignTxt, newRow, newCell, newElement, tmp, hrefLnk, lastClassOdd, exFec, show_excl_button = 0;
var t = 0;

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
function createCell(row, type, classt, cspan, rspan, txt, preTxtVal, lnk, relAttribute, c_align, wid) {
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
	if (wid) {
		newCell.width = wid;
	}
	if (lnk) {
		if (preTxtVal) {
			newCell.innerHTML = preTxtVal;
		}
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
	var excluded_row = 0;
	table = tables[t];
	table.cellspacing = "2";
	table.cellpadding = "2";
	
	newRow = table.rows[0];
	
	tmp = newRow.getAttribute('x'); // x for text
	switch (tmp) {
		case 'FC':
			celltxt = 'FEC Condition:&nbsp;';  break;
		case 'FE':
			celltxt = 'FEC Expression:&nbsp;'; break;
		case 'UC':
			celltxt = 'UDP Condition:&nbsp;';  break;
		case 'UE':
			celltxt = 'UDP Expression:&nbsp;'; break;
		default:
			celltxt = '[Oops...]:&nbsp;';      break;
	}

	tmp = newRow.getAttribute('lnk');
	if (tmp) {
		lnktxt = tmp;
		preTxt = celltxt;
		name = newRow.getAttribute('z');
		if (name) {
			if (name.match(/^<.*>$/)) {
				celltxt = name.replace(">","&gt;").replace("<","&lt;");				
			} else {
				celltxt = name;
			}
		}
	} else {
		preTxt = 0;
		celltxt = celltxt + newRow.getAttribute('z');
	}
	createCell(newRow, 'TH', 0, newRow.getAttribute('s'), 0, celltxt, preTxt, lnktxt, 0, 'left', 0);
	
	tmp = newRow.getAttribute('c');
	switch (tmp) {
		case 'R':
			classtype = 'bgRed'; break;
		case 'Y':
			classtype = 'bgYellow'; break;
		case 'G':
			classtype = 'bgGreen'; break;
		case 'e':
			classtype = 'grey'; excluded_row = 1 ; show_excl_button = 1; break;
		default:
			classtype = ''; break;
	}
	if (!excluded_row) {
		celltxt = newRow.getAttribute('p') + "%";
	} else {
		celltxt = "Excluded";
		newRow.cells[0].className = 'grey';
	}
	createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0, 0);

	tmp = newRow.getAttribute('F'); // F is FEC 
	exFec = tmp;
	if (tmp) {
		/**************************************************************************/
		newRow = table.rows[1];

		createCell(newRow, 'TH', 'even', tmp, 0,             "Input Term", 0, 0, 0, 0, 0);
		createCell(newRow, 'TH', 'even', tmp, 0,                "Covered", 0, 0, 0, 0, 0);
		createCell(newRow, 'TH', 'even',   0, 0, "Reason For No Coverage", 0, 0, 0, 0, 0);
		createCell(newRow, 'TH', 'even',   0, 0,                   "Hint", 0, 0, 0, 0, 0);
		
		var r = 2;
		for (; r < table.rows.length; r++) {
			var excluded = 0;
			newRow = table.rows[r];
			tmp = newRow.getAttribute('z');
			if (!tmp) {
				break;
			}
			createCell(newRow, 'TD', 'even', exFec, 0, tmp, 0, 0, 0, 'center', 0);
			
			tmp = newRow.getAttribute('c');
			switch (tmp) {
				case 'g':
					classtype = 'green'; celltxt = 'Yes'; break;
				case 'r':
					classtype = 'red'; celltxt = 'No'; break;
				case 'e':
					classtype = 'grey'; excluded = 1; show_excl_button = 1; celltxt = 'Excluded'; newRow.cells[0].className = 'evenGrey'; break;
				default:
					classtype = ''; break;
			}
			createCell(newRow, 'TD', classtype, exFec, 0, celltxt, 0, 0, 0, 'center', 0);
			
			if (!excluded) {
				celltxt = newRow.getAttribute('r'); // r is reason
			}
			createCell(newRow, 'TD', 'even', 0, 0, celltxt, 0, 0, 0, 'center', 0);
			
			if (!excluded) {
				celltxt = newRow.getAttribute('i'); // i is hint
			}
			createCell(newRow, 'TD', 'even', 0, 0, celltxt, 0, 0, 0, 'center', 0);
		}
		newRow = table.rows[r];
		if (exFec == 2) {
			/* extended fec */
			createCell(newRow, 'TH', 'even', 0, 0, "Rows", 0, 0, 0, 0, 0);
			createCell(newRow, 'TH', 'even', 0, 0, "FEC Target", 0, 0, 0, 0, 0);
			createCell(newRow, 'TH', 'even', 0, 0, "Hits (->0)", 0, 0, 0, 0, 0);
			createCell(newRow, 'TH', 'even', 0, 0, "Hits (->1)", 0, 0, 0, 0, 0);
			createCell(newRow, 'TH', 'even', 0, 0, "Matching Input Patterns (->0)", 0, 0, 0, 0, 0);
			createCell(newRow, 'TH', 'even', 0, 0, "Matching Input Patterns (->1)", 0, 0, 0, 0, 0);
			/***************************   end of table head  ***************************************/
			r++;
			for (; r < table.rows.length; r++) {
				var excluded = 0;
				newRow = table.rows[r];

				createCell(newRow, 'TD', 'even', 0, 0, "Row&nbsp;" + newRow.getAttribute('n'), 0, 0, 0, "center", 0);
				createCell(newRow, 'TD', 'even', 0, 0, newRow.getAttribute('z'), 0, 0, 0, "center", 0);
				
				tmp = newRow.getAttribute('h1');
				classtype = 'even';
				if (tmp) {
					if (newRow.getAttribute('k1')) {
						hrefLnk = newRow.getAttribute('k1').match(/^([^$]*)\$([^$]*)$/i);
						if (hrefLnk && hrefLnk.length == 3) {
							lnktxt = "pertest.htm?bin=" + newRow.getAttribute('t') + hrefLnk[1] + "&scope=" + hrefLnk[2];
						} else {
							lnktxt = newRow.getAttribute('k1');
						}
						relAtt = 'popup 200 200';
					} else {
						relAtt = lnktxt = 0;
						if ((tmp == "E-Hit") || (tmp == "E-Miss")) {
							// excluded row
							excluded = 1;
							newRow.cells[0].className = 'evenGrey';
							newRow.cells[1].className = 'evenGrey';
							classtype = 'evenGrey';
						}
					}
					celltxt = tmp;
				} else {
					relAtt = lnktxt = 0;
					celltxt = "&nbsp;-&nbsp;";
				}
				createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, lnktxt, relAtt, "center", 0);
				
				classtype = 'even';
				tmp = newRow.getAttribute('h2');
				if (tmp) {
					if (newRow.getAttribute('k2')) {
						hrefLnk = newRow.getAttribute('k2').match(/^([^$]*)\$([^$]*)$/i);
						if (hrefLnk && hrefLnk.length == 3) {
							lnktxt = "pertest.htm?bin=" + newRow.getAttribute('t') + hrefLnk[1] + "&scope=" + hrefLnk[2];
						} else {
							lnktxt = newRow.getAttribute('k2');
						}
						relAtt = 'popup 200 200';
					} else {
						lnktxt = relAtt = 0;
						if ((tmp == "E-Hit") || (tmp == "E-Miss")) {
							// excluded row
							excluded = 1;
							newRow.cells[0].className = 'evenGrey';
							newRow.cells[1].className = 'evenGrey';
							classtype = 'evenGrey';
						}
					}
					celltxt = tmp;
				} else {
					lnktxt = relAtt = 0;
					celltxt = "&nbsp;-&nbsp;";
				}
				createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, lnktxt, relAtt, "center", 0);
				
				if (!excluded) {
					classtype = 'even';
				} else {
					classtype = 'evenGrey';
				}
				createCell(newRow, 'TD', classtype, 0, 0, "&nbsp;" + newRow.getAttribute('c1') + "&nbsp;", 0, 0, 0, "center", 0);
				
				if (!excluded) {
					classtype = 'even';
				} else {
					classtype = 'evenGrey';
				}
				createCell(newRow, 'TD', classtype, 0, 0, "&nbsp;" + newRow.getAttribute('c2') + "&nbsp;", 0, 0, 0, "center", 0);
			}
		} else {
			/* fec */
			createCell(newRow, 'TH', 'even', 0, 0,                    "Rows", 0, 0, 0, 0, 0);
			createCell(newRow, 'TH', 'even', 0, 0,              "FEC Target", 0, 0, 0, 0, 0);
			createCell(newRow, 'TH', 'even', 0, 0,                    "Hits", 0, 0, 0, 0, 0);
			createCell(newRow, 'TH', 'even', 0, 0, "Matching Input Patterns", 0, 0, 0, 0, 0);
			/***************************   end of table head  ***************************************/
			r++;
			for (; r < table.rows.length; r++) {
				var excluded = 0;
				newRow = table.rows[r];

				createCell(newRow, 'TD', 'even', 0, 0, "Row&nbsp;" + newRow.getAttribute('n'), 0, 0, 0, "center", 0);
				createCell(newRow, 'TD', 'even', 0, 0,               newRow.getAttribute('z'), 0, 0, 0, "center", 0);
				
				classtype = 'even';
				tmp = newRow.getAttribute('h1');
				if (tmp) {
					if (newRow.getAttribute('k1')) {
						hrefLnk = newRow.getAttribute('k1').match(/^([^$]*)\$([^$]*)$/i);
						if (hrefLnk && hrefLnk.length == 3) {
							lnktxt = "pertest.htm?bin=" + newRow.getAttribute('t') + hrefLnk[1] + "&scope=" + hrefLnk[2];
						} else {
							lnktxt = newRow.getAttribute('k1');
						}
						relAtt = 'popup 200 200';
					} else {
						relAtt = lnktxt = 0;
						if ((tmp == "E-Hit") || (tmp == "E-Miss")) {
							// excluded row
							excluded = 1;
							newRow.cells[0].className = 'evenGrey';
							newRow.cells[1].className = 'evenGrey';
							classtype = 'evenGrey';
						}
					}
					celltxt = tmp;
				} else {
					relAtt = lnktxt = 0;
					celltxt = "&nbsp;-&nbsp;";
				}
				createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, lnktxt, relAtt, "center", 0);
				
				if (!excluded) {
					classtype = 'even';
				} else {
					classtype = 'evenGrey';
				}
				createCell(newRow, 'TD', classtype, 0, 0, "&nbsp;" + newRow.getAttribute('c1') + "&nbsp;", 0, 0, 0, "center", 0);
			}
		}
	} else {
		var r = 1;
		lastClassOdd = true; // is true to start the series with 'even'
		for (; r < (table.rows.length) - 1; r++) { // I added the '-1' because the last row is processed outside the loop
			newRow = table.rows[r];
			tmp = newRow.getAttribute('r'); // r is rowspan
			if (!tmp) {
				break;
			}

			if (lastClassOdd)
				classtype = 'even';
			else
				classtype = 'odd';
			
			// commented this line to use the same class for both cells
			//lastClassOdd = !lastClassOdd;
			createCell(newRow, 'TD', classtype, 0, tmp, "&nbsp;", 0, 0, 0, 0, 0);
			
			if (lastClassOdd)
				classtype = 'odd'; // the inverse in intended
			else
				classtype = 'even';
				
			lastClassOdd = !lastClassOdd;
			createCell(newRow, 'TD', classtype, newRow.getAttribute('s'), newRow.getAttribute('z'), 0, 0, 0, 0, 0);
		}
		newRow = table.rows[r];

		createCell(newRow, 'TD', lastClassOdd ? 'even' : 'odd' , 0, '1',   "&nbsp;", 0, 0, 0, 0, 0);
		createCell(newRow, 'TH', lastClassOdd ? 'even' : 'odd' , 0,  0,      "Hits", 0, 0, 0, 0, 0);
		createCell(newRow, 'TH', lastClassOdd ? 'even' : 'odd' , 0,  0,    "Status", 0, 0, 0, 0, 0);
		/***************************   end of table head  ***************************************/
		r++;
		for (; r < table.rows.length; r++) {
			var excluded = 0;
			lastClassOdd = true; // is true to start the series with 'even'
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
				case 'e':
					newRow.className = 'grey'; excluded = 1; show_excl_button = 1; break;
				default:
					newRow.className = ''; break;
			}

			tmp = newRow.getAttribute('U'); // u is Unknown
			if (tmp) {
				createCell(newRow, 'TD', 'odd', newRow.getAttribute('s'),  0, tmp, 0, 0, 0, 'center', '20');
			} else {
				lastClassOdd = !lastClassOdd;
				createCell(newRow, 'TD', lastClassOdd ? 'even' : 'odd' , 0,  0, "Row&nbsp;" + newRow.getAttribute('n'), 0, 0, 0, 'center', '20');
				
				tmp = newRow.getAttribute('o'); // o is loop
				if (tmp) {
					tmp = newRow.getAttribute('z');
					for(i = 0; i < tmp.length; i++) {
						lastClassOdd = !lastClassOdd;
						createCell(newRow, 'TD', lastClassOdd ? 'even' : 'odd' , 0,  0, tmp.charAt(i), 0, 0, 0, 'center', '20');
					}
				} else {
					lastClassOdd = !lastClassOdd;
					createCell(newRow, 'TD', lastClassOdd ? 'even' : 'odd' , 0,  0, newRow.getAttribute('z'), 0, 0, 0, 'center', '20');
				}
			}

			tmp = newRow.getAttribute('cc');
			switch (tmp) {
				case 'o':
					classtype = 'odd_r'; break;
				case 'e':
					classtype = 'even_r'; break;
				default:
					classtype = ''; break;
			}
			tmp = newRow.getAttribute('k1');
			if (tmp) {
				hrefLnk = tmp.match(/^([^$]*)\$([^$]*)$/i);
				if (hrefLnk && hrefLnk.length == 3) {
					lnktxt = "pertest.htm?bin=" + newRow.getAttribute('t') + hrefLnk[1] + "&scope=" + hrefLnk[2];
				} else {
					lnktxt = tmp;
				}
				relAtt = 'popup 200 200';
			} else {
				relAtt = lnktxt = 0;
			}
			createCell(newRow, 'TD', classtype, 0,  0, newRow.getAttribute('h1'), 0, lnktxt, relAtt, 0, 0);
			
			alignTxt = 0;
			if (!excluded) {
				tmp = newRow.getAttribute('c');
				switch (tmp) {
					case 'g':
						classtype = 'green'; celltxt = 'Covered'; break;
					case 'r':
						classtype = 'red'; celltxt = 'ZERO'; break;
					default:
						alignTxt = 'center'; celltxt = '--'; break;
				}
			} else {
				classtype = 'grey'; celltxt = 'Excluded';
			}
			createCell(newRow, 'TD', classtype, 0,  0, celltxt, 0, 0, 0, alignTxt, 0);
		}
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
