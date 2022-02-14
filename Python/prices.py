import requests
from bs4 import BeautifulSoup

def check_price(URL):
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36"}

    page=requests.get(URL, headers=headers)

    soup=BeautifulSoup(page.content,'html.parser')

    title=soup.find(id='productTitle').get_text()
    price = soup.find(id='priceblock_ourprice').get_text()

    print(title.strip())
    print(price)
    print()

check_price('https://www.amazon.in/dp/B00H1TES4C/?coliid=IO8X1GA0AEBK7&colid=QID2XFOZEZV6&psc=1&ref_=lv_ov_lig_dp_it')
check_price('https://www.amazon.in/dp/B01IEVYFJI/?coliid=I3COI0MDSHE879&colid=QID2XFOZEZV6&psc=1&ref_=lv_ov_lig_dp_it')
check_price('https://www.amazon.in/dp/B016R9E7J2/?coliid=I28TAA4HSWUDSI&colid=QID2XFOZEZV6&psc=1&ref_=lv_ov_lig_dp_it')
check_price('https://www.amazon.in/Mivi-OAC2A-Type-C-Female-Adapter/dp/B072VDYFD6/ref=sr_1_3?keywords=type+c+otg&qid=1567020151&s=gateway&sr=8-3')
check_price('https://www.amazon.in/AmazonBasics-USB-Type-C-2-0-Cable/dp/B01GGKZ0V6/ref=sr_1_3?keywords=type+c+to+type+c+cable&qid=1567020182&s=gateway&sr=8-3')

while(True):
    pass
