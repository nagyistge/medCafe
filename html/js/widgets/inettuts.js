/*
 * Script from NETTUTS.com [by James Padolsey]
 * @requires jQuery($), jQuery UI & sortable/draggable UI modules
 */

var iNettuts = {
    
    jQueryWidgets : $,
  
    settings : {
        columns : '.column',
        widgetSelector: '.widget',
        handleSelector: '.widget-head',
        contentSelector: '.widget-content',
        widgetDefault : {
            movable: true,
            removable: true,
            collapsible: true,
            editable: true,
            resizable: true,
            colorClasses : ['color-1', 'color-2', 'color-3', 'color-4', 'color-5', 'color-6']
        },
        widgetIndividual : {
            intro : {
                movable: false,
                removable: false,
                collapsible: false,
                editable: false,
                resizable: true
            }
        }
    },

    init : function () {
    	
        this.attachStylesheet('css/inettuts.js.css');
        this.addWidgetControls();
        this.makeSortable();
    },
    
    getWidgetSettings : function (id) {
    
        var $ = this.jQueryWidgets,
            settings = this.settings;
        return (id&&settings.widgetIndividual[id]) ? $.extend({},settings.widgetDefault,settings.widgetIndividual[id]) : settings.widgetDefault;
    },
    
    addWidgetControls : function () {
       
        
        var iNettuts = this,
            $ = this.jQueryWidgets,
            settings = this.settings;
        $(settings.widgetSelector, $(settings.columns)).each(function () {
      
      		//alert('widget id ' + this.id);
            var thisWidgetSettings = iNettuts.getWidgetSettings(this.id);
            if (thisWidgetSettings.removable) {
            
                $('<a href="#" class="remove">CLOSE</a>').mousedown(function (e) {
                    e.stopPropagation();    
                }).click(function () {
                    if(confirm('This widget will be removed, ok?')) {
                        $(this).parents(settings.widgetSelector).animate({
                            opacity: 0    
                        },function () {
                            $(this).wrap('<div/>').parent().slideUp(function () {
                                $(this).remove();
                            });
                        });
                    }
                    return false;
                }).appendTo($(settings.handleSelector, this));
            }
            
            if (thisWidgetSettings.editable) {
            	
                $('<a href="#" class="edit">EDIT</a>').mousedown(function (e) {
                    e.stopPropagation();    
                }).toggle(function () {
                	var test = $(this).css({backgroundPosition: '-66px 0', width: '55px'})
                        .parents(settings.widgetSelector);
                	
                    $(this).css({backgroundPosition: '-66px 0', width: '55px'})
                        .parents(settings.widgetSelector)
                            .find('.edit-box').show().find('input').focus();
                    return false;
                },function () {
                    $(this).css({backgroundPosition: '', width: ''})
                        .parents(settings.widgetSelector)
                            .find('.edit-box').hide();
                    return false;
                }).appendTo($(settings.handleSelector,this));
                $('<div class="edit-box" style="display:none;"/>')
                    .append('<ul><li class="item"><label>Change the title?</label><input value="' + $('h3',this).text() + '"/></li>')
                    .append((function(){
                        var colorList = '<li class="item"><label>Available colors:</label><ul class="colors">';
                        $(thisWidgetSettings.colorClasses).each(function () {
                            colorList += '<li class="' + this + '"/>';
                        });
                        return colorList + '</ul>';
                    })())
                    .append('</ul>')
                    .insertAfter($(settings.handleSelector,this));
            }
            
            if (thisWidgetSettings.collapsible) {
                $('<a href="#" class="collapse">COLLAPSE</a>').mousedown(function (e) {
                    e.stopPropagation();    
                }).toggle(function () {
                    $(this).css({backgroundPosition: '-38px 0'})
                        .parents(settings.widgetSelector)
                            .find(settings.contentSelector).hide();
                    return false;
                },function () {
                    $(this).css({backgroundPosition: ''})
                        .parents(settings.widgetSelector)
                            .find(settings.contentSelector).show();
                    return false;
                }).prependTo($(settings.handleSelector,this));
            }
            
              if (thisWidgetSettings.resizable) {
	            	var test = $(settings.handleSelector,this);
	            	var resizeButton = $(test).find('.maximize');
	            	//alert('test close parent ' + $(test).text());
	                $(resizeButton).mousedown(function (e) {
	                    e.stopPropagation();    
	                }).click(function () {
	                    
						displayDialog(tabNum);
	                    
	                    return false;
	                });
	            }
        });
        
        $('.edit-box').each(function () {
            $('input',this).keyup(function () {
                $(this).parents(settings.widgetSelector).find('h3').text( $(this).val().length>20 ? $(this).val().substr(0,20)+'...' : $(this).val() );
            });
            $('ul.colors li',this).click(function () {
                
                var colorStylePattern = /\bcolor-[\w]{1,}\b/,
                    thisWidgetColorClass = $(this).parents(settings.widgetSelector).attr('class').match(colorStylePattern)
                if (thisWidgetColorClass) {
                    $(this).parents(settings.widgetSelector)
                        .removeClass(thisWidgetColorClass[0])
                        .addClass($(this).attr('class').match(colorStylePattern)[0]);
                }
                return false;
                
            });
        });
        
    },
    
    refresh : function (id) {
       
        var iNettuts = this,
            $ = this.jQueryWidgets,
            settings = this.settings;
            
        $(settings.widgetSelector, $(settings.columns)).each(function () {
      
	      	//alert("this id " + this.id);
	      	//Only refresh for the recently moved tab
	      	if (this.id === id)
	      	{
	            var thisWidgetSettings = iNettuts.getWidgetSettings(this.id);
	      
	        	if (thisWidgetSettings.editable) {
	            	
	            	//Want to be able to identify the <a> and refresh the method - without readding
	            	var test = $(settings.handleSelector,this);
	            
	            	var widgetId = $(test).attr('id');
	      		
	            	var editButton = $(test).find('.edit');
	           
	                var events = $(editButton).data("events");
	                //
	                var tabNum = id.substring("yellow-widget".length,id.length);
	                
	                $(editButton).mousedown().toggle(function(){
		                     
		                    $(this).css({backgroundPosition: '-66px 0', width: '55px'})
		                        .parents(settings.widgetSelector)
		                            .find('.edit-box').show().find('input').focus();
		                    return true;
		                },function () {
		                  
		                    $(this).css({backgroundPosition: '', width: ''})
		                        .parents(settings.widgetSelector)
		                            .find('.edit-box').hide();
		                    return false;
		                });
	                //});
	            }
	      
	            if (thisWidgetSettings.removable) {
	            	var test = $(settings.handleSelector,this);
	            	var closeButton = $(test).find('.remove');
	            	//alert('test close parent ' + $(test).text());
	                $(closeButton).mousedown(function (e) {
	                    e.stopPropagation();    
	                }).click(function () {
	                    if(confirm('This widget will be removed, ok?')) {
	                        $(this).parents(settings.widgetSelector).animate({
	                            opacity: 0    
	                        },function () {
	                            $(this).wrap('<div/>').parent().slideUp(function () {
	                                $(this).remove();
	                            });
	                        });
	                    }
	                    return false;
	                });
	            }
	            
	            if (thisWidgetSettings.resizable) {
	            	var test = $(settings.handleSelector,this);
	            	var resizeButton = $(test).find('.maximize');
	            	//alert('test close parent ' + $(test).text());
	                $(resizeButton).mousedown(function (e) {
	                    e.stopPropagation();    
	                }).click(function () {
	                    
						displayDialog(tabNum);
	                    
	                    return false;
	                });
	            }
	          
	            
	            if (thisWidgetSettings.collapsible) {
	            	var test = $(settings.handleSelector,this);
	            	var collapseButton = $(test).find('.collapse');
	            	
	                $(collapseButton).mousedown(function (e) {
	                	
	                    e.stopPropagation();    
	                   
	                }).toggle(function () {
	                    $(this).css({backgroundPosition: '-38px 0'})
	                        .parents(settings.widgetSelector)
	                            .find(settings.contentSelector).hide();
	                    return false;
	                },function () {
	                    $(this).css({backgroundPosition: ''})
	                        .parents(settings.widgetSelector)
	                            .find(settings.contentSelector).show();
	                    return false;
	                });
	            }
            
            }
        });
        
        $('.edit-box').each(function () {
            $('input',this).keyup(function () {
                $(this).parents(settings.widgetSelector).find('h3').text( $(this).val().length>20 ? $(this).val().substr(0,20)+'...' : $(this).val() );
            });
            $('ul.colors li',this).click(function () {
                
                var colorStylePattern = /\bcolor-[\w]{1,}\b/,
                    thisWidgetColorClass = $(this).parents(settings.widgetSelector).attr('class').match(colorStylePattern)
                if (thisWidgetColorClass) {
                    $(this).parents(settings.widgetSelector)
                        .removeClass(thisWidgetColorClass[0])
                        .addClass($(this).attr('class').match(colorStylePattern)[0]);
                }
                return false;
                
            });
        });
        
    },
    
    attachStylesheet : function (href) {
        var $ = this.jQueryWidgets;
        return $('<link href="' + href + '" rel="stylesheet" type="text/css" />').appendTo('head');
    },
    
    makeSortable : function () {
        var iNettuts = this,
            $ = this.jQueryWidgets,
            settings = this.settings,
            $sortableItems = (function () {
                var notSortable = '';
                $(settings.widgetSelector,$(settings.columns)).each(function (i) {
                    if (!iNettuts.getWidgetSettings(this.id).movable) {
                        if(!this.id) {
                            this.id = 'widget-no-id-' + i;
                        }
                        notSortable += '#' + this.id + ',';
                    }
                });
                /*var notSort = $('> div:not(' + notSortable + ')', settings.columns);
                $('> div:not(' + notSortable + ')', settings.columns).each(function (i) 
                {
                	alert("the following are sortable " + $(this).attr('id'));
                });*/
                return $('> div:not(' + notSortable + ')', settings.columns);
            })();
        
        $sortableItems.find(settings.handleSelector).css({
            cursor: 'move'
        }).mousedown(function (e) {
            $sortableItems.css({width:''});
            $(this).parent().css({
                width: $(this).parent().width() + 'px'
            });
            
        }).mouseup(function () {
        
            if(!$(this).parent().hasClass('dragIcon')) {
                $(this).parent().css({height:'', width:''});     
            } else {
                $(settings.columns).sortable('disable');
            }
        });
       
        $(settings.columns).sortable({
            items: $sortableItems,
            connectWith: $(settings.columns),
            handle: settings.handleSelector,
            placeholder: 'widget-placeholder',
            forcePlaceholderSize: true,
            revert: 300,
            delay: 100,
            opacity: 0.8,
            containment: 'document',
            start: function (e,ui) {
                $(ui.helper).addClass('dragIcon');
                //Hide the content for dragging
                $(this).find(settings.contentSelector).each(function () {
                           //	$(this).hide();
                            });
            },
            stop: function (e,ui) {
                $(ui.item).css({width:''}).removeClass('dragIcon');
                //Show the content when finished dragging
                $(this).find(settings.contentSelector).each(function () {
                           	$(this).show();
                            });
                            //Make sure that all sizes reset
                
                $(settings.columns).sortable('enable');
            }
        });
    }
  
};

iNettuts.init();