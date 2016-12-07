var childrenScopes, newTable, newRow,TitleRow, newCell, newElement, value, cellClass, lastClassOdd, scopeName, localTable, j, tblBody, loc_rec_table, newCellTable, div1, addTable = 0;
var filtering_active = 0;
var newlook = 1, lastRowOdd = 0;
var cellClasses      = ["odd",   "even"];
var cellClassesRight = ["odd_r", "even_r"];
var ListCols = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
/////////////////////////////   Functions  //////////////////////////////////
/* sets "cellClass" value */
function coverageToStyle(val) {
	if (val == "undefined") {
		if (lastClassOdd)
			cellClass = cellClasses[lastRowOdd];
		else
			cellClass = cellClasses[lastRowOdd];

	} else {
		if (val < threshL) cellClass = "bgRed";
		else if (val < threshH) cellClass = "bgYellow";
    	else cellClass = "bgGreen";
	}
	lastClassOdd = !lastClassOdd;
};

/* sets "cellClass" value, when the coverage type is Assertion Failure */
function coverageToStyleAssertionFailure(val) {
	if (val == "undefined") {
		if (lastClassOdd)
			cellClass = cellClasses[lastRowOdd];
		else
			cellClass = cellClasses[lastRowOdd];

	} else {
		if (val == 0.0) cellClass = "bgGreen";
		else cellClass = "bgRed";
	}
	lastClassOdd = !lastClassOdd;
};

/* creats cell and add it to row.*/
function createCell(row, type, classt, span, txt, lnk, filterLabel, c_align) {
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

function createCell_2txt(row, type, classt, span, txt1, txt2) {
	if (type.match("TH")) {
		newCell = document.createElement('TH');
	} else {
		newCell = document.createElement('TD');
	}
	newCell.className = classt;
	if (span > 1) {
		newCell.colSpan = span;
	}
	newCell.innerHTML = txt1;
	newElement = document.createElement('BR');
	newCell.appendChild(newElement);
	newCell.innerHTML = newCell.innerHTML + txt2;
	row.appendChild(newCell);
	return;
};

/* creats cell and add it to row. and adjusts its backgrnd colod based on coverage value */
function addCoverageTypeCell(val, notAssertionFailure) {
	if (val != "undefined") {
		value = val[1] * 100 / val[0] ;
	} else {
		value = val; // which equals "undefined"
	}
	if (notAssertionFailure)
		coverageToStyle(value);
	else
		coverageToStyleAssertionFailure(value);

	if (val != "undefined") {
		createCell(newRow, "TD", cellClass, 0, value.toFixed(2)+"%", 0, 0, 0);
	} else {
		createCell(newRow, "TD", cellClass, 0, "--", 0, 0, "center");
	}
};

/* creats row and add it to the coverage_summary_by_instance table */
function createRow(table, rowName, link, firstCellSpan, filtering_flag) {
	newRow = document.createElement('tr');

	if (firstCellSpan == 2) {
		createCell(newRow, "TD", cellClasses[lastRowOdd], firstCellSpan, rowName, 0, filtering_flag, 0);
	} else {
		createCell(newRow, "TD", 'invisible', 0, '&nbsp;', 0, 0, 0);
		createCell(newRow, "TD", cellClasses[lastRowOdd], 0, rowName, link, 0, 0);
	}
	lastClassOdd = true;
	coverageToStyle(w);
		createCell(newRow, "TD", cellClass, 0, w+"%", 0, 0, 0);

	if(ListCols[0] == 0) {
		try {
			if (typeof g != "undefined") {
				addCoverageTypeCell(g, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[1] == 0) {
		try {
			if (typeof d != "undefined") {
				addCoverageTypeCell(d, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[2] == 0) {
		try {
			if (typeof s != "undefined") {
				addCoverageTypeCell(s, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[3] == 0) {
		try {
			if (typeof b != "undefined") {
				addCoverageTypeCell(b, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[4] == 0) {
		try {
			if (typeof ue != "undefined") {
				addCoverageTypeCell(ue, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[5] == 0) {
		try {
			if (typeof uc != "undefined") {
				addCoverageTypeCell(uc, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[6] == 0) {
		try {
			if (typeof fe != "undefined") {
				addCoverageTypeCell(fe, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[7] == 0) {
		try {
			if (typeof fc != "undefined") {
				addCoverageTypeCell(fc, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[8] == 0) {
		try {
			if (typeof t != "undefined") {
				addCoverageTypeCell(t, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[9] == 0) {
		try {
			if (typeof fs != "undefined") {
				addCoverageTypeCell(fs, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[10] == 0) {
		try {
			if (typeof ft != "undefined") {
				addCoverageTypeCell(ft, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[11] == 0) {
		try {
			if (typeof aa != "undefined") {
				addCoverageTypeCell(aa, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[12] == 0) {
		try {
			if (typeof ap != "undefined") {
				addCoverageTypeCell(ap, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[13] == 0) {
		try {
			if (typeof af != "undefined") {
				addCoverageTypeCell(af, 0);
			} else {
				addCoverageTypeCell("undefined", 0);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}
	if(ListCols[14] == 0) {
		try {
			if (typeof as != "undefined") {
				addCoverageTypeCell(as, 1);
			} else {
				addCoverageTypeCell("undefined", 1);
			}
		} catch (err) {
			addCoverageTypeCell("undefined", 1);
		}
	}

	table.appendChild(newRow);
	lastRowOdd = lastRowOdd ? 0 : 1;
};

/* undefine global vars holding coverage values inorder to use them for other scopes */
function removeAllDataVariables() {
	try {
		if (typeof children != "undefined") {
			children = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof w != "undefined") {
			w = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof g != "undefined") {
			g = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof d != "undefined") {
			d = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof s != "undefined") {
			s = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof b != "undefined") {
			b = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof e != "undefined") {
			e = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof c != "undefined") {
			c = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof f != "undefined") {
			f = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof ue != "undefined") {
			ue = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof uc != "undefined") {
			uc = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof fe != "undefined") {
			fe = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof fc != "undefined") {
			fc = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof t != "undefined") {
			t = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof fs != "undefined") {
			fs = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof ft != "undefined") {
			ft = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof as != "undefined") {
			as = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof ap != "undefined") {
			ap = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof af != "undefined") {
			af = undefined;
		}
	} catch (err) {
		;
	}
	try {
		if (typeof aa != "undefined") {
			aa = undefined;
		}
	} catch (err) {
		;
	}
};

/* coverage type names used in the recursive_hier_coverage_details table */
var covTypesNames = ["Covergroup", "Directive", "Statement", "Branch",
                 	"Expressions", "UDP Expressions", "FEC Expressions",
                 	"Conditions", "UDP Conditions", "FEC Conditions",
                 	"Toggle", "FSM", "State", "Transition", "Assertion"];
var MakeThreeRowsExp = 0;
var MakeThreeRowsCond = 0;
var thereIsFSM = 0;
var ColName = "";
var colspan = 2;
/* creates row and add it to the recursive_hier_coverage_details table */
function createCoverageTypeRow(table, cov, covTypeIndex) {

	newRow = document.createElement('tr');
	ColName = covTypesNames[covTypeIndex];
	colspan = 2;
	
	if (thereIsFSM > 0) {
		thereIsFSM--;
		colspan = 1;
		createCell(newRow, "TD", 'invisible', 0, '&nbsp;', 0, 0, 0);
	} else if (MakeThreeRowsCond > 0) {
		MakeThreeRowsCond--;
		colspan = 1;
		createCell(newRow, "TD", 'invisible', 0, '&nbsp;', 0, 0, 0);
		if (covTypesNames[covTypeIndex].match ("FEC Conditions") ) {
			ColName = "FEC";		    
		} else { /* covTypesNames[covTypeIndex].match ("FEC Conditions") */
			ColName = "UDP";
		}
	} else if (MakeThreeRowsExp > 0) {
		MakeThreeRowsExp--;
		colspan = 1;
		createCell(newRow, "TD", 'invisible', 0, '&nbsp;', 0, 0, 0);
		if (covTypesNames[covTypeIndex].match ("FEC Expressions") ) {
			ColName = "FEC";		    
		} else { /* covTypesNames[covTypeIndex].match ("FEC Expressions") */
			ColName = "UDP";
		}
	}

	
	if (covTypesNames[covTypeIndex] == "Conditions" ) {
		MakeThreeRowsCond = 2;
	}
	else if (covTypesNames[covTypeIndex] == "Expressions" ) {
		MakeThreeRowsExp = 2;
	}	
	else if (covTypesNames[covTypeIndex] == "FSM" ) {
		thereIsFSM = 2;
	}
	
	createCell(newRow, "TD", cellClasses[lastRowOdd],  colspan, ColName, 0, 0, 0);
	createCell(newRow, "TD", cellClassesRight[lastRowOdd], 0, cov[0], 0, 0, 0);
	createCell(newRow, "TD", cellClassesRight[lastRowOdd],  0, cov[1], 0, 0, 0);

	if (covTypesNames[covTypeIndex] != "Assertion Failures") {
		createCell(newRow, "TD", cellClassesRight[lastRowOdd], 0, cov[0]-cov[1], 0, 0, 0);
		coverageToStyle(cov[3]);
	} else {
		createCell(newRow, "TD", cellClassesRight[lastRowOdd], 0, '-', 0, 0, 0);
		coverageToStyleAssertionFailure(cov[3]);
	}
	createCell(newRow, "TD", cellClassesRight[lastRowOdd], 0, cov[2], 0, 0, 0);
	createCell(newRow, "TD", cellClassesRight[lastRowOdd], 0, cov[4]+"%", 0, 0, 0);
	createCell(newRow, "TD", cellClass, 0, cov[3]+"%", 0, 0, 0);
		
	table.appendChild(newRow);
	lastRowOdd = lastRowOdd ? 0 : 1;
};
function FillColsList(table, rowName, link, firstCellSpan, filtering_flag) {
	newRow = document.createElement('tr');	
	try {
		if (typeof g == "undefined")
			ListCols[0] = 1;		
	} catch (err) {
		ListCols[0] = 1;
	}
	try {
		if (typeof d == "undefined") 
			ListCols[1] = 1;		
	} catch (err) {
		ListCols[1] = 1;
	}
	try {
		if (typeof s == "undefined")
			ListCols[2] = 1;		
	} catch (err) {
		ListCols[2] = 1;
	}
	try {
		if (typeof b == "undefined")
			ListCols[3] = 1;		
	} catch (err) {
		ListCols[3] = 1;
	}
	try {
		if (typeof ue == "undefined")
			ListCols[4] = 1;		
	} catch (err) {
		ListCols[4] = 1;
	}
	try {
		if (typeof uc == "undefined")
			ListCols[5] = 1;	
	} catch (err) {
		ListCols[5] = 1;
	}
	try {
		if (typeof fe == "undefined")
			ListCols[6] = 1;		
	} catch (err) {
		ListCols[6] = 1;
	}
	try {
		if (typeof fc == "undefined")
			ListCols[7] = 1;		
	} catch (err) {
		ListCols[7] = 1;
	}
	try {
		if (typeof t == "undefined")
			ListCols[8] = 1;		
	} catch (err) {
		ListCols[8] = 1;
	}
	try {
		if (typeof fs == "undefined")
			ListCols[9] = 1;		
	} catch (err) {
		ListCols[9] = 1;
	}
	try {
		if (typeof ft == "undefined")
			ListCols[10] = 1;		
	} catch (err) {
		ListCols[10] = 1;
	}
	try {
		if (typeof aa == "undefined")
			ListCols[11] = 1;	
	} catch (err) {
		ListCols[11] = 1;
	}
	try {
		if (typeof ap == "undefined")
			ListCols[12] = 1;		
	} catch (err) {
		ListCols[12] = 1;
	}
	try {
		if (typeof af == "undefined")
			ListCols[13] = 1;
	} catch (err) {
		ListCols[13] = 1;
	}
	try {
		if (typeof as == "undefined")
			ListCols[14] = 1;	
	} catch (err) {
		ListCols[14] = 1;
	}	
};
//////////////////////////  End Functions  //////////////////////////////////
/* read the json file for this scope and process its data */
$.ajax({
	type: "GET",
	url: "h" + id +".json",
	async: false,
	processData: true,
	data: {},
	dataType: "json",
	success: function(data,y,z) {

	$.each(data, function(key, val) {
		if (key == "children")
			eval(key+"=\""+val+"\";");
		else if (val[1] != undefined)
			eval(key+"=["+val[0]+","+val[1]+"];");
		else
			eval(key+"="+val+";");
	});

	}
});

childrenScopes = children; // comma separated list of children scope IDs and names

/* if childrenScopes, then means that this scope has child scopes and hier tables should be created */
if (childrenScopes) {
	childrenScopes = childrenScopes.split(","); // split the children string into array
	
	div1 = document.getElementById("coverage_summary_by_instance");
	if (div1) {
		newElement = document.createElement('HR');
		div1.appendChild(newElement);
		newElement = document.createElement('H3');
		newElement.innerHTML = "Coverage Summary By Instance:";
		div1.appendChild(newElement);

		// create the coverage_summary_by_instance table and its header
		newTable = document.createElement('TABLE');
		newTable.cellspacing = "2";
		newTable.cellpadding = "2";
		tblBody = document.createElement("tbody");

		newRow = document.createElement('tr');
		
		FillColsList(tblBody, 'TOTAL', 0, 2, filtering_active);	
		createCell(newRow, "TH", 'even',  2, 'Scope', 0, 0, 0);		
		createCell(newRow, "TH", 'even', 0, 'TOTAL', 0, 0, 0);
		if (ListCols[0] == 0)
		createCell(newRow, "TH", 'even',  0, 'Cvg', 0, 0, 0);
		if (ListCols[1] == 0)
		createCell(newRow, "TH", 'even', 0, 'Cover', 0, 0, 0);
		if (ListCols[2] == 0)
		createCell(newRow, "TH", 'even',  0, 'Statement', 0, 0, 0);
		if (ListCols[3] == 0)
		createCell(newRow, "TH", 'even', 0, 'Branch', 0, 0, 0);
		if (ListCols[4] == 0)
		createCell_2txt(newRow, "TH", 'even',  0, 'UDP', 'Expression');
		if (ListCols[5] == 0)
		createCell_2txt(newRow, "TH", 'even', 0, 'UDP', 'Condition');
		if (ListCols[6] == 0)
		createCell_2txt(newRow, "TH", 'even',  0, 'FEC', 'Expression');
		if (ListCols[7] == 0)
		createCell_2txt(newRow, "TH", 'even', 0, 'FEC', 'Condition');
		if (ListCols[8] == 0)
		createCell(newRow, "TH", 'even',  0, 'Toggle', 0, 0, 0);
		if (ListCols[9] == 0)
		createCell_2txt(newRow, "TH", 'even', 0, 'FSM', 'State');
		if (ListCols[10] == 0)
		createCell_2txt(newRow, "TH", 'even',  0, 'FSM', 'Trans');
		if (ListCols[11] == 0)
		createCell_2txt(newRow, "TH", 'even', 0, 'Assertion', 'Attempted');
		if (ListCols[12] == 0)
		createCell_2txt(newRow, "TH", 'even', 0, 'Assertion', 'Passes');
		if (ListCols[13] == 0)
		createCell_2txt(newRow, "TH", 'even', 0, 'Assertion', 'Failures');
		if (ListCols[14] == 0)
		createCell_2txt(newRow, "TH", 'even', 0, 'Assertion', 'Successes');

		tblBody.appendChild(newRow);		
		lastRowOdd = 0;	

		// first row, its data is gotten from the prev call of ajax.
		createRow(tblBody, 'TOTAL', 0, 2, filtering_active);

		scopeName = div1.getAttribute('scopeName');
		localTable = document.getElementById("local_data_table");
		if (scopeName && localTable) {
			removeAllDataVariables();

			// adjust the values of the local coverage data. w, g, d, s, b, etc...
			w = localTable.rows[0].cells[1].innerHTML;
			w = w.substring(0, w.length - 1);

			for (var i=2; i< localTable.rows.length; i++) {
				switch (localTable.rows[i].cells[0].childNodes[0].innerHTML?localTable.rows[i].cells[0].childNodes[0].innerHTML:localTable.rows[i].cells[0].innerHTML) {
					case "Covergroup": {
						g = [localTable.rows[i].cells[1].innerHTML, localTable.rows[i].cells[2].innerHTML]; break;
					}
					case "Directive": {
						d = [localTable.rows[i].cells[1].innerHTML, localTable.rows[i].cells[2].innerHTML]; break;
					}
					case "Statement": {
						s = [localTable.rows[i].cells[1].innerHTML, localTable.rows[i].cells[2].innerHTML]; break;
					}
					case "Branch": {
						b = [localTable.rows[i].cells[1].innerHTML, localTable.rows[i].cells[2].innerHTML]; break;
					}
					case "Expression": {
						i= i+1;
						switch (localTable.rows[i].cells[0].childNodes[0].innerHTML?localTable.rows[i].cells[0].childNodes[0].innerHTML:localTable.rows[i].cells[0].innerHTML) {
							case "UDB": {
								ue = [localTable.rows[i].cells[2].innerHTML, localTable.rows[i].cells[3].innerHTML]; i=i+1; break;
							}
							case "FEC": {
								fe = [localTable.rows[i].cells[2].innerHTML, localTable.rows[i].cells[3].innerHTML]; i=i+1; break;
							}
						}						
					}					
					case "FEC Expression": {
						fe = [localTable.rows[i].cells[1].innerHTML, localTable.rows[i].cells[2].innerHTML]; break;
					}
					case "Condition": {
						i= i+1;
						switch (localTable.rows[i].cells[0].childNodes[0].innerHTML?localTable.rows[i].cells[0].childNodes[0].innerHTML:localTable.rows[i].cells[0].innerHTML) {
							case "UDB": {
								uc = [localTable.rows[i].cells[2].innerHTML, localTable.rows[i].cells[3].innerHTML]; i=i+1; break;
							}
							case "FEC": {
								fc = [localTable.rows[i].cells[2].innerHTML, localTable.rows[i].cells[3].innerHTML]; i=i+1; break;
							}
						}	
					}
					case "FEC Condition": {
						fc = [localTable.rows[i].cells[1].innerHTML, localTable.rows[i].cells[2].innerHTML]; break;
					}
					case "Toggle": {
						t = [localTable.rows[i].cells[1].innerHTML, localTable.rows[i].cells[2].innerHTML]; break;
					}					
					case "FSM": {
						i=i+1;
						switch (localTable.rows[i].cells[0].childNodes[0].innerHTML?localTable.rows[i].cells[0].childNodes[0].innerHTML:localTable.rows[i].cells[0].innerHTML) {
							case "State": {
								fs = [localTable.rows[i].cells[2].innerHTML, localTable.rows[i].cells[3].innerHTML]; i=i+1; break;
							}
							case "Transition": {
								ft = [localTable.rows[i].cells[2].innerHTML, localTable.rows[i].cells[3].innerHTML]; i=i+1; break;
							}
						}
					}					
					case "Assertion": {
						as = [localTable.rows[i].cells[1].innerHTML, localTable.rows[i].cells[2].innerHTML]; break;
					}					
					default: {
						break;
					}
				}
			}
			createRow(tblBody, scopeName, 0, 2, 0);
		}

		for(j=0; j < childrenScopes.length -1; j+=2) { // loop on each child id , childrenScopes
			removeAllDataVariables();

			if (childrenScopes[j]) {
				/* read the json file for this child and process its data */
				$.ajax({
					type: "GET",
					url: "h" + childrenScopes[j] +".json",
					async: false,
					processData: true,
					data: {},
					dataType: "json",
					success: function(data,y,z) {

					$.each(data, function(key, val) {
						if (key == "children")
							eval(key+"=\""+val+"\";");
						else if (val[1] != undefined)
							eval(key+"=["+val[0]+","+val[1]+"];");
						else
							eval(key+"="+val+";");
					});

					}
				});

				createRow(tblBody, childrenScopes[j+1], "z"+childrenScopes[j]+".htm", 1, 0);
			} else {
				// this case means that there is a child, but it doesn't have a page crated for it. so there is no link or data for it
				createRow(tblBody, childrenScopes[j+1], 0, 1, 0);
			}
		}
		newTable.appendChild(tblBody);
		div1.appendChild(newTable);
	}

	removeAllDataVariables();
	/* read the json file for this scope again for the recursive_hier_coverage_details table */
	$.ajax({
		type: "GET",
		url: "h" + id +".json",
		async: false,
		processData: true,
		data: {},
		dataType: "json",
		success: function(data,y,z) {

		$.each(data, function(key, val) {
			if (key == "children")
				eval(key+"=\""+val+"\";");
			else if (val[1] != undefined)
				eval(key+"=["+val[0]+","+val[1]+","+val[2]+","+val[3]+","+val[4]+"];");
			else
				eval(key+"="+val+";");
		});

		}
	});

	loc_rec_table = document.getElementById("loc_rec_tables");
	if (loc_rec_table) {
		addTable = 1;
		newCellTable = document.createElement('TD');
		loc_rec_table.rows[0].appendChild(newCellTable);
	}	
	
	if (addTable) {
		newElement = document.createElement('H3');
		newElement.innerHTML = "Recursive Hierarchical Coverage Details:";
		if (newlook) {
			newCellTable.appendChild(newElement);
		} else {
			div1.appendChild(newElement);
		}
		
		//create the recursive_hier_coverage_details table and its header
		newTable = document.createElement('TABLE');
		tblBody = document.createElement("tbody");
		newTable.cellspacing = "2";
		newTable.cellpadding = "2";

		if (newlook) {
			lastRowOdd = 0;
		}
		newRow = document.createElement('tr');
		createCell(newRow, "TD", 'odd', 6, 'Total Coverage:' , 0, 0, 0);
		
		createCell(newRow, "TD", cellClass, 0, q+"%", 0, 0, 0);
		
		coverageToStyle(w);
		createCell(newRow, "TD", cellClass, 0, w+"%", 0, 0, 0);
		tblBody.appendChild(newRow);
		
		if (newlook) {
			lastRowOdd = lastRowOdd ? 0 : 1;
		}

		newRow = document.createElement('tr');
		createCell(newRow, "TH", 'even',   2, 'Coverage Type', 0, 0, 'left');
		createCell(newRow, "TH", 'even',  0, 'Bins' , 0, 0, 0);
		createCell(newRow, "TH", 'even',   0, 'Hits'   , 0, 0, 0);
		createCell(newRow, "TH", 'even',   0, 'Misses'   , 0, 0, 0);
		createCell(newRow, "TH", 'even',   0, 'Weight'   , 0, 0, 0);
		createCell(newRow, "TH", 'even',   0, '% Hit'   , 0, 0, 0);
		createCell(newRow, "TH", 'even',  0, 'Coverage' , 0, 0, 0);
		tblBody.appendChild(newRow);
		
		if (newlook) {
			lastRowOdd = lastRowOdd ? 0 : 1;
		}

		var types = ["g", "d", "s", "b", "e", "ue", "fe", "c", "uc", "fc", "t", "f", "fs", "ft", "as"];
		for(var i=0; i<types.length; i++) {
			try {
				if (eval(types[i]) != undefined) {
					createCoverageTypeRow(tblBody, eval(types[i]), i);
				}
			} catch (err) {
				;
			}
		}

		newTable.appendChild(tblBody);

		if (newlook) {
			newCellTable.appendChild(newTable);
		} else {
			div1.appendChild(newTable);
		}
	}
}
start_sort = 1;
