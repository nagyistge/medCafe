<%@ page import="org.mitre.medcafe.util.*,org.mitre.medcafe.model.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%

	System.out.println("listAddressJSON: url start");
		
	String jspUrl ="";
		
	String patientId = request.getParameter(Constants.PATIENT_ID);
	PatientCache cache = (PatientCache) session.getAttribute(PatientCache.KEY);
    if( cache == null )
    {  //nobody is logged in
        //log.warning("No patient selected");
        response.sendRedirect("introPage.jsp");
        return;
    }
    patientId = cache.getDatabasePatientId();
	
	if (patientId != null)
	{
		jspUrl = request.getParameter("uri");
		if (jspUrl == null)
			jspUrl =  "/patients/" + patientId + "/address";  
	}
	
	
	String user =  request.getRemoteUser();
	jspUrl = jspUrl + "?user=" + user;
	
	System.out.println("listAddressJSON: url " + jspUrl);
%>

<tags:IncludeRestlet relurl="<%=jspUrl%>" mediatype="json"/>



