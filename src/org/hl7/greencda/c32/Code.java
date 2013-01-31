//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.01.22 at 04:05:05 PM EST 
//


package org.hl7.greencda.c32;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for code complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="code">
 *   &lt;complexContent>
 *     &lt;extension base="{urn:hl7-org:greencda:c32}simpleCode">
 *       &lt;sequence>
 *         &lt;element name="originalText" type="{http://www.w3.org/2001/XMLSchema}anyType"/>
 *         &lt;element name="translation" type="{urn:hl7-org:greencda:c32}simpleCode" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "code", propOrder = {
    "originalText",
    "translation"
})
public class Code
    extends SimpleCode
{

    @XmlElement(required = true)
    protected Object originalText;
    protected List<SimpleCode> translation;

    /**
     * Gets the value of the originalText property.
     * 
     * @return
     *     possible object is
     *     {@link Object }
     *     
     */
    public Object getOriginalText() {
        return originalText;
    }

    /**
     * Sets the value of the originalText property.
     * 
     * @param value
     *     allowed object is
     *     {@link Object }
     *     
     */
    public void setOriginalText(Object value) {
        this.originalText = value;
    }

    /**
     * Gets the value of the translation property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the translation property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getTranslation().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link SimpleCode }
     * 
     * 
     */
    public List<SimpleCode> getTranslation() {
        if (translation == null) {
            translation = new ArrayList<SimpleCode>();
        }
        return this.translation;
    }

}