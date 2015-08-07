package org.kie.tests;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchemaType;

@XmlRootElement(name="my-type")
@XmlAccessorType(XmlAccessType.FIELD)
public class MyBinaryType implements Serializable {

    @XmlElement
    @XmlSchemaType(name="string")
    private String name;
    
    @XmlElement
    @XmlSchemaType(name="base64Binary")
    private byte [] data;
    
    public MyBinaryType() {
       // default constructor 
    }
    
    public MyBinaryType(String name, byte [] data) {
        this.name = name;
        this.data = data;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    public byte [] getData() {
        return data;
    }
    
    public void setData(byte [] data) {
        this.data = data;
    }

}
