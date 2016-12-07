var TEXTAREA_COLS = 20;
var TEXTAREA_COLS_STR = 20;
var TEXTAREA_ROWS_STR = 2;

var NUM_OF_ATTRIBUTES = 0;

function getLinkStatusToStr(linkStatus) {
	switch (linkStatus) {
		case '1':					return "Unlinked";
		case '2':					return "Clean";
		case '3':					return "Partial";
		case '4':					return "Error";
		default: 					return "";
	}
}

function getTaggedItemDataCellClass(isOdd, cntrRightLeft, isMissingLink, isExcluded,ZeroWeight) {
	var className = '';
	
	if (isExcluded) {
		className += 'Excl';
	} else if (isMissingLink) {
		className += 'Missing';
	} else if (ZeroWeight == 1) {
		className += 'Gray';
	}
	
	className += cntrRightLeft;

	if (isOdd) {
		className += 'Odd';
	} else {
		className += 'Even';
	}
	
	return (className  += 'TgTd');	
}

function getTestplanSectionDataCellClass(isOdd, cntrRightLeft, isExcluded, cellType,ZeroWeight) {
	var className = '';
	
	if (isExcluded) {
		className += 'Excl';
	}else if (ZeroWeight == 1) {
		className += 'Gray';
	}		
	className += cntrRightLeft;

	if (isOdd) {
		className += 'Odd';
	} else {
		className += 'Even';
	}
	
	return (className  += cellType);
}

function addCell(rowObj, innerHtml, className, colSpan, cellType) {
	var newCell = document.createElement(cellType);
	newCell.className = className;
	newCell.colSpan = colSpan;
	newCell.innerHTML = innerHtml;
	rowObj.appendChild(newCell);
}

function addDataCell(rowObj, innerHtml, className) {
	addCell(rowObj, innerHtml, className, 1, 'TD');
}

function addHeaderCell(rowObj, innerHtml, className, colSpan) {
	addCell(rowObj, innerHtml, className, colSpan, 'TH');
}

function buildHeaderRow(rowObj) {
	addHeaderCell(rowObj, 'Testplan section', 'odd' , rowObj.getAttribute('s'));
	addHeaderCell(rowObj, 'Linked Items'    , 'even', 1);
	addHeaderCell(rowObj, 'Covered Items'   , 'odd' , 1);
	addHeaderCell(rowObj, 'Coverage'        , 'even', 1);
	addHeaderCell(rowObj, '% of Goal'       , 'odd' , 1);
	addHeaderCell(rowObj, 'Type'            , 'even', 1);
	addHeaderCell(rowObj, 'Bins'            , 'odd' , 1);
	addHeaderCell(rowObj, 'Hits'            , 'even', 1);
	addHeaderCell(rowObj, '% Hit'           , 'odd' , 1);
	addHeaderCell(rowObj, 'Link Status'     , 'even', 1);
	addHeaderCell(rowObj, 'Description'     , 'odd' , 1); // this is the last default column
	
	var lastClassOdd = true;
	var i = 1;
	var tmp;
	var className;
	for(; i > 0; i++) {
		tmp = rowObj.getAttribute('x' + i);
		if (!tmp) break;
		if (lastClassOdd) {
			className = 'even';
		} else {
			className = 'odd';
		}
		addHeaderCell(rowObj, tmp, className, 1);	
		lastClassOdd = !lastClassOdd;
	}
	NUM_OF_ATTRIBUTES = i-1;
}

function addIndentationCellsToDataRow(rowObj) {
	var tmp = rowObj.getAttribute('l');
	if (tmp) {
		var newCell;
		for(var i = 0; i < tmp; i++) {
			newCell = document.createElement('TD');
			newCell.innerHTML = '&nbsp;';
			rowObj.appendChild(newCell);
		}
	}
}

function addTaggedItemNameCell(rowObj, isExcluded, isMissingLink) {
	var tmp;
	var newElement;
	var newElement2;
	var ZeroWeight = rowObj.getAttribute('cl');
	var newCell = document.createElement('TD');

	newCell.className = getTaggedItemDataCellClass(1, '', isMissingLink, isExcluded,ZeroWeight);
	
	tmp = rowObj.getAttribute('s');
	if (tmp > 1) {
		newCell.setAttribute("colSpan", tmp);
	} else {
		newCell.setAttribute("colSpan", "1");
	}
	
	tmp = rowObj.getAttribute('i');
	if (tmp) {
		newElement = document.createElement('DIV');
		newElement.id = 't' + tmp + 'L' + rowObj.getAttribute('in') + "IdB" ;
		newElement.className = "btnD";
		newElement.setAttribute("onclick", "toggleContentsDisplay(t" + tmp + "L" + rowObj.getAttribute('in') + ')');
		
		newElement2 = document.createElement('IMG');
		newElement2.src = "images/rtr.png";
		newElement.appendChild(newElement2);
		newCell.appendChild(newElement);
	}
	newElement = document.createElement('DIV');
	newElement.className = "tpD";
	newElement.innerHTML = rowObj.getAttribute('z');
	
	newCell.appendChild(newElement);
	rowObj.appendChild(newCell);
}

function addColoredPcntgDataCell(rowObj, valueAttrName, colorAttrName, isOdd, zeroWeight) {
	var value = rowObj.getAttribute(valueAttrName);
	var color = rowObj.getAttribute(colorAttrName);
	var className;
	if (value) {
		if (zeroWeight != 1) {
			switch (color) {
			case 'R':
				className = 'bgRed'; break;
			case 'Y':
				className = 'bgYellow'; break;
			case 'G':
				className = 'bgGreen'; break;
			default:
				className = ''; break;
			}
			addDataCell(rowObj, value+'%', className);
		} else {
			className = 'Gray';
			if (isOdd) {
				addDataCell(rowObj, value+'%', className+'CntrOddTd');
			} else {
				addDataCell(rowObj, value+'%', className+'CntrEvenTd');
			}
		}
		
	} else {
		if (zeroWeight == 1) {
			className = 'Gray';
		}
		if (isOdd) {
			addDataCell(rowObj, '--', className+'CntrOddTd');
		} else {
			addDataCell(rowObj, '--', className+'CntrEvenTd');
		}
	}
}

function addTextBoxCell(rowObj, text, isOdd, isExcluded) {
	var newCell = document.createElement('TD');
	var ZeroWeight = rowObj.getAttribute('cl');
	newCell.className = getTestplanSectionDataCellClass(isOdd, '', isExcluded, 'Td',ZeroWeight);
	
	if (text) {
		if (text.length > TEXTAREA_COLS) {
			var newElement = document.createElement('textarea');
			newElement.readonly = "readonly";
			newElement.className = getTestplanSectionDataCellClass(isOdd, '', isExcluded, 'TxtBox',ZeroWeight);
			
			newElement.cols = TEXTAREA_COLS_STR;
			newElement.rows = TEXTAREA_ROWS_STR;
			newElement.innerHTML = text;
			newCell.appendChild(newElement);
		} else {
			newCell.innerHTML = text;
		}
	} // end if (text)
	
	rowObj.appendChild(newCell);
}

function addTestplanSectionDataCells(rowObj, isExcluded, linkStatusValue) {		
	if (isExcluded) {
		addDataCell(rowObj, '--',
				getTestplanSectionDataCellClass(0, '', isExcluded, 'Td',0));          /*Linked Items*/
		addDataCell(rowObj, '--',
				getTestplanSectionDataCellClass(1 ,'', isExcluded, 'Td',0));          /*Covered Items*/		
		addDataCell(rowObj, '--', //'Excluded'
				getTestplanSectionDataCellClass(0, '', isExcluded, 'Td',0));          /*Coverage*/
		addDataCell(rowObj, '--',
				getTestplanSectionDataCellClass(1 , '',isExcluded, 'Td',0));          /*% of Goal*/
		addDataCell(rowObj, rowObj.getAttribute('t'),
				getTestplanSectionDataCellClass(0 , 'Cntr', isExcluded, 'Td',0));     /*Type*/
		addDataCell(rowObj, '--',
				getTestplanSectionDataCellClass(1 , 'Cntr', isExcluded, 'Td',0));     /*Bins*/
		addDataCell(rowObj, '--',
				getTestplanSectionDataCellClass(0 , 'Cntr', isExcluded, 'Td',0));     /*Hits*/
		addDataCell(rowObj, '--',
				getTestplanSectionDataCellClass(1 , 'Cntr', isExcluded, 'Td',0));     /* %Hit */
		addDataCell(rowObj, getLinkStatusToStr(linkStatusValue),
				getTestplanSectionDataCellClass(0 , 'Cntr', isExcluded, 'Td',0));     /*LinkStatus*/
	} else {
		var ZeroWeight = rowObj.getAttribute('cl');		
		addDataCell(rowObj, rowObj.getAttribute('c'),
				getTestplanSectionDataCellClass(0 , 'Right', isExcluded, 'Td',ZeroWeight));        /*Linked Items*/		
		addDataCell(rowObj, rowObj.getAttribute('v'),
				getTestplanSectionDataCellClass(1 , 'Right', isExcluded, 'Td',ZeroWeight));        /*Covered Items*/		
		addColoredPcntgDataCell(rowObj, 'h', 'hc', 0, ZeroWeight);                                  /*Coverage*/
		addColoredPcntgDataCell(rowObj, 'p', 'pc', 1, ZeroWeight);                                  /*% of Goal*/
		addDataCell(rowObj, rowObj.getAttribute('t'),
				getTestplanSectionDataCellClass(0 , 'Cntr', isExcluded, 'Td',ZeroWeight));         /*Type*/
		addDataCell(rowObj, rowObj.getAttribute('b'),
				getTestplanSectionDataCellClass(1 , 'Cntr', isExcluded, 'Td',ZeroWeight));         /*Bins*/
		addDataCell(rowObj, rowObj.getAttribute('ht'),
				getTestplanSectionDataCellClass(0 , 'Cntr', isExcluded, 'Td',ZeroWeight));         /*Hits*/
		addDataCell(rowObj, rowObj.getAttribute('q'),
				getTestplanSectionDataCellClass(1 , 'Cntr', isExcluded, 'Td',ZeroWeight));         /* % Hit */
		addDataCell(rowObj, getLinkStatusToStr(linkStatusValue),
				getTestplanSectionDataCellClass(0 , 'Cntr', isExcluded, 'Td',ZeroWeight));         /* LinkStatus */
	}
	
	// description:
	addTextBoxCell(rowObj, rowObj.getAttribute('ch'), 1 , isExcluded);
	
	// attributes
	// NOTE: if the default columns are changed, then lastClassOdd should be changed accordingly
	// according to the class of the last column of the default columns
	var lastClassOdd = true;
	for(var i = 1; i <= NUM_OF_ATTRIBUTES; i++) {
		addTextBoxCell(rowObj, rowObj.getAttribute('x' + i), lastClassOdd, isExcluded);
		lastClassOdd = !lastClassOdd;
	} /* end for loop to print attributes */
}

function addTaggedItemDataCells(rowObj, isExcluded, isMissingLink) {		
	if (isMissingLink) {
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, '', 1, 0,0)/*'missingTgTdE'*/);              /* Linked Items */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, '', 1, 0,0)/*'missingTgTdO'*/);              /* Covered Items */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, 'Cntr', 1, 0,0)/*'missingTgTdCntrE'*/);          /* Coverage */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, 'Cntr', 1, 0,0)/*'missingTgTdCntrO'*/);          /* % of Goal */
		addDataCell(rowObj, rowObj.getAttribute('t'), getTaggedItemDataCellClass(0, 'Cntr', 1, 0,0)/*'missingTgTdCntrE'*/);          /* Type */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, 'Cntr', 1, 0,0)/*'missingTgTdCntrO'*/);          /* Bins */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, 'Cntr', 1, 0,0)/*'missingTgTdCntrE'*/);          /* Hits */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, 'Cntr', 1, 0,0)/*'missingTgTdCntrO'*/);          /* % Hits */
		addDataCell(rowObj, getLinkStatusToStr(isMissingLink), getTaggedItemDataCellClass(0, 'Cntr', 1, 0, 'TgTd',0)/*'missingTgTdCntrE'*/);     /* Link Status */
		addDataCell(rowObj, '', getTaggedItemDataCellClass(1, 'Cntr', 1, 0,0)/*'missingTgTdCntrO'*/);            /* Description */
		
		// attributes
		// NOTE: if the default columns are changed, then lastClassOdd should be changed accordingly
		// according to the class of the last column of the default columns
		var lastClassOdd = true;
		for(var i = 1; i <= NUM_OF_ATTRIBUTES; i++) {
			if (lastClassOdd) {
				addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, '', 1, 0,0)/*'missingTgTdE'*/);
			} else {
				addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, '', 1, 0,0)/*'missingTgTdO'*/);
			}
			lastClassOdd = !lastClassOdd;
		} /* end for loop to print attributes */
		
	} else if (isExcluded) {
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, '', 0, 1,0)/*'exclTgTdE'*/);                 /* Linked Items */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, '', 0, 1,0)/*'exclTgTdO'*/);                 /* Covered Items */
		addDataCell(rowObj, 'Excluded', getTaggedItemDataCellClass(0, 'Cntr', 0, 1,0)/*'exclTgTdCntrE'*/);       /* Coverage */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, 'Cntr', 0, 1,0)/*'exclTgTdCntrO'*/);             /* % of Goal */
		addDataCell(rowObj, rowObj.getAttribute('t'), getTaggedItemDataCellClass(0, 'Cntr', 0, 1,0)/*'exclTgTdCntrE'*/);          /* Type */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, 'Cntr', 0, 1,0)/*'exclTgTdCntrO'*/);          /* Bins */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, 'Cntr', 0, 1,0)/*'exclTgTdCntrE'*/);          /* Hits */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, 'Cntr', 0, 1,0)/*'exclTgTdCntrO'*/);          /* % Hits */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, 'Cntr', 0, 1,0)/*'exclTgTdCntrE'*/);          /* Link Status */
		addDataCell(rowObj, '', getTaggedItemDataCellClass(1, 'Cntr', 0, 1,0)/*'exclTgTdCntrO'*/);            /* Description */
		
		// attributes
		// NOTE: if the default columns are changed, then lastClassOdd should be changed accordingly
		// according to the class of the last column of the default columns
		var lastClassOdd = true;
		for(var i = 1; i <= NUM_OF_ATTRIBUTES; i++) {
			if (lastClassOdd) {
				addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, '', 0, 1,0)/*'exclTgTdE'*/);
			} else {
				addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, '', 0, 1,0)/*'exclTgTdO'*/);
			}
			lastClassOdd = !lastClassOdd;
		} /* end for loop to print attributes */
		
	} else {
		var ZeroWeight = rowObj.getAttribute('cl');
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, '', 0, 0,ZeroWeight)/*'tgTdE'*/);                              /* Linked Items */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, '', 0, 0,ZeroWeight)/*'tgTdO'*/);                              /* Covered Items */
		addColoredPcntgDataCell(rowObj, 'h', 'hc', 0 /*isOdd*/, ZeroWeight);         /* Coverage */
		addColoredPcntgDataCell(rowObj, 'p', 'pc', 1 /*isOdd*/, ZeroWeight);         /* % of Goal */
		addDataCell(rowObj, rowObj.getAttribute('t'), getTaggedItemDataCellClass(0, 'Cntr', 0, 0,ZeroWeight)/*'tgTdCntrE'*/);      /* Type */
		addDataCell(rowObj, rowObj.getAttribute('b'), getTaggedItemDataCellClass(1, 'Cntr', 0, 0,ZeroWeight)/*'tgTdCntrO'*/);      /* Bins */
		addDataCell(rowObj, rowObj.getAttribute('ht'), getTaggedItemDataCellClass(0, 'Cntr', 0, 0,ZeroWeight)/*'tgTdCntrE'*/);      /* Hits */
		addDataCell(rowObj, rowObj.getAttribute('q'), getTaggedItemDataCellClass(1, 'Cntr', 0, 0,ZeroWeight)/*'tgTdCntrO'*/);  /* % Hit */
		addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, 'Cntr', 0, 0,ZeroWeight)/*'tgTdCntrE'*/);                          /* Link Status */
		addDataCell(rowObj, '', getTaggedItemDataCellClass(1, 'Cntr', 0, 0,ZeroWeight)/*'tgTdCntrO'*/);                            /* Description */
		
		// attributes
		// NOTE: if the default columns are changed, then lastClassOdd should be changed accordingly
		// according to the class of the last column of the default columns
		var lastClassOdd = true;
		for(var i = 1; i <= NUM_OF_ATTRIBUTES; i++) {
			if (lastClassOdd) {
				addDataCell(rowObj, '--', getTaggedItemDataCellClass(0, '', 0, 0,ZeroWeight)/*'tgTdE'*/);
			} else {
				addDataCell(rowObj, '--', getTaggedItemDataCellClass(1, '', 0, 0,ZeroWeight)/*'tgTdO'*/);
			}
			lastClassOdd = !lastClassOdd;
		} /* end for loop to print attributes */
	}
	
	
}

function addTaggedItemRow(rowObj, isExcluded, isMissingLink) {	
	addTaggedItemNameCell(rowObj, isExcluded, isMissingLink);
	addTaggedItemDataCells(rowObj, isExcluded, isMissingLink);
}

function addFullPathRow(rowObj, isExcluded, isMissingLink) {
	var isExcluded = rowObj.getAttribute('excl');
	var ZeroWeight = rowObj.getAttribute('cl');
	var isMissingLink = rowObj.getAttribute('ls');
	var newCell = document.createElement('TD');
	var tmp;
	
	rowObj.className = "fpTr";
	newCell.className = getTaggedItemDataCellClass(1, '', isMissingLink, isExcluded,ZeroWeight);
	
	tmp = rowObj.getAttribute('s');
	if (tmp > 1) {
		newCell.setAttribute("colSpan", tmp);
	} else {
		newCell.setAttribute("colSpan", "1");
	}
	newCell.innerHTML = rowObj.getAttribute('z');
	rowObj.appendChild(newCell);
}

function addTestplanSectionNameCell(rowObj) {
	var newCell = document.createElement('TD');
	var ZeroWeight = rowObj.getAttribute('cl');
	newCell.className = getTestplanSectionDataCellClass(1, '', 0, 'Td',ZeroWeight)/*'OddTd'*/;
	
	var tmp = rowObj.getAttribute('s');
	if (tmp > 1) {
		newCell.setAttribute("colSpan", tmp);
	} else {
		newCell.setAttribute("colSpan", "1");
	}

	tmp = rowObj.getAttribute('d');
	var newElement;
	var newElement2;
	if (tmp == 1) {
		newElement = document.createElement('DIV');
		newElement.id = 't' + rowObj.getAttribute('i') + "IdB" ;
		newElement.className = "btnD";
		newElement.setAttribute("onclick", "toggleContentsDisplay(t" + rowObj.getAttribute('i') + ')');
		
		newElement2 = document.createElement('IMG');
		newElement2.src = "images/dtr.png";
		newElement.appendChild(newElement2);
		newCell.appendChild(newElement);
	} else if (tmp == 2){
		newElement = document.createElement('DIV');
		newElement.className = "dimBtnD";
		newElement2 = document.createElement('IMG');
		newElement2.src = "images/dimrtr.png";
		newElement.appendChild(newElement2);
		newCell.appendChild(newElement);
	}
	newElement = document.createElement('DIV');
	newElement.className = "tpD";
	tmp = rowObj.getAttribute('n');
	if (tmp) {
		newElement2 = document.createElement('a');
		newElement2.setAttribute("href", "pages/" + tmp);
		newElement2.innerHTML = rowObj.getAttribute('z');
		newElement.appendChild(newElement2);
	} else {
		newElement.innerHTML = rowObj.getAttribute('z');
	}
	newCell.appendChild(newElement);
	rowObj.appendChild(newCell);
}

function addTestplanSectionRow(rowObj, isExcluded, linkStatusValue) {
	addTestplanSectionNameCell(rowObj);
	addTestplanSectionDataCells(rowObj, isExcluded, linkStatusValue);
}

function buildPage() {
	var tables = document.getElementsByTagName("TABLE");
	var t=0;
	if (tables[0].className.match('noborder')) {
		// ignore the 1st table which is the table for Expand/Collapse buttons
		t = 1;
	}

	var table = tables[t];
	var newRow = table.rows[0];
	
	buildHeaderRow(newRow);
	
	/* build data rows */
	var isExcluded;
	var linkStatus; // mnabil : rename is missing link to be "linkStatus"
	for (var r = 1; r < table.rows.length; r++) {
		newRow = table.rows[r];
		
		addIndentationCellsToDataRow(newRow);
		
		isExcluded = newRow.getAttribute('excl');
		linkStatus = newRow.getAttribute('ls');
		
		if (newRow.id.match(/^t\d+L\d+Id$/)) { // link (tagged item) row
			addTaggedItemRow(newRow, isExcluded, linkStatus);
		} else if (newRow.id.match(/^t\d+L\d+IdFp$/)) { // full path row
			addFullPathRow(newRow, isExcluded, linkStatus);
		} else { // if (newRow.id.match(/^t\d+Id$/)) // testplan section row
			addTestplanSectionRow(newRow, isExcluded, linkStatus);
		}
	}
		
}

buildPage();

loadTreeNodes();
