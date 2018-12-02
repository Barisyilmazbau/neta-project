<!DOCTYPE html>
 <html>
   <head>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
     <style>
 * {box-sizing: border-box;}
 ul {list-style-type: none;}
 body {font-family: Verdana, sans-serif;}
 .month {
     padding: 70px 25px;
     width: 100%;
     background: #1abc9c;
     text-align: center;
 }
 .month ul {
     margin: 0;
     padding: 0;
 }
 .month ul li {
     color: white;
     font-size: 20px;
     text-transform: uppercase;
     letter-spacing: 3px;
 }
 .month .prev {
     float: left;
     padding-top: 10px;
 }
 .month .next {
     float: right;
     padding-top: 10px;
 }
 .weekdays {
     margin: 0;
     padding: 10px 0;
     background-color: #ddd;
 }
 .weekdays li {
     display: inline-block;
     width: 13.6%;
     color: #666;
     text-align: center;
 }
 .days {
     padding: 10px 0;
     background: #eee;
     margin: 0;
 }
 .days li {
     display: inline-block;
     width: 22%;
     text-align: center;
     margin-bottom: 5px;
     margin-top:5px;
     font-size:12px;
     color: #777;
 }
 .days li .active {
     padding: 5px;
     background: #1abc9c;
     color: white !important
 }
 /* Add media queries for smaller screens */
 @media screen and (max-width:720px) {
     .weekdays li, .days li {width: 13.1%;}
 }
 @media screen and (max-width: 420px) {
     .weekdays li, .days li {width: 12.5%;}
     .days li .active {padding: 2px;}
 }
 @media screen and (max-width: 290px) {
     .weekdays li, .days li {width: 12.2%;}
 }
 </style>
     
     <title>Bil495Calendar</title>
     <%= csrf_meta_tags %>
     <%= csp_meta_tag %>
 
     <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
     <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
   </head>
 
   <body>
   
     <%= yield %>
 	
     <div class="month">      
     <ul>
       <li class="prev" onClick=(changeMonth(0))>&#10094;</li>
       <li class="next" onClick=(changeMonth(1))>&#10095;</li>
      <li id="month">
      <script>
      
        	var months=["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"];
        	var months=["","JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"];
        	var currentDate = new Date(); 
			currentMonth= currentDate.getMonth();
			currentMonth= currentDate.getMonth()+1;
			currentYear= currentDate.getFullYear();
      		function changeMonth(index){
      			if(index==0){
      				document.getElementById("month").innerHTML = getPreviousMonth() + " " + currentYear;
					document.getElementById("days").innerHTML=Days();
					document.getElementById("days").innerHTML= drawDays();
      			}
      			else{
      				document.getElementById("month").innerHTML = getNextMonth() + " " + currentYear;
					document.getElementById("days").innerHTML=Days();
					document.getElementById("days").innerHTML= drawDays();
      			}
      		}
    		function getCurrentMonth(){
	 			 return months[currentMonth];
    		}
    		function getPreviousMonth(){
    			if(currentMonth!=0)
    			if(currentMonth!=1)
    				currentMonth-=1;
				else{
					currentMonth=11;
					currentMonth=12;
					currentYear-=1;
				}
    			return months[currentMonth];
    		}
    		function getNextMonth(){
    			if(currentMonth!=11)
    			if(currentMonth!=12)
    				currentMonth+=1;
				else{
					currentMonth=0;
					currentMonth=1;
					currentYear+=1;
				}
    			return months[currentMonth];
@@ -146,46 +146,124 @@ body {font-family: Verdana, sans-serif;}
  }
   jsonObject=JSON.parse(GetJSON(window.location.origin + '/appointments.json'));
  
  var monthToDaysMap = new Map();
  monthToDaysMap.set(1, 31);
  monthToDaysMap.set(2, 28);
  monthToDaysMap.set(3, 31);
  monthToDaysMap.set(4, 30);
  monthToDaysMap.set(5, 31);
  monthToDaysMap.set(6, 30);
  monthToDaysMap.set(7, 31);
  monthToDaysMap.set(8, 31);
  monthToDaysMap.set(9, 30);
  monthToDaysMap.set(10, 31);
  monthToDaysMap.set(11, 30);
  monthToDaysMap.set(12, 31);
   function Days(){
  function drawDays(){
    var d='';
    
    for(i=1;i<32;i++){
      d=d+'<li id='+i+' onclick=\"showApps(currentYear, currentMonth+1, id)\">'+i;
	
    for(i=1;i<=getDaysOfMonth(currentMonth,currentYear);i++){
      d=d+'<li id='+i+' onclick=\"showApps(Number(id), Number(currentMonth), Number(currentYear))\">'+i;
      var y;
      for(y=0;y<jsonObject.length;y++){
        if( 
		( jsonObject[y].date.substring(8,10)==i || ((i > Number(jsonObject[y].date.substring(8,10))) 
		&& (i - Number(jsonObject[y].date.substring(8,10))) % jsonObject[y].recurseDays == 0) )
		&& Number(jsonObject[y].date.substring(5,7))==currentMonth + 1 && jsonObject[y].date.substring(0,4)==currentYear){
      for(y=0;y<jsonObject.length;y++)
	  {
		var appointDay = getAppointDay(y);
		var appointMonth = getAppointMonth(y);
		var appointYear = getAppointYear(y);
        if
		( 
			(
				( appointDay==i 
				||	(
						(i > appointDay) 
						&& (i - appointDay) % jsonObject[y].recurseDays == 0
					)
				)
				&& appointMonth==currentMonth
				&& appointYear==currentYear
			)
			|| jsonObject[y].recurseDays > 0
				&& dayHasPastRecursiveAppoint(i,currentMonth,currentYear, appointDay, appointMonth, appointYear, jsonObject[y].recurseDays)
		)
		{
          d= d+"#";
        }
        
      }
      d=d+'</li>';   
    } 
    return d;
  }
   document.getElementById("days").innerHTML=Days();
   function showApps(year,month,day){
      var result='';
      for(var y=0;y<jsonObject.length;y++){
        if(jsonObject[y].recursive){
            if(Number(jsonObject[y].date.substring(8,10))<=day && Number(jsonObject[y].date.substring(5,7))==month && Number(jsonObject[y].date.substring(0,4))==year
                && (day - jsonObject[y].date.substring(8,10)) % jsonObject[y].recurseDays==0){
              result+=jsonObject[y].date.substring(11,16)+"--"+jsonObject[y].description+'\n';
            }
  function dayHasPastRecursiveAppoint(day, month, year, appointDay, appointMonth, appointYear, recurse)
  { 
	var dayTotal = 0;
	if (appointYear<year || (appointYear==year && appointMonth<month))
		{
			var i = appointMonth;
			var j = appointYear;
			while((i!=month) || (j!=year))
			{
				if (i == appointMonth && j == appointYear)
					dayTotal += (getDaysOfMonth(appointMonth,appointYear) - appointDay);
				else
					dayTotal += getDaysOfMonth(i,j);
									
				i++;
								
				if(i == 13)
				{
					i = 1;
					j++;
				}
			}
			dayTotal += day;
			
			return ((dayTotal%recurse) == 0)
		}
	else return false;
  }
	
document.getElementById("days").innerHTML= drawDays();
  
  function showApps(day,month,year)
  {
	var result='';
    for(var y=0;y<jsonObject.length;y++)
	{
		var appointDay = getAppointDay(y);
		var appointMonth = getAppointMonth(y);
		var appointYear = getAppointYear(y);
		
		if
		(
			(
				appointDay==day 
				&& appointMonth==month
				&& appointYear==year
			)				
			||
			(
				jsonObject[y].recursive
				&&
				(
					appointDay<=day 
					&& appointMonth==month
					&& appointYear==year
					&& (day - appointDay) % jsonObject[y].recurseDays==0
				)
				||
				(
					dayHasPastRecursiveAppoint(day, month, year, appointDay, appointMonth, appointYear, jsonObject[y].recurseDays)
				)
			)
		)
		{
			result+=getAppointTime(y)+"--"+jsonObject[y].description+'\n';
        }
        else{
            if(Number(jsonObject[y].date.substring(8,10))==day && Number(jsonObject[y].date.substring(5,7))==month && Number(jsonObject[y].date.substring(0,4))==year){
                result+=jsonObject[y].date.substring(11,16)+"--"+jsonObject[y].description+'\n';    
            }
        } 
      }
      alert(result);
      console.log(year+" "+month+" "+day);
	}	
    alert(result); 
  }
   function search(keyword){
@@ -205,6 +283,29 @@ body {font-family: Verdana, sans-serif;}
      };
      xhttp.send(data)
  }
  
  function getAppointDay(y) {
	return Number(jsonObject[y].date.substring(8,10));
  }
  
  function getAppointMonth(y) {
	return Number(jsonObject[y].date.substring(5,7));
  }
  
  function getAppointYear(y) {
	return Number(jsonObject[y].date.substring(0,4));
  }
  
  function getAppointTime(y) {
	return jsonObject[y].date.substring(11,16);
  }
  
  function getDaysOfMonth(month,year){
	if( month == 2 && (year%4) == 0)
		return 29;
	else
		return monthToDaysMap.get(month);	
  }
   </script>
    </ul>
 
   <form onsubmit = "search(keyword.value);return false">
       Search:<br>
       <input type = "text" name = "keyword" value = "Enter a keyword to search">
       <input type = "submit" value = "Submit">
   </form> 
 
   </body>
  
   
 </html>
