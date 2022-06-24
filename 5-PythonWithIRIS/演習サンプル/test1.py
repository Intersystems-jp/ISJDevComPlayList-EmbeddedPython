def list(input):
    print(f"入力されたリスト：{input}")

def taple(input):
    print(f"入力されたリスト：{input}")

def test1(in1):
    import iris
    ret=iris.cls("Test.Class1").TrueFalse(in1)
    if ret==True:
        print("True返ってきた")
    else:
        print("Flase返ってきた")

def statuserr():
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

def err1(a,b):
    result=a/b
    return result

def sqlerr():
    import iris
    import irisbuiltins
    try:
        sql="select * from Training.Person"
        rset=iris.sql.exec(sql)
        for key,val in enumerate(rset):
            print(val)
     
    except irisbuiltins.SQLError as ex:
        print(str(repr(ex)))
        print(ex.sqlcode)
        print(ex.message)
        print(ex.statement)
        raise

def err2(a,b):
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

def err3(a,b):
    try:
        ret=a/b
        print(ret)
    except:
        raise