/*
 * Copyright (C) 2007-2009  Medsphere Systems Corporation
 * All rights reserved.
 *
 * This source code contains the intellectual property
 * of its copyright holder(s), and is made available
 * under a license. If you do not know the terms of
 * the license, please stop and do not read further.
 *
 * Please read LICENSES for detailed information about
 * the license this source code file is available under.
 * Questions should be directed to legal@medsphere.com
 *
 */

/*
 * container class of fileman State information
 */

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

public class FMState extends FMRecord {

    /*-------------------------------------------------------------
     * begin static initialization
     *-------------------------------------------------------------*/
    private static Set<FMField> domainFields;
    private static FMFile fileInfo;
    private static Map<String, AnnotatedElement> domainJavaFields;
    private static Map<String, String> domainNumbers;

    static {
        domainJavaFields = getDomainJavaFields(FMState.class);
        domainFields = getFieldsInDomain(domainJavaFields);
        domainNumbers = getNumericMapping(FMState.class);
        fileInfo = new FMFile("STATE") { // 

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

    @FMAnnotateFieldInfo(name = "NUMBER", number = ".001", fieldType = FMField.FIELDTYPE.NUMERIC)
    protected int number;
    @FMAnnotateFieldInfo(name = "NAME", number = ".01", fieldType = FMField.FIELDTYPE.FREE_TEXT)
    protected String name;
    @FMAnnotateFieldInfo(name = "ABBREVIATION", number = "1", fieldType = FMField.FIELDTYPE.FREE_TEXT)
    protected String abbrev;
    @FMAnnotateFieldInfo(name = "VA STATE CODE", number = "2", fieldType = FMField.FIELDTYPE.FREE_TEXT)
    protected String code;

    public FMState() {
        super(fileInfo.getFileName());
    }

    public FMState(FMResultSet results) {
        super(results);
    }

    public String getName() {
        return name;
    }
    public int getNumber()
    {
        return number;
    }

    public String getCode() {
        return code;
    }

    public String getAbbrev() {
        return abbrev;
    }


    @Override
    public String toString() {
        return "IEN=["+getIEN()+"]"
        + " name=["+getName()+"]"
        + " number =["+getNumber()+"]"
        + " abbreviation=["+getAbbrev() +"]"
        + " VA state code =["+getCode()+"]";

    }
}