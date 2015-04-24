<!DOCTYPE html>
<html>
	<head>
	  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	  <script src="http://code.highcharts.com/highcharts.js"></script>
	  <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed' rel='stylesheet' type='text/css'>
	  <script type="text/javascript">
	  
		  var resultMale = [];
		  var resultFemale = [];
		  var yearWiseData = [];
		  var states = ["AN Islands","Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chandigarh","Chhattisgarh","D-N Haveli","Daman-Diu","Delhi UT","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu-Kashmir","Jharkhand","Karnataka","Kerala","Lakshadweep","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Puducherry","Punjab","Rajasthan","Sikkim","Tamil Nadu","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"]
		  
		  function visualizeData()
		  {
			if($("#graphType").val() == 1)	{
			
				$("#stateName").remove();
				
				$('#container').highcharts({
					chart: {
						type: 'column',
						zoomType: 'xy' 
					},
					title: {
						text: 'State-Wise distribution of crimes in India against Males and Females from 2001 to 2012'
					},
					xAxis: {
						categories: ['AN','AP','AR','AS','BR','CH','CG','DN','DD','Delhi UT','GA','GJ','HR','HP','JK','JH','KA','KL','LD','MP','MH','MN','ML','MZ','NL','OD','PY','PB','RJ','SK','TN','TR','UP','UK','WB'	]
					},
					yAxis: {
						min: 0,
						title: {
							text: 'Total number of crimes'
						},
						stackLabels: {
							enabled: true,
							style: {
								fontWeight: 'bold',
								color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
							}
						}
					},
					legend: {
						align: 'right',
						x: -70,
						verticalAlign: 'top',
						y: 20,
						floating: true,
						backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
						borderColor: '#CCC',
						borderWidth: 1,
						shadow: false
					},
					tooltip: {
						formatter: function () {
							return '<b>' + this.x + '</b><br/>' +
								this.series.name + ': ' + this.y + '<br/>' +
								'Total: ' + this.point.stackTotal;
						}
					},
					plotOptions: {
						column: {
							stacking: 'normal',
							dataLabels: {
								enabled: true,
								color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
								style: {
									textShadow: '0 0 3px black, 0 0 3px black'
								}
							}
						}
					},
					series: [{
						name: 'Male',
						data: resultMale
					},
					{
						name: 'Female',
						data: resultFemale
					}]
				});
			}
			
			else if($("#graphType").val() == 2)	{
			
				$("#stateName").remove();
				
				$('#container').highcharts({
					chart: {
						plotBackgroundColor: null,
						plotBorderWidth: 1,//null,
						plotShadow: false
					},
					title: {
						text: 'Year-Wise crime distribution in India from 2001 to 2012'
					},
					tooltip: {
						pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
					},
					plotOptions: {
						pie: {
							allowPointSelect: true,
							cursor: 'pointer',
							dataLabels: {
								enabled: true,
								format: '<b>{point.name}</b>: {point.percentage:.1f} %',
								style: {
									color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
								}
							}
						}
					},
					series: [{
						type: 'pie',
						name: 'Browser share',
						data: [
							['2001', yearWiseData[0]],
							['2002', yearWiseData[1]],
							{
								name: '2003',
								y: yearWiseData[2],
								sliced: true,
								selected: true
							},
							['2004',yearWiseData[3]],
							['2005',yearWiseData[4]],
							['2006',yearWiseData[5]],
							['2007',yearWiseData[6]],
							['2008',yearWiseData[7]],
							['2009',yearWiseData[8]],
							['2010',yearWiseData[9]],
							['2011',yearWiseData[10]],
							['2012',yearWiseData[11]]
						]
					}]
				});
			}
			
			else if($("#graphType").val() == 3)	{
			
				$("#stateName").remove();
				
				var html = "<select id='stateName' onchange='javascript:visualizeStateWiseData()'>"
				html += "<option value='selectState'>Select State</option>";
				
				for(var i=0;i<states.length;++i)	{
					html += "<option value='" + states[i] + "'>";
					html += states[i];
					html += "</option>";
				}
				
				html += "</select>";
				
				$("#option").append(html);
				
				//alert(html);
			}
		  }
		  
		  function visualizeStateWiseData()	{
		  
			var selectedVal = $("#stateName").val();
			var resultSet = [];
			
			//alert(selectedVal);
			
			// run ajax request
			$.ajax({
				type: "GET",
				dataType : "json",
				cache : false,
				url: "stateWiseCrime.cfm?state=" + selectedVal,
				success: function (data) {
			
					for(var i=0;i<data.DATA.SUM.length;++i)	{
						resultSet[i] = data.DATA.SUM[i];
					}
					
					$('#container').highcharts({
						chart: {
							type: 'column'
						},
						title: {
							text: 'Year-Wise distribution of crimes in the Indian State/UT of ' + selectedVal
						},
						xAxis: {
							title: {
								text: 'Year'
							},
							categories: [
								'2001',
								'2002',
								'2003',
								'2004',
								'2005',
								'2006',
								'2007',
								'2008',
								'2009',
								'2010',
								'2011',
								'2012'
							]
						},
						yAxis: {
							min: 0,
							title: {
								text: 'Total number of crimes'
							}
						},
						tooltip: {
							headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
							pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
								'<td style="padding:0"><b>{point.y:.0f}</b></td></tr>',
							footerFormat: '</table>',
							shared: true,
							useHTML: true
						},
						plotOptions: {
							column: {
								pointPadding: 0.2,
								borderWidth: 0
							}
						},
						series: [{
							name: 'Crimes',
							data: resultSet
						}]
					});
				}
			});
		  }
		  
		  $(function () {
		  
			// run ajax request
			$.ajax({
				type: "GET",
				dataType : "json",
				cache : false,
				url: "crimesAgainstMale.cfm",
				success: function (data) {
			
					for(var i=0;i<data.DATA.SUM.length;++i)	{
						resultMale[i] = data.DATA.SUM[i];
					}
				}
			});
			
			// run ajax request
			$.ajax({
				type: "GET",
				dataType : "json",
				cache : false,
				url: "crimesAgainstFemale.cfm",
				success: function (data) {
			
					for(var i=0;i<data.DATA.SUM.length;++i)	{
						resultFemale[i] = data.DATA.SUM[i];
					}
				}
			});
			
			// run ajax request
			$.ajax({
				type: "GET",
				dataType : "json",
				cache : false,
				url: "yearWiseCrime.cfm",
				success: function (data) {
			
					for(var i=0;i<data.DATA.SUM.length;++i)	{
						yearWiseData[i] = data.DATA.SUM[i];
					}
				}
			});
			
			//alert(result[0]);
		});
	</script>
	</head>
	<body>
		<h2 style="font-family: 'Roboto Condensed', sans-serif;">Highcharts in Action</h2>
		<div id="option">
			<span style="font-family: 'Roboto Condensed', sans-serif;">Choose : &nbsp; </span>
				<select onchange="javascript:visualizeData()" id="graphType">
					<option value="">Select</option>
					<option value="1">Visualization 1</option>
					<option value="2">Visualization 2</option>
					<option value="3">Visualization 3</option>
				</select> &nbsp;
		</div>
		<div id="container" style="height:600px">
		</div>
	</body>
</html>
	

	