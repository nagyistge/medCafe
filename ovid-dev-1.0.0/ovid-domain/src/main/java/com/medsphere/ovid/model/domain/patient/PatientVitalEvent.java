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
package com.medsphere.ovid.model.domain.patient;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * 
 */
@XmlType(name="PatientVitalEvent")
@XmlRootElement(name="PatientVitalEvent")
public class PatientVitalEvent extends PatientItem {  
    private Collection<VitalSignDetail> details;

    private PatientVitalEvent() {}
    public PatientVitalEvent(String id, Date dateTime) {
        super(id, "vital signs", null, dateTime, PatientItemType.VitalSign);        
        details = new ArrayList<VitalSignDetail>();
    }

    @XmlElement(name="Details")
    public Collection<VitalSignDetail> getDetails() {
        return details;
    }

    public void addDetail(VitalSignDetail detail) {
        this.details.add(detail);
    }

    @Override
    public String toString() {
        StringBuffer buf = new StringBuffer(super.toString());
        for (VitalSignDetail detail : details) {
            buf.append("\n\t name=["+detail.getName()+"] value=["+detail.getValue()+"] units=["+detail.getUnits()
                       +"] metric=["+detail.getMetric()+"] metric-units=["+detail.getMetricUnits()+"] indicator=["+detail.getIndicator()
                       +"] qualifiers=["+detail.getQualifiers()+"] BMI=["+detail.getBmi()+"] SO2=["+detail.getSo2()+"]");
        }
        return buf.toString();
    }

}

