var StaticDataSource=function(a){
	this._formatter=a.formatter;
	this._columns=a.columns;
	this._delay=a.delay||0;
	this._data=a.data
	};
	
StaticDataSource.prototype={
    columns: function(){
        return this._columns
    },
    data: function(b,c){
        var a=this;setTimeout(function(){
            var i=$.extend(true,
            [
                
            ],
            a._data);if(b.search){
                i=a.filter(i,b,function(l){
                    for(var m in l){
                        if(!l.hasOwnProperty(m)){
                            continue
                        }
						if(~l[m].toString().toLowerCase().indexOf(b.search.toLowerCase())){
                            return true
                        }
                    }
					return false
                })
            }
			if(b.filter){
                i=a.filter(i,b,function(l){
                    switch(b.filter.value){
                        case"lt5m": if(l.population<5000000){
                            return true
                        }
						break;
						case"gte5m": if(l.population>=5000000){
                            return true
						}
						break;
						default: return true;
						break
                    }
                })
            }
			
			var f=i.length;if(b.sortProperty){
                i=a.sortBy(i,b.sortProperty);
				if(b.sortDirection==="desc"){
                    i.reverse()
                }
            }
			var j=b.pageIndex*b.pageSize;
			var h=j+b.pageSize;
			var e=(h>f)?f: h;
			var d=Math.ceil(f/b.pageSize);
			var g=b.pageIndex+1;
			var k=j+1;i=i.slice(j,h);
			
			if(a._formatter){
                a._formatter(i)
            }c({
                data: i,
                start: k,
                end: e,
                count: f,
                pages: d,
                page: g
            })
        },
        this._delay)
    },
    filter: function(e,a,d){
        results=[
            
        ];
		if(e==null){
            return results
        }
		for(var f=e.length,b=0;b<f;b++){
            if(d(e[b])===true){
                results[results.length]=e[b]
            }
        }
		return results
    },
    sortBy: function(b,a){
        returnb.sort(function(d,c){
            if(d[a]<c[a]){
                return -1
            }
			if(d[a]>c[a]){
                return 1
            }
			return 0
        })
    }
};

var sampleData={geonames:[
    {
        "id": "68de73b4-2f3a-44ae-9ba8-905047d2f5af",
        "ticketid": "68de73b4-2f3a-44ae-9ba8-905047d2f5af",
        "ticketnumber": 1026,
        "ref": "",
        "tickettitle": "Scheduled server maintenance",
        "opendate": "March, 21 2015 01:23:29",
        "duedate": "March, 21 2015 01:23:29",
        "description": "TBC",
        "priorityid": 3,
        "statusid": 1,
        "isopen": true,
        "priority": "High",
        "status": "Not Started",
        "username": "demo@orcisurvey.com"
    },
    {
        "id": "1240793f-0313-4cb4-80c5-48d2094c2bf1",
        "ticketid": "1240793f-0313-4cb4-80c5-48d2094c2bf1",
        "ticketnumber": 1025,
        "ref": "",
        "tickettitle": "HelpDesk BETA testing",
        "opendate": "March, 21 2015 01:11:41",
        "duedate": "March, 21 2015 00:00:00",
        "description": "Alpha phase completed.",
        "priorityid": 2,
        "statusid": 4,
        "isopen": true,
        "priority": "Normal",
        "status": "PostPoned",
        "username": "demo@orcisurvey.com"
    },
    {
        "id": "aa4a8836-950a-41cc-8ec1-9c66ab84cab6",
        "ticketid": "aa4a8836-950a-41cc-8ec1-9c66ab84cab6",
        "ticketnumber": 1024,
        "ref": "",
        "tickettitle": "Mobile App vs Mobile Web Question",
        "opendate": "March, 21 2015 01:00:30",
        "duedate": "March, 21 2015 00:00:00",
        "description": 123456,
        "priorityid": 2,
        "statusid": 6,
        "isopen": true,
        "priority": "Normal",
        "status": "Pending",
        "username": "admin@orcisurvey.com"
    },
    {
        "id": "92e572e3-9756-4a2d-b4b2-86cfaa884058",
        "ticketid": "92e572e3-9756-4a2d-b4b2-86cfaa884058",
        "ticketnumber": 1023,
        "ref": "",
        "tickettitle": "Outlook Connectivity Issue",
        "opendate": "March, 21 2015 00:51:14",
        "duedate": "March, 21 2015 00:00:00",
        "description": "Urgent!!!",
        "priorityid": 3,
        "statusid": 2,
        "isopen": true,
        "priority": "High",
        "status": "In Progress",
        "username": "helpDesk"
    },
    {
        "id": "204a33b6-d34b-4b5f-b125-06903215b66b",
        "ticketid": "204a33b6-d34b-4b5f-b125-06903215b66b",
        "ticketnumber": 1022,
        "ref": "",
        "tickettitle": "IE8 issue",
        "opendate": "March, 21 2015 00:39:18",
        "duedate": "March, 21 2015 00:00:00",
        "description": "Browser compatibility",
        "priorityid": 1,
        "statusid": 5,
        "isopen": false,
        "priority": "Low",
        "status": "Canceled",
        "username": "admin@orcisurvey.com"
    },
    {
        "id": "ecb8f732-00f3-4b16-9a11-1cd81324c04a",
        "ticketid": "ecb8f732-00f3-4b16-9a11-1cd81324c04a",
        "ticketnumber": 1021,
        "ref": "",
        "tickettitle": "Server unavailable",
        "opendate": "March, 20 2015 22:26:38",
        "duedate": "March, 21 2015 00:00:00",
        "description": "Test by DEMO",
        "priorityid": 2,
        "statusid": 3,
        "isopen": false,
        "priority": "Normal",
        "status": "Completed",
        "username": "demo@orcisurvey.com"
    }
]};