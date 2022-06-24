import requests
from bs4 import BeautifulSoup

def gettitle(url):
    response=requests.get(url)
    soup=BeautifulSoup(response.text,'html.parser')
    title=soup.find('title').get_text()
    return title

def gettitle2(url):
    response=requests.get(url)
    soup=BeautifulSoup(response.text,'html.parser')
    title=soup.find('title').get_text()
    return History(url,title)

class History:
    url=None
    title=None

    def __init__(self,url,title):
        self.url=url
        self.title=title

    def print(self):
        print(f"URL:{self.url} のタイトルは {self.title}です")