package org.mitre.medcafe.restlet;

import java.util.*;
import java.util.regex.*;
import java.util.logging.*;
import org.json.*;
import org.mitre.medcafe.util.*;
import org.restlet.data.*;
import org.restlet.ext.json.*;
import org.restlet.representation.*;
import org.restlet.resource.*;



public class TreeNodeResource extends ServerResource {

    public final static String KEY = TreeNodeResource.class.getName();
    public final static Logger log = Logger.getLogger( KEY );
    static{log.setLevel(Level.FINER);}


    protected String view = "plain";
    protected List<String> supportedViews = Arrays.asList( "plain", "link", "array" );

    protected String relurl = Config.EMPTY_STR;

    @Override
    protected void doInit() throws ResourceException {
        // Get the "type" attribute value taken from the URI template
        Form form = getRequest().getResourceRef().getQueryAsForm();
        String whatToShow = form.getFirstValue("type");
        if( whatToShow != null && supportedViews.contains(whatToShow) )
        {
            view = whatToShow;
        }
        log.finer( "Formatting as " + view );
        relurl = form.getFirstValue("relurl");
        log.finer( "relurl retrieved is " + relurl );
    }

    @Get("html")
    public Representation toHtml(){
        try
        {
            if( relurl == null )
            {
                return new StringRepresentation( "<li id=\"treeme\"><span class=\"folder\">No resource idenitifed</span></li>\n" );
            }
            ClientResource resource = new ClientResource( "http://127.0.0.1:8080/medcafe/c" + relurl );

            Representation answer = resource.get(MediaType.APPLICATION_JSON);
            if (resource.getStatus().isSuccess() && resource.getResponseEntity().isAvailable()) {
                JsonRepresentation response = new JsonRepresentation(answer);
                // TODO - add calls to formatting class and determine type of data
                String format = Config.getFormat(relurl);
                /* check for custom formatting */
                if( format == null )
                {
                    return defaultFormat( response );
                }
                /* must have custom formatting configured.  Use it. */
                return customFormat( response, format );
            }
            else
            {
                log.warning( "Resource was not reachable" );
                log.warning( "\tFound resource?  " + resource.getStatus().isSuccess() );
                return new StringRepresentation( "<li id=\"treeme\"><span class=\"folder\">Resource was not reachable</li>" );
            }
            // return new StringRepresentation( ret.toString() );
        }
        catch (Exception e)
        {
            log.throwing( KEY, "toHtml()", e );
            return  new StringRepresentation(" <li id=\"treeme\"><span class=\"folder\">An error occurred and access to the requested information failed.</li> ");
        }
    }

    /**
     *  uses the custom formatting to craft the response
     */
    public Representation customFormat( JsonRepresentation representation, String format )
        throws JSONException
    {
        StringBuilder ret = new StringBuilder();
        String[] fields = parseFields( format );
        String[] tokens = fields[0].split("\\.");

        process( ret, format, representation.getJsonObject(), tokens );

        return new StringRepresentation( ret.toString() );
    }

    /**
     *  recursively processes a field array to build the formatted string
     *  @param ret StringBuilder to be appended to
     *  @param format format the field is to be inserted into
     *  @param parent JSONObject or JSONArray that is the starting point
     *  @param tokens array of field names yet to be processed
     */
    public void process(StringBuilder ret, String format, Object parent, String[] tokens) throws JSONException
    {
        log.finer("working on " + String.valueOf(tokens[0]));
        if( tokens.length == 1 )
        {
            if( parent instanceof JSONObject )
            {
                JSONObject leaf = (JSONObject) parent;
                //check if array
                JSONArray array = leaf.optJSONArray( tokens[0] );
                if( array != null )
                {
                    // log.finer("It's an array");
                    for(int i = 0; i < array.length(); i++)
                    {
                        // log.finer("adding " + array.getString(i));
                        ret.append( array.getString(i) );
                    }
                    return;
                }
                //if not, it's an object and we need to grab the value out
                ret.append( leaf.getString(tokens[0]));
                return;
            }
            else if( parent instanceof JSONArray )
            { //leaf node is an array of JSONObjects which better have a property matching tokens[0]
                JSONArray leaf = (JSONArray)parent;
                for(int i = 0; i < leaf.length(); i++)
                {
                    JSONObject obj = leaf.optJSONObject( i );
                    if( obj != null )
                    {
                        ret.append( obj.optString( tokens[0] ) );
                    }
                    else
                        throw new JSONException("What is this if it's not a JSONObject?  It's a " + obj.getClass().getName());
                }
                return;
            }
            else
                throw new JSONException("Bad datatype passed.  parent needs to be either a JSONArray or JSONObject");
        }
        else
        {
            log.finer("parent is of class " + parent.getClass().getName());
            if( parent instanceof JSONObject )
            {
                Object obj = ((JSONObject)parent).opt(tokens[0]);
                if( obj == null )
                {
                    throw new JSONException("No object with the key " + tokens[0] + " exists.");
                }
                else
                    process( ret, format, obj, Arrays.copyOfRange(tokens, 1, tokens.length));
            }
            else if( parent instanceof JSONArray )
            {
                log.finer("It's a JSONArray!!");
            }
            else
                throw new JSONException("Bad datatype passed.  parent needs to be either a JSONArray or JSONObject");
            //assume we're going at least one more deep

        }
    }


    /**
     *  Pulls the field names out of the format and performs a basic check.
     */
    public String[] parseFields( String format )
    {
        Set<String> ret = new HashSet<String>();
        String regex = "<:(.+?):>";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(format);
        boolean matchFound = matcher.find();
        int tokenLength = 0;
        String field = null;
        while (matchFound) {
            // Get all groups for this match
            field = matcher.group(1);
            /*
            if( field == null )
            { //first time
                tokenLength = field.split("\\.").length;
            }
            else
            { //check the depth of the field.  Must all be the same.
                if( field != field.split("\\.").length )
                {
                    return new StringRepresentation(" <li id=\"treeme\"><span class=\"folder\">The format must have all fields from the same level.</li> ");
                }
            }
            */
            ret.add( field.trim() );
            matchFound = matcher.find();
        }
        return ret.toArray( new String[0] );
    }

    protected Representation defaultFormat( JsonRepresentation representation )
    {
        return new StringRepresentation("<li id=\"treeme\"><span class=\"folder\">Default formatting not implemented yet.</li>");
    }
}
