Class FS.Utils
{

ClassMethod getTitle(url As %String) As %String
{
    // スクリプトファイルがあるパスをsys.pathに追加します
    set sys=##class(%SYS.Python).Import("sys")
    do sys.path.append("c:\WorkSpace\TryIRIS")
    // スクリプトファイルをインポートします。
    set scraping=##class(%SYS.Python).Import("scraping")
    set title=scraping.gettitle(url)
    return title
}

ClassMethod scraping(url As %String) As %String [ Language = python ]
{
    import requests
    from bs4 import BeautifulSoup
    import urllib.parse as parser
    import iris
    response=requests.get(url)
    soup=BeautifulSoup(response.text,'html.parser')
    title=soup.find('title').get_text()
    path=parser.urlparse(url).path
    #glo=iris.gref("^DEVCOM")
    #glo[path]=title
    iris.cls("FS.Utils").setGlo(path,title)
    return title
}

ClassMethod setGlo(path As %String, title As %String)
{
    set ^DEVCOM(path)=title
}

ClassMethod Kahen(input... As %String)
{
    zwrite input
}

ClassMethod KahenPython(input... As %String) [ Language = python ]
{
    print(input)
}

ClassMethod listtest(list As %SYS.Python) As %SYS.Python [ Language = python ]
{
    print(f"入力されたデータはのタイプは：{type(list)} です")
    if len(list)==2:
        return True
    else:
        return False
}

ClassMethod TrueFalse(in As %Integer) As %SYS.Python
{
	if in=1 {
		return ##class(%SYS.Python).True()
	}
	else {
		return ##class(%SYS.Python).False()
	}
}

ClassMethod TFTest(input As %Integer) [ Language = python ]
{
    import iris
    ret=iris.cls("FS.Utils").TrueFalse(input)
    if ret==True:
        print("True返ってきた")
    else:
        print("Flase返ってきた")
}

ClassMethod statustest() [ Language = python ]
{
    import iris
    try:
        a=iris.cls("FS.Person")._New()
        a.DOB="ThisIsError"
        st=a._Save()
        iris.check_status(st)
    except RuntimeError as ex:
        print("pythonのエクセプション！")
        print(str(repr(ex)))
        raise
}

ClassMethod errtest1(a As %Integer, b As %Integer) As %Integer [ Language = python ]
{
    result=a/b
    return result
}

ClassMethod errtest2(a As %Integer, b As %Integer) As %Integer [ Language = python ]
{
    try:
        if b==1:
            modori="1で割っても答えは同じです"
            return modori
        print(f"割り算の答えは＝{a/b}")
        modori="OK"
        return modori
    except ZeroDivisionError as ex:
        modori=str(repr(ex))
        print(modori)
        return modori
}

ClassMethod errtest3(a As %Integer, b As %Integer) As %Status [ Language = python ]
{
    import iris
    try:
        print(a/b)
        ret=1
    except Exception as ex:
        moji="エラーが発生しました！"+str(repr(ex))
        ret=iris.system.Status.Error(5001,moji)
    return ret
}

ClassMethod errtest4() As %Status
{
    #dim ex As %Exception.AbstractException
    try {
        set sys=##class(%SYS.Python).Import("sys")
        do sys.path.append("C:\WorkSpace\TryIRIS")
        set errtest=##class(%SYS.Python).Import("test1")
        do errtest.err3(1,0)
    }
    catch ex {
        write "エラーが発生しました：",ex.DisplayString(),!
        //例外から%Statusに変換
        set st=ex.AsStatus()
        //例外からSQLCODEとメッセージを取得
        set SQLCODE=ex.AsSQLCODE()
        set SQLMessage=ex.AsSQLMessage()
    }
}

}
