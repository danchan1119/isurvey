// The queryToObject function
var queryToObject = function(q, pageSize, pageIndex) {
	var col, i, r, _i, _len, _ref, _ref2, _results;
	_results = [];
	for (i = pageSize*pageIndex, _ref = (pageSize*(pageIndex+1) > q.ROWCOUNT) ? q.ROWCOUNT : pageSize*(pageIndex+1); 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
	  r = {};
	  _ref2 = q.COLUMNS;
	  for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
		col = _ref2[_i];
		r[col.toLowerCase()] = q.DATA[col][i];
	  }
	  _results.push(r);
	}
	return _results;
};

var DynamicDataSource = function (options) {
	this._formatter = options.formatter;
	this._columns = options.columns;
	this._delay = options.delay||0;
};

DynamicDataSource.prototype = {
	//Returns stored column metadata
	columns: function () {
		return this._columns;
		},
		
	data: function (options, callback){
		if (options.filter1 && options.filter2) {
			var url = "cfc/ajax.cfc?method=getLatestTickets&priorityID=" + options.filter1.value + "&statusID=" + options.filter2.value;
		}
		else if (options.filter1) {
			var url = "cfc/ajax.cfc?method=getLatestTickets&priorityID=" + options.filter1.value;
		}
		else if (options.filter2) {
			var url = "cfc/ajax.cfc?method=getLatestTickets&statusID=" + options.filter2.value;
		}
		else {
			var url = "cfc/ajax.cfc?method=getLatestTickets";
		}
		$.ajax({
			url: url,
			dataType: "json"
		})
		.done(function (response) {
			// Prepare data to return to Datagrid
			var count = response.ROWCOUNT;
			var startIndex = (options.pageIndex * options.pageSize) + 1;
			var start = startIndex;
			var endIndex = (options.pageIndex + 1) * options.pageSize;
			var end = (endIndex > count) ? count : endIndex;
			var pages = Math.ceil(response.ROWCOUNT / options.pageSize);
			var page = options.pageIndex + 1;
			
			var data = queryToObject(response, options.pageSize, options.pageIndex);
			
			// Return data to Datagrid
			callback({ data: data, start: start, end: end, count: count, pages: pages, page: page });
			//callback({ data: [], start: 0, end: 0, count: 0, pages: 0, page: 0 });

		})
	}
};