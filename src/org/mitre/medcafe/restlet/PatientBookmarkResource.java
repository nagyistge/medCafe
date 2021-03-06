/*
 *  Copyright 2010 The MITRE Corporation (http://www.mitre.org/). All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.mitre.medcafe.restlet;

import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONObject;
import org.mitre.medcafe.util.Bookmark;
import org.mitre.medcafe.util.WebUtils;
import org.restlet.data.Form;
import org.restlet.ext.json.JsonRepresentation;
import org.restlet.resource.ResourceException;
import org.restlet.representation.Representation;
import org.restlet.representation.StringRepresentation;
import org.restlet.resource.Get;
import org.restlet.resource.ServerResource;


public class PatientBookmarkResource extends ServerResource {

	 /** The underlying Item object. */
    //Patient item;

    /** The sequence of characters that identifies the resource. */
	private String id;
	private String user;

	private final static String PATIENT_ID = "id";
	private final static String USER_ID = "user";
    public final static String KEY = PatientBookmarkResource.class.getName();
    public final static Logger log = Logger.getLogger( KEY );

    protected Date startDate = new Date();
    protected Date endDate =  new Date();

    // static{log.setLevel(Level.FINER);}

    protected void doInit() throws ResourceException {
        // Get the "type" attribute value taken from the URI template
        Form form = getRequest().getResourceRef().getQueryAsForm();
        id = (String)getRequest().getAttributes().get(PATIENT_ID);
        user = form.getFirstValue(USER_ID);

    }

    @Get("html")
    public Representation toHtml(){

    	log.finer("Found PatientBookmarkResource html ");
    	ArrayList<Bookmark> bookmarks = Bookmark.getBookmarks( user, id);

    	StringBuffer startBuf = new StringBuffer("<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"display\" id=\"tableBookmarks" + id + "\">" +
    											"<thead><tr><th></th><th></th><th></th></tr></thead><tbody>");
    	StringBuffer patientBookmarks = new StringBuffer();
    	StringBuffer endBuf = new StringBuffer("</tbody></table>");
    	 for(Bookmark bookmark: bookmarks)
         {

    		 String name = bookmark.getName();
    		 String url = bookmark.getUrl();
    		 String description = bookmark.getDescription();

    		 patientBookmarks.append("<tr class=\"gradeX\"><td value=\"" + name + "\">" + name + "</td>" +
    				 					"<td value=\"" + url + "\">" + url + "</td>" +
    				 					"<td value=\"" + description + "\">" + description + "</td></tr>");

             log.finer("PatientBookmarkResource: toJSON : name " + bookmark.getName());

         }
    	return new StringRepresentation( startBuf.toString() + patientBookmarks.toString()
                 + endBuf.toString());

    }

    @Get("json")
    public JsonRepresentation toJson(){
        try
        {

            JSONObject obj = new JSONObject();

            ArrayList<Bookmark> bookmarks = Bookmark.getBookmarks( user, id);
            /*if (bookmarks.size() == 0)
            {
            	 return new JsonRepresentation(WebUtils.buildErrorJson( "There are currently no bookmarks specified"));
            }*/
            obj.put("patient", id);
            for(Bookmark bookmark: bookmarks)
            {

                JSONObject inner_obj = new JSONObject ();
                inner_obj.put("name", bookmark.getName() );
                inner_obj.put("url", bookmark.getUrl());
                inner_obj.put("description", bookmark.getDescription());
                obj.append("bookmarks", inner_obj);  //append creates an array for you

            }
            //log.finer( obj.toString());
            log.finer("PatientBookmarkResource JSON " +  obj.toString());
            return new JsonRepresentation(obj);
        }
        catch(Exception e)
        {
            log.throwing(KEY, "toJson()", e);
            return null;
        }
    }


}
