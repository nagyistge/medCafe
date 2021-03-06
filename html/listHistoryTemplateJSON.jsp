<%-- Copyright 2010 The MITRE Corporation (http://www.mitre.org/). All Rights Reserved.  Licensed under the Apache License, Version 2.0 (the "License").  --%>
<%@ page import="org.mitre.medcafe.util.*" %>
<%@ page import="org.mitre.medcafe.model.*" %>
<%@ page import="java.util.logging.*" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%!
    public final static String KEY = "/listHistoryTemplateJSON.jsp";
    public final static Logger log = Logger.getLogger( KEY );
    //static{log.setLevel(Level.FINER);}%>
<%

	log.finer("listHistoryTemplateJSON: url start");
	String jspUrl =  "/history/templates";

	String repositoryName = "local";
	String patientRepId = request.getParameter("patient_rep_id");
	JSONObject repositoryIds = new JSONObject();
	if (patientRepId == null)
	{
		PatientCache cache = (PatientCache) session.getAttribute(PatientCache.KEY);
	    if( cache == null )
	    {  //nobody is logged in
	        //log.warning("No patient selected");
	        response.sendRedirect("introPage.jsp");
	        return;
	    }
	    repositoryIds = cache.getRepositories();

		//System.out.println("listHistoryTemplateJSON: got repository ID  " + repositoryIds.toString() );
		JSONArray repArray = repositoryIds.getJSONArray("repositories");
		if (repArray != null)
		{
			for (int i= 0; i < repArray.length(); i++)
			{
				JSONObject rep = (JSONObject)repArray.get(i);
				if (rep != null)
				{
					String repName = rep.getString("repository");
					if (repName.equals(repositoryName))
					{
							patientRepId =  rep.getString("id");;
					}
				}
			}
		}

	}

	log.finer("listHistoryTemplateJSON: got patient rep Id " + patientRepId );

	String patientId = null;

	Object patientObj = session.getAttribute("patient");
	log.finer("listHistoryTemplateJSON: got patient from session object " + patientObj );

	if (patientObj != null)
		 	patientId = patientObj.toString();

	//if (patientId != null)
		 jspUrl =  "/history/templates/patients/" + patientRepId;

	String user =  request.getRemoteUser();
	jspUrl = jspUrl + "?user=" + user;

	log.finer("listHistoryTemplateJSON: url " + jspUrl);
%>

<tags:IncludeRestlet relurl="<%=jspUrl%>" mediatype="json"/>



