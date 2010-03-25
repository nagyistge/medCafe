
$.fn.dataTableExt.oApi.fnDataUpdate = function  ( oSettings, nRowObject, iRowIndex )
{
	var dataRow = oSettings.aoData[iRowIndex]._aData;
        $(nRowObject).find("TD").each( function(i) {
      dataRow[i] = $(this).html();
    } );
}

function fnClickAddRow(tableObj, patient_id) {
	
		var aRows = tableObj.fnGetNodes();	
		var rowNum = aRows.length;
		var row = tableObj.fnAddData( ['name','url','description']);
		makeEditable(tableObj, patient_id);
		var aData = tableObj.fnGetData( row );
		
}
	
function fnClickDeleteRow(tableObj, selectedRow) 
{
		
		var aData  = tableObj.fnDeleteRow(selectedRow, '',true);
		var oSettings = tableObj.fnSettings();
		
		
		//try to delete actual row
		//oSettings.aoData[selectedRow] = null;
		//var aTrs = tableObj.fnGetNodes();	
		//alert( "no of rows  " + aTrs.length);
		
		//return true;
}
//Cycle through each row and save the data
function gatherData(tableObj, patient_id) 
{

		
		var aData = tableObj.fnGetData();
		var paramStr = "";
		for ( var i=0 ; i<aData.length ; i++ )
		{
			
			var rowData = aData[i];
			
			//If row was deleted then skip
			if (aData[i] == null)
			{
				continue;
			}
			//new rows will be dealt with seperately
			var pos = aData[i][0].indexOf("<input");

			if (aData[i][0].indexOf("<input") > -1)
			{
			  paramStr = paramStr + processInput(aData[i], i);
			}
			else
			{
				paramStr = paramStr + "&name" + i + "=" +  aData[i][0] + "&url"+  i+ "=" + aData[i][1] + "&desc"+  i+ "=" + aData[i][2] ;
			}
		}
		
		var action = "saveBookmarks.jsp?action=Save&patient=" + patient_id;
		action = action + paramStr;
		alert("action " + action); 
		$.post(action, function(){
  			//alert("done");
		});
		 
			 			
}

function processInput(aData, row_num)
{
	
	alert("Process input " + row_num);
	var name = "";
	var url = "";
	var desc = "";
	if (aData[0] != null)
	{		
		name = aData[0];
		alert("aData " + name);
	}
	if (aData[1] != null)
	{
		url = $(aData[1]).serialize();
	}
	if (aData[2] != null)
	{
		desc = $(aData[2]).serialize();
	}
	var paramStr =  "&" + name + "&"+  url + "&" + desc ;
	alert("Process input paramStr " + paramStr);
	return "";
	//return paramStr;
}
function addBookmarks(callObj, server, tab_num, label, patient_id, repId)
{
		//var onSubmit = 'onSubmit="$('#test').load('saveBookmarks.jsp?patient_id=<%=patient_id%>')'';"
		var html = "<div class=\"bookmarks" +  patient_id + "\"></div>"; 
		
		$(callObj).delay(200,function()
		{
			
			 	iNettuts.refresh("yellow-widget" + tab_num);
				
				var serverLink =  server + "?repository=" + repId + "&patient_id=" + patient_id;
				$.getJSON(serverLink, function(data)
				{
				
						var html = v2js_listPatientsBookmarksTable( data );  
						
						var tableObj;
						var selectedRow=0;		
						$("#aaa" + tab_num).append(html);
	  										
						//alert( $("#example" + repId).text());
						 	tableObj = $("#bookmarks" + patient_id).dataTable( {
								"aaSorting": [[ 0, "desc" ]]
								,"bJQueryUI": true
								,"fnDrawCallback": function() {
						           
						        }
						} );
					
						//Add a button to add a new Row
						var buttonText = '<p><button type="button" id="addRowButton">Add Row</button><button type="button" id="deleteRowButton">Delete Row</button></p>';
						$("#bookmarks" + patient_id).append(buttonText);

						//Make sure that values are updated in the tableObj
						makeEditable(tableObj, patient_id);

						//Get the selected row if user clicks on <tr> object	 
						$("#bookmarks" + patient_id + " tbody tr").click( function() {
						
							var aPos = tableObj.fnGetPosition( this );
							selectedRow = aPos;
						});
						
						//Get the selected row if user clicks on <td> object
						$("#bookmarks" + patient_id + " tbody td").click( function() {
						
							var aPos = tableObj.fnGetPosition( this );
							selectedRow = aPos[0];
						});
						
						$("#addRowButton").bind("click",{table:tableObj},
								function(e)
								{
									fnClickAddRow(tableObj, patient_id);
								
								});
								
						$("#deleteRowButton").bind("click",{table:tableObj},
								function(e)
								{
									fnClickDeleteRow(tableObj, selectedRow);	
								});
										
						//Put in code to call saveData		
						$('#bookmarkForm' + patient_id).submit( function() {
							
							gatherData(tableObj, patient_id);
							return false;
						} );
			
						setHasContent(tab_num);
						
					} );
					setHasContent(tab_num);
		});
		
}

function makeEditable(tableObj, patient_id)
{
	$("#bookmarks" + patient_id + " tbody td").editable( 
		function(value, settings)
		{ 
			var aPos = tableObj.fnGetPosition( this );
			tableObj.fnUpdate( value, aPos[0], aPos[1] );
		},
		{
			"height": "14px",
			submit: 'enter'
		});
				
}