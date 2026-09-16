class http_read:
    def __init__(self, URL):
        self.URL = URL
    
    def read(self):
        r = requests.get(url = self.URL)
        data = r.json()