<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />

	<title>Droppable Between Panes</title>

	<link type="text/css" href="css/ui.tabs.css" rel="stylesheet" />
  	<link type="text/css" href="css/ui.theme.css" rel="stylesheet" />
 	<link type="text/css" href="css/droppable-tabs.css" rel="stylesheet" />


	<script type="text/javascript" src="js/jquery-1.3.2.js"></script>
	<script type="text/javascript" src="js/jquery.layout.js"></script>
	<script type="text/javascript" src="js/custom.js"></script>
	<script type="text/javascript" src="js/ui.all-1.7.1.js"></script>


	<script>
	var outerLayout;

    var tabID;
	/*
	*#######################
	*		 ON PAGE LOAD
	*#######################
	*/
	$(document).ready( function() {



		// create the OUTER LAYOUT
		outerLayout = $("body").layout({

		});

		var $tabs = $('#tabs').tabs({
		    add: function(event, ui)
		    {
		        var self = this;
		        var selfId = $(this).attr('id');

		        if (ui.panel === undefined)
		        {
		        	alert("ui panel is undefined");
		        	if (ui.tab === undefined)
		        	{
		        		alert("ui tab is also undefined");

		        	}

		        	return false;
		        }

		        var id = ui.panel.id;

		    	var tagObj = $("#" + selfId + " li:has(a) a[href*='" + id + "']");

		    	var li_obj = $(tagObj).parent().closest('li');

		    	$(li_obj).attr('id',id + "-link");
		    	var count = -1;

		    	//Reset the indexes of all the new tabs
		    	 $(this).find("li:has(a)").each(function(i)
				 {
				    var tempId = $(this).attr('id');
				    count = count + 1;

	     			var newLi = $("#" + tempId );
	     			$(newLi).attr('custom:index', count);

	   			});

	   			//

		    }
		});

		var $tabs = $('#tabs1').tabs({
		    add: function(event, ui)
		    {
		        var self = this;
		        var selfId = $(this).attr('id');

		        if (ui.panel === undefined)
		        {
		        	alert("ui panel is undefined");
		        	if (ui.tab === undefined)
		        	{
		        		alert("ui tab is also undefined");

		        	}

		        	return false;
		        }

		        var id = ui.panel.id;

		    	var tagObj = $("#" + selfId + " li:has(a) a[href*='" + id + "']");

		    	var li_obj = $(tagObj).parent().closest('li');

		    	$(li_obj).attr('id',id + "-link");
		    	var count = -1;

		    	//Reset the indexes of all the new tabs
		    	 $(this).find("li:has(a)").each(function(i)
				 {
				    var tempId = $(this).attr('id');
				    count = count + 1;

	     			var newLi = $("#" + tempId );
	     			$(newLi).attr('custom:index', count);

	   			});
		    }
		});

		// init the Sortables
		$(".tabs").sortable({
			connectWith:	$(".tabs")
		,	placeholder:	'tabs-placeholder'
		,	cursor:			'move'
		//	use a helper-clone that is append to 'body' so is not 'contained' by a pane
		,	helper:			function (evt, ui) {

			var newObject = $(ui).clone(true);
			return newObject.appendTo('body').show();

		}
		,	over:			function (evt, ui) {
								var
									$target_UL	= $(ui.placeholder).parent()
								,	targetWidth	= $target_UL.width()
								,	helperWidth	= ui.helper.width()
								,	padding		= parseInt( ui.helper.css('paddingLeft') )
												+ parseInt( ui.helper.css('paddingRight') )
												+ parseInt( ui.helper.css('borderLeftWidth') )
												+ parseInt( ui.helper.css('borderRightWidth') )
								;
								//if (( (helperWidth + padding) - targetWidth ) > 20)
									ui.helper
										.height('auto')
										.width( targetWidth - padding )
									;
									var id = $(ui.item);

							}
		});



		$("#tabs").tabs();
		$("#tabs1").tabs();

		$("#body")
				.tabs({change: function () {}})
				.find(".ui-tabs-nav")
				.sortable({})
			;
		//Remove the tab content from parent and add to new parent
		$('#tabs1').droppable(
		{
		  //accept: "#divDrag",
		  drop:			function (ev, ui)
		   {

		    	//Set up variables
		    	var aObj = $(ui.draggable).closest('li').find('a');
			    var href = aObj.attr('href');
	  			var label = $(aObj).text();

	  			//Get the parent of the draggable item
	  			var parentDrag = $(ui.draggable).parent().parent();

	  			//Get the id of the tabs
			 	var divId = $(this).tabs().attr('id');

			 	//Get the current index of the tab in the panel
				var selected = $(ui.draggable).attr('custom:index');

				//Split the href value
				var hrefBase = href.split('#')[1], baseEl;
				//Create link to old text
				var $old = $("#" + hrefBase);
				//end set up variables

		  		//Remove the tab item, only after creating a link to old  text item
		  		parentDrag.tabs('remove',selected);

				//Get id of the place where text item shoudl be added
				var layoutId = $('#' + divId +' ul div').attr('id');
			 //alert("layout id " + layoutId);
			 	//Append the text item in new location
				var $newText = $old.appendTo('#' + layoutId);

				//Append the new tab
				$(this).tabs("add","#" + hrefBase,label);


				$newText.addClass('ui-tabs-hide');


		  }
		});



		//Remove the tab content from parent and add to new parent
		$('#tabs').droppable(
		{
		  	///accept: ".tabs",
		drop:			function (ev, ui)
		   {
		   		//alert("ui draggable " + $(ui.draggable).html());

		   		//Need to put in functionality for the widgets to be placed within tabs
				if(!$(ui.draggable).hasClass('.tabHeader'))
				{
					alert("this is not a tab header");
					return false;
				}

		   		var aObj = $(ui.draggable).closest('li').find('a');
			    var href = aObj.attr('href');
	  			var id =  $(ui.draggable).attr("id");

	  			var label = $(aObj).text();
	  			parentDrag = $(ui.draggable).parent().parent();
			    var parentId = parentDrag.attr('id');
			 	var divId = $(this).tabs().attr('id');

				var selected = $(ui.draggable).attr('custom:index');

				var hrefBase = href.split('#')[1], baseEl;

				var $old = $("#" + hrefBase);

		  		parentDrag.tabs('remove',selected);

				var layoutId = $('#' + divId +' ul div').attr('id');

			    var layoutChild = $('#' + divId +' ul div div').attr('id');
			 	//alert("layout id " + layoutId);

				var $newText = $old.appendTo('#' + layoutId);

				//var $newText = $('#' + layoutId).append($old);

				//$newText.removeClass('ui-tabs-selected ui-state-active');

				//alert("href base " + hrefBase);

				$(this).tabs("add","#" + hrefBase,label);

				//alert('in object' + $(this).tabs().text());
				//want to find the newly added tab
				//var newTabObj = $(this).tabs().find("li:has(a[href*='" + hrefBase + "'])");
				//newTagObj.attr('id', 'test');
				$newText.addClass('ui-tabs-hide');
				iNettuts.refresh();

			}

		});



	});

	</script>

</head>
<body>
<div id="head">
    </div>
<div class="ui-layout-center">
	<div id="tabs" >
	    <ul class="tabs" id ="test">

			<li custom:index="0" id="tabs-1-link" name="tabs-1" class="tabHeader"><a href="#tabs-1">Tab 1</a></li>
	        <li custom:index="1" id="tabs-2-link" name="tabs-2" class="tabHeader"><a href="#tabs-2">Tab 2</a></li>
	        <li custom:index="2" id="tabs-3-link" name="tabs-3" class="tabHeader"><a href="#tabs-3">Tab 3</a></li>

	    <!-- add wrapper that Layout will auto-size to 'fill space' -->
		    <div class="ui-layout-content" id="tabs-layout">

		        <div id="tabs-1" >
		        	<p>

					<div id="columns">

					        <div id="column1" class="column">
					            <div class="widget color-green" id="intro">
					                <div class="widget-head">
					                    <h3>Introduction Widget</h3>
					                </div>
					                <div class="widget-content">
					                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam magna sem, fringilla in, commodo a, rutrum ut, massa. Donec id nibh eu dui auctor tempor. Morbi laoreet eleifend dolor. Suspendisse pede odio, accumsan vitae, auctor non, suscipit at, ipsum. Cras varius sapien vel lectus.</p>
					                </div>
					            </div>
					        </div>
					        Should be a frame here
					        <c:import url="http://127.0.0.1:8080/medcafe/c/patient/1"/>
					        <%-- <div id="aaa"></div>
					        <script type="text/javascript">
					            $("#aaa").load("http://127.0.0.1:8080/medcafe/c/patient/1");
					        </script> --%>
					        <%--
					        <c:catch var="exception">
                              <c:import url="ftp://ftp.example.com/package/README"/>
                            </c:catch>
                            <c:if test="${not empty exception}">
                              Sorry, the remote content is not currently available.
                            </c:if>
                            --%>
					    </div>

					</p>
		        </div>
		        <div id="tabs-2" >
		        	<p>
		        	<div id="columns">
			        	<div id="column2" class="column">
					        <div class="widget color-red">
				                <div class="widget-head">
				                    <h3>Widget title</h3>
				                </div>
				                <div class="widget-content">
				                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam magna sem, fringilla in, commodo a, rutrum ut, massa. Donec id nibh eu dui auctor tempor. Morbi laoreet eleifend dolor. Suspendisse pede odio, accumsan vitae, auctor non, suscipit at, ipsum. Cras varius sapien vel lectus.</p>
				                </div>
		            		</div>
	            		 </div>

					</div>
		        	</p>
		        </div>
		        <div id="tabs-3" >
		        <p>

				<div id="columns">
					<div id="column3" class="column">
			            <div class="widget color-blue">
			                <div class="widget-head">
			                    <h3>Widget title</h3>
			                </div>
			                <div class="widget-content">
			                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam magna sem, fringilla in, commodo a, rutrum ut, massa. Donec id nibh eu dui auctor tempor. Morbi laoreet eleifend dolor. Suspendisse pede odio, accumsan vitae, auctor non, suscipit at, ipsum. Cras varius sapien vel lectus.</p>
			                </div>
			            </div>
		            </div>
	        	</div>

				</p>
		        </div>
		    </div>
    	</ul>
    </div>


</div>



<div class="ui-layout-east">
<h3>East Pane</h3>

	<div id="tabs1">
	    <ul class="tabs">

			<li custom:index="0" id="tabs-4-link" name="tabs-4"><a href="#tabs-4">Tab 4</a></li>
	        <li custom:index="1" id="tabs-5-link" name="tabs-5"><a href="#tabs-5">Tab 5</a></li>
	        <li custom:index="2" id="tabs-6-link" name="tabs-6"><a href="#tabs-6">Tab 6</a></li>

	    <!-- add wrapper that Layout will auto-size to 'fill space' -->
		    <div class="ui-layout-content" id="tabs-layout1">

		     <div id="tabs-4" >
		       <p>Proin elit arcu, rutrum commodo, vehicula tempus,</p>
		       		 </div>

		     <div id="tabs-5" >
		        	<p>Morbi tincidunt, dui sit amet facilisis feugiat, </p>
		        </div>
		        <div id="tabs-6" >
		        <p>Mauris eleifend est et turpis. Duis id erat. Suspendisse potenti. </p>
		        </div>
		    </div>
	  </ul>
    </div>
</div>


<div class="ui-layout-west">
 					<div id="columns">

					        <div id="column1" class="column">
					            <div class="widget color-red" id="intro">
					                <div class="widget-head">
					                    <h3>Introduction Widget</h3>
					                </div>
					                <div class="widget-content">
					                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam magna sem, fringilla in, commodo a, rutrum ut, massa. Donec id nibh eu dui auctor tempor. Morbi laoreet eleifend dolor. Suspendisse pede odio, accumsan vitae, auctor non, suscipit at, ipsum. Cras varius sapien vel lectus.</p>
					                </div>
					            </div>
					        </div>

					    </div>
</div>
</div>


<div class="ui-layout-north">


<div class="ui-layout-south">South</div>

</body>
		<script type="text/javascript" src="../js/widgets/inettuts.js"></script>
     	<link href="css/inettuts.css" rel="stylesheet" type="text/css" />
</html>