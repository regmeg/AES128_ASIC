var tables = document.getElementsByTagName("TABLE");
var newCreatedCell, newCell, spanval, classtype, lnktxt, relAtt, celltxt, preTxtVal, newRow, newElement, dataInCells, childCell, isCvg, cvg_cvi_table_index, tmp, lastClassOdd, name, binType, show_excl_button = 0;
var createlink = 0;
var lastRowOdd = 0;
var cellClass      = ["odd",   "even"];
var cellClassRight = ["odd_r", "even_r"];
var cellClassRGrey = ["odd_rGrey", "even_rGrey"];
var cellClassGrey  = ["oddGrey", "evenGrey"];
try {
	window.onload = function(){ 
		try {
			$('#ucdb2html_detail').hide();
			$('#ucdb2html_detail').fadeIn(100);
		} catch (err){;}
	};
} catch (err) {;}

// The Covergroups / Instances Table
for (t = 0; t < tables.length; t++) {
	if (tables[t].id && tables[t].id.match(/^cvg\/cvi$/i)) {
		covergroup_instances_table = tables[t];
		cvg_cvi_table_index = t;
		break;
	}
}
/////////////////////////////////////////////////////////////////////////////////////
/* creats cell and add it to row.*/
function createCell(row, type, classt, span, preTxt, txt, lnk, relAttribute, filterLabel, c_align) {
	newCreatedCell = document.createElement(type);
	if (classt) {
		newCreatedCell.className = classt;
	}
	if (span > 1) {
		newCreatedCell.colSpan = span;
	}
	if (c_align) {
		newCreatedCell.align = c_align;
	}
	if (lnk) {
		if (preTxt) {
			newCreatedCell.innerHTML = preTxt;
		}
		newElement = document.createElement('a');
		newElement.setAttribute("href", lnk);
		if (relAttribute) {
			newElement.setAttribute("rel", relAttribute);
		}
		newElement.innerHTML = txt;
		newCreatedCell.appendChild(newElement);
	} else {
		newCreatedCell.innerHTML = txt;
	}
	if (filterLabel) {
		newCreatedCell.innerHTML = newCreatedCell.innerHTML + '&nbsp;';
		newElement = document.createElement('font');
		newElement.color = "#006699";
		newElement.innerHTML = "(Filtering Active)";
		newCreatedCell.appendChild(newElement);
	}
	
	row.appendChild(newCreatedCell);
	return;
};

function createCvgCell(row, srcCell, tableCellType, countType, isexcluded) {
	// newCell
	if (!isexcluded) {
		classtype = cellClassRight[lastRowOdd];
	} else {
		classtype = cellClassRGrey[lastRowOdd];
	}
	tmp = srcCell.getAttribute(countType);
	if (tmp) {
		celltxt = tmp;
		if ((countType == 'g') || (countType == 'p')) {
			celltxt = celltxt + "%";
		}
	} else {
		celltxt = "--";
	}
	createCell(row, tableCellType, classtype, 0, 0, celltxt, 0, 0, 0, 0);
};

function createHitPcntgCell(row, srcCell, tableCellType, totalBinsAttr, coveredBinsAttr, isExcluded) {
	if (!isExcluded) {
		classtype = cellClassRight[lastRowOdd];
	} else {
		classtype = cellClassRGrey[lastRowOdd];
	}
	
	totalBinsVal = srcCell.getAttribute(totalBinsAttr);
	coveredBinsVal = srcCell.getAttribute(coveredBinsAttr);
	if (totalBinsVal && coveredBinsVal) {
		hitPcntg = (coveredBinsVal / totalBinsVal)*100;
		celltxt = hitPcntg.toFixed(2)+"%";
	} else {
		celltxt = "--";
	}
	
	createCell(row, tableCellType, classtype, 0, 0, celltxt, 0, 0, 0, 0);
};
/////////////////////////////////////////////////////////////////////////////////////
// adjust the table attributes
covergroup_instances_table.cellspacing = "2";
covergroup_instances_table.cellpadding = "2";

// create the table header cells and append them
if (pa_scope) {
	celltxt = 'States / Transitions';
} else {
	celltxt = 'Covergroups / Instances';
}
createCell(covergroup_instances_table.rows[0], 'TH', 'even', 2, 0,        celltxt, 0, 0, 0, 'left');
createCell(covergroup_instances_table.rows[0], 'TH', 'even', 0, 0,   'Total Bins', 0, 0, 0, 0);
createCell(covergroup_instances_table.rows[0], 'TH', 'even', 0, 0, 'Covered Bins (Hits)', 0, 0, 0, 0);
createCell(covergroup_instances_table.rows[0], 'TH', 'even', 0, 0,        '% Hit', 0, 0, 0, 0);
createCell(covergroup_instances_table.rows[0], 'TH', 'even', 0, 0,         'Goal', 0, 0, 0, 0);
createCell(covergroup_instances_table.rows[0], 'TH', 'even', 0, 0,     'Coverage', 0, 0, 0, 0);
createCell(covergroup_instances_table.rows[0], 'TH', 'even', 0, 0,    '% of Goal', 0, 0, 0, 0);
/**************************************************************************************************/
lastRowOdd = 0;
// Create The Covergroups / Instances Table Index Rows
for (var r = 1; r < covergroup_instances_table.rows.length; r++) {
	var excluded = 0;
	newRow = covergroup_instances_table.rows[r];
	newCell = newRow.cells[0];
	if (!newCell) continue;
	// row class if existing
	tmp = newRow.getAttribute('c');
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
	if (newCell.getAttribute('lnk') && newCell.getAttribute('lnk').match(/^.*#cvg\d+.*$/i)) { // covergroup
		newCell.className = cellClass[lastRowOdd];
		newCell.colSpan = '2';
		isCvg = 1;
	} else { // coverinstance
		newCell.className = 'invisible';
		newCell.innerHTML = '&nbsp;';
		newCell = newRow.cells[1];
		newCell.className = cellClass[lastRowOdd];
		isCvg = 0;
	}
	if (excluded) {
		newCell.className = cellClassGrey[lastRowOdd];
	}
	newElement = document.createElement('a');
	newElement.setAttribute("href",newCell.getAttribute('lnk'));

	name = newCell.getAttribute('z');
	if (name) {
		if (name.match(/^<.*>$/)) {
			newElement.innerHTML = name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;");				
		} else {
			newElement.innerHTML = name.replace("&","&amp;");
		}
	}
	
	if (newCell.childNodes.length > 0) {
		// in case there is a <DIV> element which means there is options table
		newCell.insertBefore(newElement,newCell.childNodes[0]);
	} else {
		newCell.appendChild(newElement);
	}
	if(!pa_scope){
		if (isCvg == 1) { /* Covergroup */
			newCell.innerHTML = 'Covergroup ' + newCell.innerHTML;
		} else /* Instance */{
			newCell.innerHTML = 'Instance ' + newCell.innerHTML;
		}
	}
	
	// Cell for 'tb' Total Bins
	createCvgCell(newRow, newCell, 'TD', 'tb', excluded);
	// Cell for 'cb' Covered Bins
	createCvgCell(newRow, newCell, 'TD', 'cb', excluded);
	// Cell for '% Hit'
	createHitPcntgCell(newRow, newCell, 'TD', 'tb', 'cb', excluded);
	// Cell for 'g' Goal
	createCvgCell(newRow, newCell, 'TD',  'g', excluded);
	// Cell for 'p' coverage percentage
	createCvgCell(newRow, newCell, 'TD',  'p', excluded);
	
	// Cell for 'pg' % of Goal and 'c' coverage color
	if (!excluded) {
		tmp = newCell.getAttribute("c");
		switch (tmp) {
			case 'Y': {
				classtype = 'bgYellow'; break;
			}
			case 'R': {
				classtype = 'bgRed'; break;
			}
			case 'G': {
				classtype = 'bgGreen'; break;
			}
			default: {
				classtype = 0; break;
			}
		}
		celltxt = newCell.getAttribute('pg') + "%";
	} else {
		classtype = 'grey';
		celltxt = "Excluded";
	}
	createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
	lastRowOdd = lastRowOdd ? 0 : 1;
}
// End of The Covergroups / Instances Table Index Rows

/**************************************************************************************************/
// The Covergroups / Instances Tables
for (t = cvg_cvi_table_index + 1; t < tables.length; t++) {
	if (tables[t].getAttribute('t') && tables[t].getAttribute('t').match(/^gi$/i)) {
		covergroup_instances_table = tables[t];

		// process this details table
		// adjust the table attributes
		covergroup_instances_table.cellpadding = "2";
		covergroup_instances_table.cellspacing = "2";
		
		// row 0 contains 2 cells, cell 1: the item name, cell 2: the coverage percentage
		newRow = covergroup_instances_table.rows[0];
		tmp = newRow.getAttribute('t');
		if(!pa_scope){
			if (tmp) {
				if (tmp.match(/^g$/i))
					celltxt = 'Covergroup type:';
				else if (tmp.match(/^i$/i))
					celltxt = 'Covergroup instance:';
			}
		}
		
		lnktxt = preTxtVal = 0;
		tmp = newRow.getAttribute('lnk');
		if (tmp) {
			lnktxt = tmp;
			name = newRow.getAttribute('z');
			if (name) {	
				preTxtVal = celltxt;
				if (name.match(/^<.*>$/)) {
					celltxt = name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;");				
				} else {
					celltxt = name.replace("&","&amp;");
				}
			}
		} else {
			name = newRow.getAttribute('z');
			if (name) {
				if (name.match(/^<.*>$/)) {
					celltxt = celltxt + name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;");				
				} else {
					celltxt = celltxt + name.replace("&","&amp;");
				}
			}
		}
		createCell(newRow, 'TD', 'odd', binRHS ? '7': '6' , preTxtVal, celltxt, lnktxt, 0, 0, 0);
		/////////////////////////////
		tmp = newRow.getAttribute("cr");
		if (tmp && tmp == "e") {
			// excluded
			// change the class type of the 1st cell in this row
			newRow.cells[0].className = "oddGrey";
			
			createCell(newRow, 'TD', 'odd_rGrey', 0, 0, "--", 0, 0, 0, 0);
			createCell(newRow, 'TD', 'odd_rGrey', 0, 0, "--", 0, 0, 0, 0);
			createCell(newRow, 'TD', 'grey', 0, 0, "Excluded", 0, 0, 0, 0);
		} else {
			createCell(newRow, 'TD', 'odd_r', 0, 0, newRow.getAttribute("g") + "%", 0, 0, 0, 0);
			createCell(newRow, 'TD', 'odd_r', 0, 0, newRow.getAttribute("p") + "%", 0, 0, 0, 0);
			//////////////////////////////
			
			// c = coverage color/class
			tmp = newRow.getAttribute("c");
			switch (tmp) {
				case 'Y': {
					classtype = 'bgYellow'; break;
				}
				case'R': {
					classtype = 'bgRed'; break;
				}
				case 'G': {
					classtype = 'bgGreen'; break;
				}
			}
			// pg = % of Goal
			createCell(newRow, 'TD', classtype, 0, 0, newRow.getAttribute("pg") + '%', 0, 0, 0, 0);
		}
		
		// row 1 has 8 cells, 9 if binRHS
		// cell 1: coverpoint/bin, cell 2: binRHS if true, cell 3: At least
		// cell 4: Total Bins, cell 5: Covered Bins (Hits), cell 6: % Hit
		// cell 7: Goal, cell 8: Coverage, cell 9: % of Goal
		newRow = covergroup_instances_table.rows[1];
		// create the table header cells and append them
		var colNum=1;
		
		colNum++;
		if(pa_scope)
			celltxt = 'Power States / Bins';
		else
			celltxt = 'Coverpoints / Bins';
		createCell(newRow, 'TH', 'even', '2', 0, celltxt, 0, 0, 0, 0);
		
		
		if (binRHS) {
			colNum++;
			createCell(newRow, 'TH', 'even', 0, 0, 'RHS', 0, 0, 0, 0);
		}

		colNum++;
		createCell(newRow, 'TH', 'even', 0, 0, 'At Least', 0, 0, 0, 0);

		colNum++;
		createCell(newRow, 'TH', 'even', 0, 0, 'Total Bins', 0, 0, 0, 0);
		
		colNum++;
		createCell(newRow, 'TH', 'even', 0, 0, 'Covered Bins (Hits)', 0, 0, 0, 0);

		colNum++;
		createCell(newRow, 'TH', 'even', 0, 0, '% Hit', 0, 0, 0, 0);
		
		colNum++;
		createCell(newRow, 'TH', 'even', 0, 0, 'Goal', 0, 0, 0, 0);

		colNum++;
		createCell(newRow, 'TH', 'even', 0, 0, 'Coverage', 0, 0, 0, 0);
		
		colNum++;
		createCell(newRow, 'TH', 'even', 0, 0, '% of Goal', 0, 0, 0, 0);

		lastRowOdd = 0;
		//Loop on the rest of the rows in the table
		for (var r = 2; r < covergroup_instances_table.rows.length; r++) {
			var excluded = 0;
			newRow = covergroup_instances_table.rows[r];
			newCell = newRow.cells[0];
			if (!(newCell.getAttribute('t').match(/^b$/i))) {
				tmp = newRow.getAttribute('c');
				switch (tmp) {
					case 'c': {
						newRow.className = 'covered'; break;
					}
					case 'm': {
						newRow.className = 'missing'; break;
					}
					case 'e': {
						newRow.className = 'excluded'; excluded = 1; show_excl_button = 1; break;
					}
					default: {
						newRow.className = ''; break;
					}
				}
				// coverpoint or cross
				if (excluded == 0) {
					newCell.className = cellClass[lastRowOdd];
				} else {
					newCell.className = cellClassGrey[lastRowOdd];
				}
				lastClassOdd = true;
				newCell.colSpan = '2';
				if (newCell.getAttribute('tplnk')) {
					newElement = document.createElement('a');
					newElement.setAttribute("name",newCell.getAttribute('tplnk'));
					newElement.innerHTML = "";
					if (newCell.childNodes.length > 0) {
						// in case there is a <DIV> element which means there is options table
						newCell.insertBefore(newElement,newCell.childNodes[0]);
					} else {
						newCell.appendChild(newElement);
					}
				}
				
				if (newCell.getAttribute('lnk')){
					newElement = document.createElement('a');
					newElement.setAttribute("href",newCell.getAttribute('lnk'));
					name = newCell.getAttribute('z');
					if (name) {
						if (name.match(/^<.*>$/)) {
							newElement.innerHTML = name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;");
						} else {
							newElement.innerHTML = name.replace("&","&amp;");
						}					
					}

					if (newCell.childNodes.length > 0) {
						// in case there is a <DIV> element which means there is options table
						newCell.insertBefore(newElement,newCell.childNodes[0]);
					} else {
						newCell.appendChild(newElement);
					}
				} else {
					if (newCell.childNodes.length > 0) {
						// in case there is a <DIV> element which means there is options table
						name = newCell.getAttribute('z');
						if (name) {
							if (name.match(/^<.*>$/)) {
								newCell.innerHTML = name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;") + newCell.innerHTML;
							} else {
								newCell.innerHTML = name.replace("&","&amp;") + newCell.innerHTML;
							}
						}
					} else {
						name = newCell.getAttribute('z');
						if (name) {
							if (name.match(/^<.*>$/)) {
								newCell.innerHTML = name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;");
							} else {
								newCell.innerHTML = name.replace("&","&amp;");
							}
						}
					}
				}
				tmp = newCell.getAttribute('t');
				if (tmp) {
					if (tmp.match(/^p$/i)) { //coverpoint
						if(pa_scope)
							newCell.innerHTML = "Power State " + newCell.innerHTML;
						else
							newCell.innerHTML = "Coverpoint: " + newCell.innerHTML;
					} else if (tmp.match(/^c$/i)) { // cross
						newCell.innerHTML = "Cross: " + newCell.innerHTML;
					}
				}
				if (excluded == 0) {
					if (binRHS) {
						tmp = newCell.getAttribute('rhs');

						// rhs Class
						classtype = cellClass[lastRowOdd];
						
						if (tmp)
							celltxt = tmp;
						else
							celltxt = '&nbsp;';
						createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
					}
					
					// Cell for 'al' AtLeast
					tmp = newCell.getAttribute('al');
					// atleast Class
					classtype = cellClass[lastRowOdd];
					
					if (tmp)
						celltxt = tmp;
					else
						celltxt = '&nbsp;';
					createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
	
	
					// Cell for 'tb' Total Bins
					tmp = newCell.getAttribute('tb');
					classtype = cellClass[lastRowOdd];
					if (tmp)
						celltxt = tmp;
					else
						celltxt = '&nbsp;';
					createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
					
					
					// Cell for 'cb' Covered Bins (for cross/coverpoint/... anything other than a bin)
					tmp = newCell.getAttribute('cb');
					classtype = cellClass[lastRowOdd];
					if (tmp) {
						celltxt = tmp;
					} else {
						// Cell for 'h' Hit (for bins)
						tmp = newCell.getAttribute('h');
						if (tmp) {
							celltxt = tmp;
						} else {
							celltxt = '&nbsp;';
						}
					}
					createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
					
					
					// Cell for 'q' % Hit
					tmp = newCell.getAttribute('q');
					classtype = cellClass[lastRowOdd];
					if (tmp)
						celltxt = tmp;
					else
						celltxt = '&nbsp;';
					createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
					
					
					// Cell for 'g' Goal
					tmp = newCell.getAttribute('g');
					// goal Class
					classtype = cellClassRight[lastRowOdd];
					
					if (tmp)
						celltxt = tmp + "%";
					else
						celltxt = '&nbsp;';
					createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
					
					// Cell for 'p' coverage percentage
					tmp = newCell.getAttribute('p');
					if (tmp)
						celltxt = tmp + "%";
					else
						celltxt = '&nbsp;';
					
					// coverage class
					classtype = cellClassRight[lastRowOdd];
					createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
					
					// Cell for 'pg' % of Goal 
					tmp = newCell.getAttribute('pg');
					
					tmp2 = newCell.getAttribute("c");
					switch (tmp2) {
						case 'Y': {
							classtype = 'bgYellow'; break;
						}
						case 'R': {
							classtype = 'bgRed'; break;
						}
						case 'G': {
							classtype = 'bgGreen';
						}
						default: {
							classtype = 0;
						}
					}
					if (tmp)
						celltxt = tmp + "%";
					else
						celltxt = '&nbsp;';
					createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
				} else {
					if (binRHS) {
						// rhs Class
						classtype = cellClassGrey[lastRowOdd];
						createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
					}
					
					// Cell for 'al' AtLeast
					// atleast Class
					classtype = cellClassGrey[lastRowOdd];
					createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
	
					// Cell for 'tb' Total Bins
					classtype = cellClassGrey[lastRowOdd];
					createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
					
					// Cell for 'h' Hit/ or for 'cb' covered bins
					// hit Class
					classtype = cellClassGrey[lastRowOdd];
					createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
					
					// Cell for 'q' Hit %
					classtype = cellClassGrey[lastRowOdd];
					createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
					
					// Cell for 'g' Goal
					// goal Class
					classtype = cellClassRGrey[lastRowOdd];
					createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, 0);
					
					// Cell for 'p' coverage percentage
					// coverage class
					classtype = cellClassRGrey[lastRowOdd];
					createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, 0);
					
					// Cell for 'pg' % of Goal 
					createCell(newRow, 'TD', 'grey', 0, 0, 'Excluded', 0, 0, 0, 0);
				}
			} else /* if (newCell.getAttribute('t').match(/^b$/i)) */{
				// covergroup bin
				tmp = newRow.getAttribute('c');
				switch (tmp) {
					case 'c': {
						newRow.className = 'covered'; break;
					}
					case 'm': {
						newRow.className = 'missing'; break;
					}
					case 'n': {
						newRow.className = 'neutral'; break;
					}
					case 'e': {
						newRow.className = 'excluded'; excluded = 1; show_excl_button = 1; break;
					}
					default: {
						newRow.className = ''; break;
					}
				}
				newCell.className = 'invisible';
				newCell.innerHTML = '&nbsp;';
				
				binType = newCell.getAttribute('bt');
				if (excluded == 0) {
					classtype = cellClass[lastRowOdd];
				} else {
					classtype = cellClassGrey[lastRowOdd];
				}
				lastClassOdd = true;
				name = newCell.getAttribute('z');
				if (name) {
					if (name.match(/^<.*>$/)) {
						celltxt = binType + " " + name.replace("&","&amp;").replace(">","&gt;").replace("<","&lt;");
					} else {
						celltxt = binType + " " + name.replace("&","&amp;");
					}
				}
				createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
				
				if (excluded == 0) {
					if (binRHS) {
						tmp = newCell.getAttribute('rhs');
						// rhs Class
						classtype = cellClass[lastRowOdd];
							
						if (tmp)
							celltxt = tmp;
						else
							celltxt = '&nbsp;';
						createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 'center');
					}
					
					// AtLeast Class
					tmp = newCell.getAttribute('al');
					if (tmp) {
						celltxt = tmp;
						classtype = cellClassRight[lastRowOdd];
					} else {
						celltxt = '--';
						classtype = cellClass[lastRowOdd];
					}
					createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 'center');
				} else {
					if (binRHS) {
						// rhs Class
						classtype = cellClassGrey[lastRowOdd];
						createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 'center');
					}
					
					// AtLeast Class
					classtype = cellClassGrey[lastRowOdd];
					createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, 'center');
				}
				
				// Total Bins
				classtype = cellClass[lastRowOdd];
				createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
				
				// Hit Class AKA count
				tmp = newCell.getAttribute('h');
				if (tmp) {
					if (newCell.getAttribute('lnk')) {
						hrefLnk = newCell.getAttribute('lnk').match(/^([^$]*)\$([^$]*)$/i);
						if (hrefLnk && hrefLnk.length == 3) {
							lnktxt = "pertest.htm?bin=g" + hrefLnk[1] + "&scope=" + hrefLnk[2];
						} else {
							lnktxt = newCell.getAttribute('lnk');
						}
						relAtt = 'popup 200 200';
					} else {
						lnktxt = relAtt = 0;
					}
					celltxt = tmp;
					if (excluded == 0) {
						classtype = cellClassRight[lastRowOdd];
					} else {
						classtype = cellClassRGrey[lastRowOdd];
					}
					
					lastClassOdd = !lastClassOdd;
				} else {
					celltxt = '--';
					lnktxt = relAtt = 0;
					if (excluded == 0) {
						classtype = cellClass[lastRowOdd];
					} else {
						classtype = cellClassGrey[lastRowOdd];
					}
					
					lastClassOdd = !lastClassOdd;
				}
				createCell(newRow, 'TD', classtype, 0, 0, celltxt, lnktxt, relAtt, 0, 'center');
				
				// % Hit
				classtype = cellClass[lastRowOdd];
				createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
				
				// Goal class
				classtype = cellClass[lastRowOdd];
				createCell(newRow, 'TD', classtype, 0, 0, '&nbsp;', 0, 0, 0, 0);
				
				// Coverage
				if (excluded == 0) {
					tmp = newCell.getAttribute('c') 
					switch (tmp) {
						case 'c': {
							celltxt = 'Covered';
							classtype = 'green';
							break;
						}
						case 'u': {
							celltxt = 'Uncovered';
							classtype = 'red';
							break;
						}
						case 'z': {
							celltxt = 'ZERO';
							if (binType != "illegal_bin")
								classtype = 'red';
							else
								classtype = 'green';
							break;
						}
						case 'o': {
							celltxt = 'Occurred';
							if (binType != "illegal_bin")
								classtype = 'green';
							else
								classtype = 'red';
							break;
						}
						default: {
							classtype = 0;
							celltxt = '&nbsp;';
							break;
						}
					}
				} else {
					celltxt = 'Excluded';
					classtype = 'grey';
				}
				createCell(newRow, 'TD', classtype, 0, 0, celltxt, 0, 0, 0, 0);
				lastClassOdd = !lastClassOdd; // call this to adjust the order of odd even classes
				
				// % of Goal class
				classtype = cellClass[lastRowOdd];
				createCell(newRow, 'TD', classtype, 0, 0, '--', 0, 0, 0, 0);
			}
			lastRowOdd = lastRowOdd ? 0 : 1;
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
/**************************************************************************************************/
/* this variable "page_loaded" is needed to be set to 1 to tell the timestamp script that the script
 * buildcvgpage.js finished processing the page */
page_loaded = 1;
