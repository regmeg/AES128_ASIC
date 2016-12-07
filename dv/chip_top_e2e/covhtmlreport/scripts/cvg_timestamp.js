var testNames_loaded = 0;
var tables = document.getElementsByTagName("TABLE");
var jsonFName = 'q' + scopeId + ".json";
var headID = document.getElementsByTagName("HEAD")[0];

var jsonScript_tests = document.createElement('script');
jsonScript_tests.type = "text/javascript";
jsonScript_tests.src = "testNames.json";
headID.appendChild(jsonScript_tests);
var jsonScript = document.createElement('script');
jsonScript.type = "text/javascript";
jsonScript.src = jsonFName;
headID.appendChild(jsonScript);

var currentIdx = 0;
function processTS() { /* called by the JSON file */
	var inner_index = 0;
	for (var tableCount = 0; tableCount < tables.length; tableCount++) {
		var table = tables[tableCount];
		var rows = table.rows;

		if (!(rows[0].cells[0].innerHTML.match(/^.*Covergroup [type|instance].*$/i))) {
			continue;
		}
		/* wait untill testNames_loaded = 1, which means that testNames.json is loaded */
		while ((testNames_loaded == 0) || (page_loaded == 0));
		/* This table has bins. Proceed */
		
		var newCell;
		
		if (rows[1].cells[rows[1].cells.length - 2].className == 'even') {
			/* add 2 empty cells at row 0 */
			newCell = document.createElement('TD');
			newCell.className = 'odd';
			newCell.innerHTML = '--';
			rows[0].insertBefore(newCell, rows[0].cells[rows[0].cells.length]);
			newCell = document.createElement('TD');
			newCell.className = 'even';
			newCell.innerHTML = '--';
			rows[0].insertBefore(newCell, rows[0].cells[rows[0].cells.length]);
			
			/* add 2 header cells for timestamp value and test name */
			newCell = document.createElement('TH');
			newCell.className = 'odd';
			newCell.innerHTML = 'Covered SimTime';
			rows[1].insertBefore(newCell, rows[1].cells[rows[1].cells.length]);
			newCell = document.createElement('TH');
			newCell.className = 'even';
			newCell.innerHTML = 'Covered in Test';
			rows[1].insertBefore(newCell, rows[1].cells[rows[1].cells.length]);
		} else /*if (rows[1].cells[rows[1].cells.length - 2].className == 'odd')*/ {
			/* add 2 empty cells at row 0 */
			newCell = document.createElement('TD');
			newCell.className = 'even';
			newCell.innerHTML = '--';
			rows[0].insertBefore(newCell, rows[0].cells[rows[0].cells.length]);
			newCell = document.createElement('TD');
			newCell.className = 'odd';
			newCell.innerHTML = '--';
			rows[0].insertBefore(newCell, rows[0].cells[rows[0].cells.length]);
			
			/* add 2 header cells for timestamp value and test name */
			newCell = document.createElement('TH');
			newCell.className = 'even';
			newCell.innerHTML = 'Covered SimTime';
			rows[1].insertBefore(newCell, rows[1].cells[rows[1].cells.length]);
			newCell = document.createElement('TH');
			newCell.className = 'odd';
			newCell.innerHTML = 'Covered in Test';
			rows[1].insertBefore(newCell, rows[1].cells[rows[1].cells.length]);
		}
		
		inner_index = currentIdx;
		for (var i = 2; i<rows.length; i++) {
			var newData = "empty";
			if (rows[i].cells[0].innerHTML.match(/^Coverpoint:.*$/)) {
				newData = "&nbsp;";
			} else if (rows[i].cells[0].innerHTML.match(/^Cross:.*/)) {
				newData = "&nbsp;";
			}

			if (rows[i].cells[rows[i].cells.length - 3].className.match(/even[_r]?/)) {
				newCell = document.createElement('TD');
				newCell.className = 'odd_r';
				if (newData != "&nbsp;") {
					if ((g_binTSdata[inner_index] != undefined) && (g_binTSdata[inner_index][0] != undefined))
						if (g_binTSdata[inner_index][2] != undefined)
							newData = g_binTSdata[inner_index][0] + g_binTSdata[inner_index][2];
						else
							newData = g_binTSdata[inner_index][0];
					else
						newData = "--";
				}
				newCell.innerHTML = newData;
				rows[i].insertBefore(newCell, rows[i].cells[rows[i].cells.length]);
				newCell = document.createElement('TD');
				newCell.className = 'even_r';
				if (newData != "&nbsp;") {
					if ((g_binTSdata[inner_index] != undefined) && (g_binTSdata[inner_index][1] != undefined))
						newData = test_names[g_binTSdata[inner_index][1]];
					else
						newData = "--";
				}
				newCell.innerHTML = newData;
				rows[i].insertBefore(newCell, rows[i].cells[rows[i].cells.length]);
			} else /*if (rows[i].cells[rows[i].cells.length - 3].className.match(/odd[_r]?/))*/ {
				newCell = document.createElement('TD');
				newCell.className = 'even_r';
				if (newData != "&nbsp;") {
					if ((g_binTSdata[inner_index] != undefined) && (g_binTSdata[inner_index][0] != undefined))
						if (g_binTSdata[inner_index][2] != undefined)
							newData = g_binTSdata[inner_index][0] + g_binTSdata[inner_index][2];
						else
							newData = g_binTSdata[inner_index][0];
					else
						newData = "--";
				}
				newCell.innerHTML = newData;
				rows[i].insertBefore(newCell, rows[i].cells[rows[i].cells.length]);
				newCell = document.createElement('TD');
				newCell.className = 'odd_r';
				if (newData != "&nbsp;") {
					if ((g_binTSdata[inner_index] != undefined) && (g_binTSdata[inner_index][1] != undefined))
						newData = test_names[g_binTSdata[inner_index][1]];
					else
						newData = "--";
				}
				newCell.innerHTML = newData;
				rows[i].insertBefore(newCell, rows[i].cells[rows[i].cells.length]);
			}
			
			if (newData != "&nbsp;") {
				inner_index++;
			}
		}
		currentIdx = inner_index;
	}
}

function loadTestNames() { /* called by the JSON file testNames.json */
	testNames_loaded = 1;
}
