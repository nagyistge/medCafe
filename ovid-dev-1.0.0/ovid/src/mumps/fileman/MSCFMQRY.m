MSCFMQRY; MSC/JDA - OVID FileMan base for LIST and FIND ; May 14, 2009
 ;;1.0;MSCFM;;May 14, 2009
 Q
BLDREPLY(THIS,TARGET,REPLY)
 I THIS("FROM")'="" D
 . D ADDCMPD^MSCRES(.REPLY,"FROM")
 . N FROM M FROM=THIS("FROM")
 . D SCAN^MSCFMDIC(.REPLY,"FROM",0)
 . D ENDCMPD^MSCRES(.REPLY) ; FROM
 . Q
 D ADDCMPD^MSCRES(.REPLY,"RESULTS")
 ; Check for HTML encoded packed output
 I THIS("PACK")&($P(TARGET("DILIST",0),"^",4)["H") D ADDPROP^MSCRES(.REPLY,"HTML",1)
 N MAP,MAPFLD,TYPEMAP,FNUM,PC
 I THIS("PACK") D
 . S MAP=TARGET("DILIST",0,"MAP")
 . ; Translate the field numbers back into the field names we were given
 . ; Also, remap special types from field #s to positions
 . F FNUM=1:1 S MAPFLD=$P(MAP,"^",FNUM) Q:MAPFLD=""  D
 . . Q:'$D(THIS("NAMES",MAPFLD))
 . . S $P(MAP,"^",FNUM)=THIS("NAMES",MAPFLD)
 . . S:$D(THIS("TYPES",MAPFLD)) TYPEMAP(FNUM)=THIS("TYPES",MAPFLD)
 . . Q
 . Q
 E  D
 . S MAPFLD=""
 . F  S MAPFLD=$O(THIS("NAMES",MAPFLD)) Q:MAPFLD=""  D
 . . S:$D(THIS("TYPES",MAPFLD)) TYPEMAP(THIS("NAMES",MAPFLD))=THIS("TYPES",MAPFLD)
 . . Q
 . Q
 I $D(MAP) D
 . D ADDCMPD^MSCRES(.REPLY,"MAP")
 . F PC=1:1:$L(MAP,"^") D ADDPROP^MSCRES(.REPLY,"M",$P(MAP,"^",PC))
 . D ENDCMPD^MSCRES(.REPLY) ; MAP
 . Q
 N SEQNUM,NODE,IDX,VALUE,FLDVAL
 ; Loop though results and create reply resource
 I THIS("PACK") D  ; Packed format
 . S SEQNUM=0
 . I $D(THIS("TYPES")) D  ; need to translate variable pointers to return file #s
 . . F  S SEQNUM=$O(TARGET("DILIST",SEQNUM)) Q:SEQNUM=""  D
 . . . S VALUE=TARGET("DILIST",SEQNUM,0)
 . . . S IDX=""
 . . . F  S IDX=$O(TYPEMAP(IDX)) Q:IDX=""  D
 . . . . S FLDVAL=$P(VALUE,"^",IDX)
 . . . . I FLDVAL'="" D
 . . . . . S $P(FLDVAL,";",2)=+$P(@("^"_$P(FLDVAL,";",2)_"0)"),"^",2)
 . . . .   S $P(VALUE,"^",IDX)=FLDVAL
 . . . . . Q
 . . . . Q
 . . . D ADDPROP^MSCRES(.REPLY,"RD",VALUE)
 . . . Q
 . . Q
 . E  D
 . . F  S SEQNUM=$O(TARGET("DILIST",SEQNUM)) Q:SEQNUM=""  D
 . . . D ADDPROP^MSCRES(.REPLY,"RD",TARGET("DILIST",SEQNUM,0))
 . . . Q
 . . Q
 . Q
 E  D  ; Unpacked data
 . N FLDNUM
 . S SEQNUM="0"
 . F  S SEQNUM=$O(TARGET("DILIST","ID",SEQNUM)) Q:SEQNUM=""  D
 . . D ADDCMPD^MSCRES(.REPLY,"ROW")
 . . ; Add IEN field
 . . D ADDCMPD^MSCRES(.REPLY,"FIELD")
 . . D ADDPROP^MSCRES(.REPLY,"NAME","IEN")
 . . D ADDPROP^MSCRES(.REPLY,"VALUE",TARGET("DILIST",2,SEQNUM))
 . . D ENDCMPD^MSCRES(.REPLY) ; FIELD
 . . ; Loop through fields
 . . S FLDNUM=""
 . . F  S FLDNUM=$O(TARGET("DILIST","ID",SEQNUM,FLDNUM)) Q:FLDNUM=""  D
 . . . S VALUE=TARGET("DILIST","ID",SEQNUM,FLDNUM)
 . . . Q:VALUE="" ; Do not report empty nodes
 . . . S:$D(TYPEMAP(FLDNUM)) $P(VALUE,";",2)=+$P(@("^"_$P(VALUE,";",2)_"0)"),"^",2)
 . . . D ADDCMPD^MSCRES(.REPLY,"FIELD")
 . . . D ADDPROP^MSCRES(.REPLY,"NAME",THIS("NAMES",FLDNUM))
 . . . D ADDPROP^MSCRES(.REPLY,"VALUE",VALUE)
 . . . D ENDCMPD^MSCRES(.REPLY) ; FIELD
 . . . Q
 . . D ENDCMPD^MSCRES(.REPLY) ; ROW
 . . Q
 . Q
 D ENDCMPD^MSCRES(.REPLY) ; RESULTS
 Q
CNSTRCT(THIS)
 S THIS("PACK")=0,THIS("NUMBER")="*",THIS("FLAGS")="Q",THIS("FIELDS")="@"
 S THIS("IENS")="",THIS("FROM")="",THIS("SCREEN")=""
 Q
PROCPROP(THIS,RES)
 N FROM
 S PROPNAME=$$GETPROP^MSCRES(.RES)
 I PROPNAME="FIELD" D  Q
 . N TMP
 . S TMP=$$PROCFLD(.THIS,.RES)
 . Q:'TMP ; obsolete or multiple field
 . S THIS("FIELDS")=THIS("FIELDS")_";"_TMP
 . Q
 I PROPNAME="FILE" S THIS("FILE")=$$FILE2NUM^MSCFM($$GETVAL^MSCRES(.RES)) S:THIS("FILE")=0 THIS("ERROR")="Could not find file '"_$$GETVAL^MSCRES(.RES)_"'." Q
 I PROPNAME="NUMBER" S THIS("NUMBER")=+$$GETVAL^MSCRES(.RES) Q
 I PROPNAME="FROM" D READ^MSCFMDIC(.RES,.FROM) M THIS("FROM")=FROM Q
 I PROPNAME="IENS" S THIS("IENS")=$$GETVAL^MSCRES(.RES) Q
 I PROPNAME="PACK" S THIS("PACK")=$$GETVAL^MSCRES(.RES) S:THIS("PACK") THIS("FLAGS")=THIS("FLAGS")_"P" Q
 I PROPNAME="SCREEN" S THIS("SCREEN")="I "_$$PROCESS^MSCFMSCN(.THIS,.RES) Q
 I PROPNAME="SAFE" S THIS("SAFE")=$$GETVAL^MSCRES(.RES) Q
 Q
PROCFLD(THIS,RES)
 N NAME,PROPNAME,FLAGS,INTERN,EXTERN,NUM,TYPE,TARGET
 S NAME="",INTERN="0",EXTERN="0"
 F  Q:'$$NEXTPROP^MSCRES(.RES)  D
 . S PROPNAME=$$GETPROP^MSCRES(.RES)
 . I PROPNAME="NAME" S NAME=$$GETVAL^MSCRES(.RES) Q
 . I PROPNAME="INTERNAL" S INTERN=$$GETVAL^MSCRES(.RES) Q
 . I PROPNAME="TYPE" S TYPE=$$GETVAL^MSCRES(.RES) Q
 . Q
 S NUM=$$FLD2NUM^MSCFM(THIS("FILE"),NAME)
 Q:'NUM 0 ; obsolete field
 D FIELD^DID(THIS("FILE"),NUM,,"MULTIPLE-VALUED","TARGET")
 Q:'$D(TARGET("MULTIPLE-VALUED")) 0
 Q:TARGET("MULTIPLE-VALUED") 0
 S THIS("NAMES",NUM)=NAME ; for unpacked
 S:INTERN NUM=NUM_"I"
 S:EXTERN NUM=NUM_"E"
 S THIS("NAMES",NUM)=NAME ; for packed
 S:$D(TYPE) THIS("TYPES",NUM)=TYPE
 Q NUM