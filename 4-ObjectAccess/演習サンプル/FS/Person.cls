Class FS.Person Extends %Persistent
{

/// 人の名前
Property Name As %String;

Property DOB As %Date;

Property Age As %Integer [ Calculated, SqlComputed ];

Index NameIdx On Name;

ClassMethod AgeComputation(cols As %PropertyHelper) As %Integer [ Language = python ]
{
    if cols.getfield("DOB")=="":
        return ""
    import datetime
    today=datetime.date.today().toordinal()
    iris0=datetime.date(1840,12,31).toordinal()
    return ((today-iris0-cols.getfield("DOB"))//365)
}

/// Description
Method Print() [ Language = python ]
{
    print(f"名前は {self.Name} – 年齢は{self.Age}　です")
}

ClassMethod CreateEmail(uid As %String) As %String [ Language = python, SqlProc ]
{
    if uid==None:
        return ""
    return uid+"@mail.com"
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>DOB</Value>
</Value>
<Value name="4">
<Value>Age</Value>
</Value>
</Data>
<DataLocation>^FS.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^FS.PersonD</IdLocation>
<IndexLocation>^FS.PersonI</IndexLocation>
<StreamLocation>^FS.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
