package com.medsphere.fmdomain;

import java.lang.reflect.AnnotatedElement;
import java.util.Collection;
import java.util.Map;
import java.util.Set;

import com.medsphere.fileman.FMAnnotateFieldInfo;
import com.medsphere.fileman.FMField;
import com.medsphere.fileman.FMFile;
import com.medsphere.fileman.FMRecord;
import com.medsphere.fileman.FMResultSet;
import com.medsphere.fileman.FMField.FIELDTYPE;

public class FMMaritalStatus extends FMRecord {
    /*-------------------------------------------------------------
     * begin static initialization
     *-------------------------------------------------------------*/
    private static Set<FMField> domainFields;
    private static FMFile fileInfo;
    private static Map<String, AnnotatedElement> domainJavaFields;
    private static Map<String, String> domainNumbers;

    static {
        domainJavaFields = getDomainJavaFields(FMMaritalStatus.class);
        domainFields = getFieldsInDomain(domainJavaFields);
        domainNumbers = getNumericMapping(FMMaritalStatus.class);
        fileInfo = new FMFile("MARITAL STATUS") {

            @Override
            public Collection<FMField> getFields() {
                return domainFields;
            }
        };
        fileInfo.setPack(true);

    }

    public static FMFile getFileInfoForClass() {
        return fileInfo;
    }

    @Override
    protected Set<FMField> getDomainFields() {
        return domainFields;
    }

    @Override
    protected Map<String, AnnotatedElement> getDomainJavaFields() {
        return domainJavaFields;
    }

    @Override
    protected Map<String, String> getNumericMapping() {
        return domainNumbers;
    }

    /*-------------------------------------------------------------
     * end static initialization
     *-------------------------------------------------------------*/

    @FMAnnotateFieldInfo(name="NAME", number=".01", fieldType=FIELDTYPE.FREE_TEXT)
    protected String name;
    @FMAnnotateFieldInfo(name="ABBREVIATION", number="1", fieldType=FIELDTYPE.FREE_TEXT)
    protected String abbreviation;
    @FMAnnotateFieldInfo(name="MARITAL STATUS CODE", number="2", fieldType=FIELDTYPE.SET_OF_CODES)
    protected String maritalStatusCode;

    public FMMaritalStatus() {
        super("MARITAL STATUS");
    }

    public FMMaritalStatus(FMResultSet results) {
        super( results );
    }


    public String getName() {
        return name;
    }

    public String getAbbreviation() {
        return abbreviation;
    }

    public String getMaritalStatusCode() {
        return maritalStatusCode;
    }

    @Override
    public String toString() {
        return "name=[" + getName() + "] abbreviation=[" + getAbbreviation() + "] maritalStatusCode=[" + getMaritalStatusCode() + "]";
    }

}