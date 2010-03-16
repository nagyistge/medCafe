MSCFMFI; JDA 13FEB2008
 ;
 Q
FILEINFO(REPLY,RES)
 N PROPNAME,FILE,FILENUM,SQL
 S SQL=0
 ; Parse out the command properties
 F  Q:'$$NEXTPROP^MSCRES(.RES)  D
 . S PROPNAME=$$GETPROP^MSCRES(.RES)
 . I PROPNAME="FILE" S FILE=$$GETVAL^MSCRES(.RES) Q
 . I PROPNAME="SQL" S SQL=$$GETVAL^MSCRES(.RES) Q
 . Q
 I FILE=+FILE S FILENUM=FILE S FILE=$$NUM2FILE^MSCFM(FILENUM)
 E  S FILENUM=$$FILE2NUM^MSCFM(FILE)
 I (FILENUM=0)!(FILE="")!('$$VFILE^DILFD(FILENUM)) D ADDPROP^MSCRES(.REPLY,"ERROR","Could not find file.") D ENDCMPD^MSCRES(.REPLY) Q
 ; If this is a subfile, go to top file
 F  Q:$G(^DD(FILENUM,0,"UP"))=""  S FILENUM=^DD(FILENUM,0,"UP")
 S FILE=$$NUM2FILE^MSCFM(FILENUM)
 I (FILENUM=0)!(FILE="")!('$$VFILE^DILFD(FILENUM)) D ADDPROP^MSCRES(.REPLY,"ERROR","Could not find file.") D ENDCMPD^MSCRES(.REPLY) Q
 D DOFIELDS(.REPLY,FILENUM,SQL,FILE,"")
 Q
DOFIELDS(REPLY,FILENUM,SQL,FILE,UPFILE,UPFIELD)
 N TYPE,P2,FLDNUM,FDTARGET,SQLTMP,SQLTMP2,DESC,I
 S:$G(FILE)="" FILE=$$NUM2FILE^MSCFM(FILENUM)
 Q:FILE="" ; Garbage? Like 1.008?
 D ADDCMPD^MSCRES(.REPLY,"FILE")
 D ADDPROP^MSCRES(.REPLY,"NAME",FILE)
 D ADDPROP^MSCRES(.REPLY,"NUMBER",FILENUM)
 D ADDPROP^MSCRES(.REPLY,"LOCATION",$$ROOT^DILFD(FILENUM))
 I UPFILE="" D
 . D FILE^DID(FILENUM,,"DESCRIPTION","DESC")
 E  D
 . D FIELD^DID(UPFILE,UPFIELD,,"DESCRIPTION","DESC")
 I $D(DESC("DESCRIPTION",1)) D
 . D ADDCMPD^MSCRES(.REPLY,"DESC")
 . S I=0 F  S I=$O(DESC("DESCRIPTION",I)) Q:I=""  D ADDPROP^MSCRES(.REPLY,I,DESC("DESCRIPTION",I)) W "=>"_DESC("DESCRIPTION",I),!
 . D ENDCMPD^MSCRES(.REPLY) ; "DESC"
 I SQL D
 . S SQLTMP=$O(^DMSQ("T","C",FILENUM,""))
 . Q:SQLTMP=""
 . D ADDPROP^MSCRES(.REPLY,"SQL",$P(^DMSQ("T",SQLTMP,0),"^",1))
 S FLDNUM=0
 F  S FLDNUM=$O(^DD(FILENUM,FLDNUM)) Q:FLDNUM'=+FLDNUM  D
 . D FIELD^DID(FILENUM,FLDNUM,,"LABEL;TYPE;GLOBAL SUBSCRIPT LOCATION","FDTARGET")
 . Q:FDTARGET("LABEL")="" ; Garbage? File 604, field 18.1
 . D ADDCMPD^MSCRES(.REPLY,"F")
 . D ADDPROP^MSCRES(.REPLY,"N",FDTARGET("LABEL"))
 . S P2=$P(^DD(FILENUM,FLDNUM,0),"^",2)
 . S TYPE=$$TYPENUM(FDTARGET("TYPE"))
 . I (+P2)&(TYPE'=5) S TYPE=9 ; Multiples are subfile when not WP
 . D ADDPROP^MSCRES(.REPLY,"T",TYPE)
 . D ADDPROP^MSCRES(.REPLY,"L",FDTARGET("GLOBAL SUBSCRIPT LOCATION"))
 . D ADDPROP^MSCRES(.REPLY,"#",FLDNUM)
 . I (TYPE=7) D
 . . D ADDPROP^MSCRES(.REPLY,"P",+$P(P2,"P",2))
 . I (TYPE=9) D
 . . N SFNUM S SFNUM=+$P(^DD(FILENUM,FLDNUM,0),"^",2)
 . . Q:'SFNUM
 . . D DOFIELDS(.REPLY,SFNUM,SQL,"",FILENUM,FLDNUM)
 . E  I SQL D
 . . S SQLTMP=$O(^DMSQ("C","D",FILENUM,FLDNUM,""))
 . . Q:SQLTMP=""
 . . S SQLTMP2=$P(^DMSQ("C",SQLTMP,0),"^",1)
 . . D ADDPROP^MSCRES(.REPLY,"Q",$P(^DMSQ("E",SQLTMP2,0),"^",1))
 . D ENDCMPD^MSCRES(.REPLY) ; F
 . Q
 D ENDCMPD^MSCRES(.REPLY) ; FILE
 Q
TYPENUM(TYPE)
 I '$D(^MSCTYPES) D
 . S ^MSCTYPES("DATE/TIME")=1
 . S ^MSCTYPES("NUMERIC")=2
 . S ^MSCTYPES("SET")=3
 . S ^MSCTYPES("FREE TEXT")=4
 . S ^MSCTYPES("MUMPS")=4
 . S ^MSCTYPES("WORD-PROCESSING")=5
 . S ^MSCTYPES("COMPUTED")=6
 . S ^MSCTYPES("POINTER")=7
 . S ^MSCTYPES("VARIABLE-POINTER")=8
 Q ^MSCTYPES(TYPE)
FILES(REPLY,RES)
 N IDX,FILENAME
 S IDX=1
 D ADDCMPD^MSCRES(.REPLY,"RESULTS")
 F  S IDX=$O(^DD(IDX)) Q:IDX'=+IDX  D
 . Q:'$$VFILE^DILFD(IDX) ; WP fields
 . S FILENAME=$$NUM2FILE^MSCFM(IDX)
 . Q:FILENAME="" ; Garbage in the structure? Like .008 or .3
 . D ADDCMPD^MSCRES(.REPLY,"R")
 . D ADDPROP^MSCRES(.REPLY,"T",FILENAME)
 . D ADDPROP^MSCRES(.REPLY,"N",IDX)
 . D:$G(^DD(IDX,0,"UP")) ADDPROP^MSCRES(.REPLY,"P",$G(^DD(IDX,0,"UP")))
 . D ENDCMPD^MSCRES(.REPLY) ; R
 D ENDCMPD^MSCRES(.REPLY) ; RESULTS
 Q
