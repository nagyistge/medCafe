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
package com.medsphere.fmdomain;
/*
 * container class of fileman V Treatment information
 */


import java.lang.reflect.AnnotatedElement;
import java.util.Collection;
import java.util.Date;

import java.util.Map;
import java.util.Set;

import com.medsphere.fileman.FMAnnotateFieldInfo;
import com.medsphere.fileman.FMField;
import com.medsphere.fileman.FMFile;
import com.medsphere.fileman.FMRecord;
import com.medsphere.fileman.FMResultSet;

public class FMV_Treatment extends FMRecord {

    /*-------------------------------------------------------------
     * begin static initialization
     *-------------------------------------------------------------*/

    private static Set<FMField> domainFields;
    private static FMFile fileInfo;
    private static Map<String, AnnotatedElement> domainJavaFields;
    private static Map<String, String> domainNumbers;

    static {
        domainJavaFields = getDomainJavaFields(FMV_Treatment.class);
        domainFields = getFieldsInDomain(domainJavaFields);
        domainNumbers = getNumericMapping(FMV_Treatment.class);
        fileInfo = new FMFile("V TREATMENT") { //

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

    @FMAnnotateFieldInfo(name = "TREATMENT", number = ".01", fieldType = FMField.FIELDTYPE.POINTER_TO_FILE)
    protected Integer treatment;
    @FMAnnotateFieldInfo(name = "PATIENT NAME", number = ".02", fieldType = FMField.FIELDTYPE.POINTER_TO_FILE)
    protected Integer patient;
    @FMAnnotateFieldInfo(name = "VISIT", number = ".03", fieldType = FMField.FIELDTYPE.POINTER_TO_FILE)
    protected Integer visit;
    @FMAnnotateFieldInfo(name = "HOW MANY", number = ".04", fieldType = FMField.FIELDTYPE.NUMERIC)
    protected Double howMany;
    @FMAnnotateFieldInfo(name = "PROVIDER NARRATIVE", number = ".06", fieldType = FMField.FIELDTYPE.POINTER_TO_FILE)
    protected Integer narrative;
    @FMAnnotateFieldInfo(name = "Event Date and Time", number = "1201", fieldType = FMField.FIELDTYPE.DATE)
    protected Date eventDate;
    @FMAnnotateFieldInfo(name = "ORDERING PROVIDER", number = "1202", fieldType = FMField.FIELDTYPE.POINTER_TO_FILE)
    protected Integer orderingProvider;
    @FMAnnotateFieldInfo(name = "ENCOUNTER PROVIDER", number = "1204", fieldType = FMField.FIELDTYPE.POINTER_TO_FILE)
    protected Integer encounterProvider;
    @FMAnnotateFieldInfo(name = "COMMENTS", number = "81101", fieldType = FMField.FIELDTYPE.FREE_TEXT)
    protected String comments;


    public FMV_Treatment() {
        super(fileInfo.getFileName());
    }
    public FMV_Treatment(FMResultSet results) {
        super(results);
    }
    public Integer getTreatment (){
        return treatment;
    }
    public String getTreatmentValue()
    {
        return getValue(".01");
    }
    public Integer getPatient() {
        return patient;
    }
    public String getPatientName(){
        return getValue(".02");
    }
    public Integer getVisitIEN(){
       return visit;
    }
    public Double getHowMany(){
        return howMany;
    }
    public Integer getProviderNarrative(){
        return narrative;
    }
    public String getProviderNarrativeValue(){
        return getValue(".06");
    }
    public Date getEventDate()
    {
        return eventDate;
    }
    public Integer getOrderingProvider()
    {
        return orderingProvider;
    }
    public String getOrderingProviderValue()
    {
        return getValue("1202");
    }
     public Integer getEncounterProvider()
    {
        return encounterProvider;
    }
    public String getEncounterProviderValue()
    {
        return getValue("1204");
    }
    public String getComments()
    {
        return comments;
    }

    @Override
    public String toString() {
        return " Event Date=[" + getEventDate() + "]" +
        " patient=["+getPatientName()+"]"
        + " treatment =["+getTreatmentValue()+"]"
        + " how many =["+ getHowMany() + "]"
        + " provider narrative =[" + getProviderNarrativeValue() + "]"
        + " visit IEN =[" + getVisitIEN() + "]"
        + " ordering provider=[" + getOrderingProviderValue() + "]"
        + " encounter provider =["+getEncounterProviderValue() +"]"+
                " comments =[" + getComments() + "]";
    }

}

