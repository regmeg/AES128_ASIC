var divFullPathSuffix = "Fp";
var divButtonSuffix = "B";

var topTpSections = [];
var topTpSectionsIndex = 0;

/* ************************************************************************** */
function TpTreeNode(rowId, areContentsExpanded, isLinkNode) {
	//this.rowId = rowId; // no need for this instance variable
	this.childrenCount = 0;
	this.isLinkNode = isLinkNode;
	this.children = []; /* empty array */
	
	this.areContentsExpanded = areContentsExpanded;
	/* Contents of this tpSection is expanded */
	
	this.contentsLastStateIsExpanded = 1;
	/* This variable will hold the last display status before the current
	 * display status.
	 * By display status we mean, tpSection contents is expanded or not
	 * 1: means contents are expanded
	 * 0: means contents are collapsed
	 * 
	 * This variable is important to know the status of subsections of the
	 * current section so that we can restore their status when displaying
	 * contents of the current section
	 */
	
	
	this.rowDomObj = document.getElementById(rowId);
	this.divButtonDomObj = document.getElementById(rowId + divButtonSuffix);
	this.fullPathRowDomObj = 0;
	if (isLinkNode) {
		this.fullPathRowDomObj = document.getElementById(rowId + divFullPathSuffix);
	}
}
TpTreeNode.prototype.addChild = function(tpTreeNodeObj) {
	this.children[this.childrenCount] = tpTreeNodeObj;
	this.childrenCount ++;
};
TpTreeNode.prototype.expandNode = function () {
	var i=0;
	var fullpath;
	if (!this.isLinkNode && this.childrenCount == 0) return;
	if (this.areContentsExpanded) return;
	
	if (this.isLinkNode) {
		if (this.fullPathRowDomObj) {
			this.fullPathRowDomObj.style.display = "table-row";
		}
	} else {
		for (i ; i<this.childrenCount ; i++) {
			this.children[i].displayNode();
			if ( this.children[i].contentsLastStateIsExpanded ) {
				this.children[i].expandNode();
			}
		}
	}
	
	this.divButtonDomObj.innerHTML = "<img src=\"images/dtr.png\"/>";
	this.areContentsExpanded = true;
};
TpTreeNode.prototype.collapseNode = function () {
	var i=0;
	var fullpath;
	if (!this.isLinkNode && this.childrenCount == 0) return;
	if (!this.areContentsExpanded) {
		this.contentsLastStateIsExpanded = false;
		return;
	}
	
	if (this.isLinkNode) {
		if (this.fullPathRowDomObj) {
			this.fullPathRowDomObj.style.display = "none";
			this.divButtonDomObj.innerHTML = "<img src=\"images/rtr.png\"/>";
		}
	} else {
		for (i ; i<this.childrenCount ; i++) {
			this.children[i].collapseNode();
			this.children[i].hideNode();
		}
		this.divButtonDomObj.innerHTML = "<img src=\"images/rtr.png\"/>";
	}
	
	this.areContentsExpanded = false;
	this.contentsLastStateIsExpanded = true;
};
TpTreeNode.prototype.hideNode = function () {
	this.rowDomObj.style.display = "none";
};
TpTreeNode.prototype.displayNode = function () {
	this.rowDomObj.style.display = "table-row";
};
TpTreeNode.prototype.displayTpSectionsOnly = function () {
	var i;
	var isExpanded = false;
	var isCollapsed = false;
	
	if (!this.isLinkNode && this.childrenCount == 0) return;
	
	for (i=0 ; i<this.childrenCount ; i++) {
		if (this.children[i].isLinkNode) { /* Hide Link nodes */
			this.children[i].collapseNode();
			this.children[i].hideNode();
			isCollapsed = true;
		} else {
			this.children[i].displayNode();
			this.children[i].displayTpSectionsOnly();
			isExpanded = true;
		}
	}
	
	if (isExpanded) {
		this.divButtonDomObj.innerHTML = "<img src=\"images/dtr.png\"/>";
		this.areContentsExpanded = true;
	} else if (isCollapsed) {
		this.divButtonDomObj.innerHTML = "<img src=\"images/rtr.png\"/>";
		this.contentsLastStateIsExpanded = false; /* any child node is collapsed */
		this.areContentsExpanded = false;
	}
};
TpTreeNode.prototype.forceCollapse = function () {
	/* 
	 * The difference between this function and collpaseNode() is that this
	 * function will set the previous state of child nodes to be "Collapsed"
	 */
	var i;
	
	if (!this.isLinkNode && this.childrenCount == 0) return;
	
	if (this.isLinkNode) {
		if (this.fullPathRowDomObj) {
			this.fullPathRowDomObj.style.display = "none";
			this.divButtonDomObj.innerHTML = "<img src=\"images/rtr.png\"/>";
		}
	} else {
		for (i=0 ; i<this.childrenCount ; i++) {
			this.children[i].hideNode();
			this.children[i].forceCollapse();
		}
		this.divButtonDomObj.innerHTML = "<img src=\"images/rtr.png\"/>";
	}
	
	this.areContentsExpanded = false;
	this.contentsLastStateIsExpanded = false;
};
TpTreeNode.prototype.forceExpand = function () {
	/* 
	 * The difference between this function and expandNode() is that this
	 * function will not consider the property TpTreeNode.contentsLastStateIsExpanded
	 * while expanding child nodes.
	 */
	var i;
	var isExpanded = false;
	if (this.isLinkNode) {
		if (this.fullPathRowDomObj) {
			this.fullPathRowDomObj.style.display = "table-row";
			isExpanded = true;
		}
	} else {
		for (i=0 ; i<this.childrenCount ; i++) {
			this.children[i].displayNode();
			this.children[i].forceExpand();
			isExpanded = true;
		}
	}
	
	if (isExpanded) {
		this.divButtonDomObj.innerHTML = "<img src=\"images/dtr.png\"/>";
		this.areContentsExpanded = true;
	}
};

TpTreeNode.prototype.displayTpSectionsAndLinks = function() {
	var i;
	var isExpanded = false;
	if (this.isLinkNode) {
		if (this.fullPathRowDomObj) { /* hide */
			this.fullPathRowDomObj.style.display = "none";
			this.divButtonDomObj.innerHTML = "<img src=\"images/rtr.png\"/>";
			this.areContentsExpanded = false;
		}
	} else {
		for (i=0 ; i<this.childrenCount ; i++) {
			this.children[i].displayNode();
			this.children[i].displayTpSectionsAndLinks();
			isExpanded = true;
		}
	}
	
	if (isExpanded) {
		this.divButtonDomObj.innerHTML = "<img src=\"images/dtr.png\"/>";
		this.areContentsExpanded = true;
	}
}

/* ************************************************************************** */

function toggleContentsDisplay(tpTreeNodeObj) {
	if (tpTreeNodeObj.areContentsExpanded) {
		tpTreeNodeObj.collapseNode();
	} else {
		tpTreeNodeObj.expandNode();
	}
}

function showOnlyTpSections() {
	var i;
	for (i=0 ; i<topTpSectionsIndex ; i++) {
		topTpSections[i].displayNode();
		topTpSections[i].displayTpSectionsOnly();
	}
}

function collapseAll() {
	var i;
	for (i=0 ; i<topTpSectionsIndex ; i++) {
		topTpSections[i].displayNode();
		topTpSections[i].forceCollapse();
	}
}

function expandAll() {
	var i;
	for (i=0 ; i<topTpSectionsIndex ; i++) {
		topTpSections[i].displayNode();
		topTpSections[i].forceExpand();
	}
}

function showTpSectionsAndLinks() {
	var i;
	for (i=0 ; i<topTpSectionsIndex ; i++) {
		topTpSections[i].displayNode();
		topTpSections[i].displayTpSectionsAndLinks();
	}
}
