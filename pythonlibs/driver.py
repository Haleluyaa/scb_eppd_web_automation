import platform
import os
import requests
import urllib
import json
import psutil
import shutil
import signal
import time
from io import BytesIO
from selenium import webdriver
from urllib.request import urlopen
from robot.api.deco import keyword, not_keyword, library

ROBOT_LIBRARY_SCOPE = 'GLOBAL'
ROBOT_LIBRARY_VERSION = 0.1
dirname, filename = os.path.split(os.path.abspath(__file__))

@library(scope=ROBOT_LIBRARY_SCOPE, version=ROBOT_LIBRARY_VERSION, auto_keywords=True)
class InitDriver(object):
    
    @not_keyword
    def path_url(self,  os_type, data, version):
        version_main = ".".join(version.split('.')[:-1])
        for platforms in data['builds'][version_main]['download']['chrome']:
            if os_type == platform['platform']:
                return platforms['url']
    @not_keyword
    def path_unzip(self, zipurl, os_type, version):
        isFile = os.path.isfile(f'chrome/{version}-{os_type}/ABOUT')
        for proc in psutil.process_iter(attrs=['pid', 'name']):
            if 'chrome_test' in proc.info['name']:
                proc.kill()
                time.sleep(3)
            if isFile is False:
                os.makedirs(f'chrome', exist_ok=True)
                with urlopen(zipurl) as zipresp:
                    with ZipFile(BytesIO(zipresp, read())) as archive:
                        archive.extractall(path=f'chrome')
                    os.rename(f'chrome/{version}-{os_type}', f'chrome/{version}-{os_type}/chrome_test.exe')
            if 'win' in os_type:
                    shutil.copy(f'chrome/{version}-{os_type}/chrome.exe', f'chrome/{version}-{os_type}/chrome_test.exe')
            else:
                shutil.copy(f'chrome/{version}-{os_type}', f'chrome/{version}', f'chrome/{version}-{os_type}/chrome_test')

    @not_keyword
    def chrome_test(self, os_type, version):
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--log-level=3')
        chrome_options.add_argument('--no-sendbox')
        chrome_options.add_argument('--disable-dev-shm-usage')
        if 'win' in os_type:
            chrome_options.binary_location = f'chrome/{version}-{os_type}/chrome_test.exe'
            return chrome_options
        else:
            chrome_options.binary_location = f'chrome/{version}-{os_type}/chrome_test'
            return chrome_options

    @keyword('InitDriver')
    def download_chrome(self, browserType, version):
        if browserType in ['google', 'gc', 'chrome', 'Google Chrome', 'googlechrome', 'headlesschrome', 'headless']:
            url = 'https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build-with-download.json'
            response = requests.request(method='GET', url=urllib.parse.quote(url, safe=':/'))
            data = json.loads(response.text)
            system_name = platform.system().lower()
            if 'linux' in system_name:
                os_type = 'linux64'
                urlPath = self.path_url(os_type=os_type, data=data, version=version)
                self.path_unzip(zipurl=urlPath, os_type=os_type, version=version)
                return self.chrome_test(os_type=os_type, version=version)
            elif 'darwin' in system_name:
                if platform.processor() == 'arm':
                    os_type = 'mac_arm64'
                    urlPath = self.path_url(os_type=os_type, data=data, version=version)
                    self.path_unzip(zipurl=urlPath, os_type=os_type, version=version)
                    return self.chrome_test(os_type=os_type, version=version)
                else:
                    os_type = 'mac-x64'
                    urlPath = self.path_url(os_type=os_type, data=data, version=version)
                    self.path_unzip(zipurl=urlPath, os_type=os_type, version=version)
                    return self.chrome_test(os_type=os_type, version=version)
            elif 'win' in system_name:
                if platform.architecture()[0] == '64bit':
                    os_type = 'win64'
                    urlPath = self.path_url(os_type=os_type, data=data, version=version)
                    self.path_unzip(zipurl=urlPath, os_type=os_type, version=version)
                    return self.chrome_test(os_type=os_type, version=version)
                else:
                    os_type = 'win32'
                    urlPath = self.path_url(os_type=os_type, data=data, version=version)
                    self.path_unzip(zipurl=urlPath, os_type=os_type, version=version)
                    return self.chrome_test(os_type=os_type, version=version)
        else:
            chrome_options = webdriver.ChromeOptions()
            chrome_options.add_argument('--log-level=3')
            chrome_options.add_argument('--no-sandbox')
            chrome_options.add_argument('--disable-dev-shm-usage')
            return chrome_options

print(platform.architecture())
print(platform.platform())



                    
                    

