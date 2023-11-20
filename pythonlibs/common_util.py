from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.service import Service
import os


# def open_eppd_by_chrome_browser(urlTokens):
#     driverPath = find_chromedriver_path()
#     options = webdriver.ChromeOptions()
#     options.add_argument("--start-maximized")
#     options.add_argument("--disable-popup-blocking")
#     options.add_argument("--disable-infobars")
#     # options.add_argument("--headless")
#     options.add_experimental_option("detach", True)
#     webdriver_service = Service(driverPath)
#     driver = webdriver.Chrome(service=webdriver_service, options=options)
#     driver.get(urlTokens)

def find_chromedriver_path():
    current_path = os.path.abspath(__file__)
    chromedriverpath = os.path.abspath(os.path.join(current_path, '../../drivers/chrome_macx64_11906045105/chromedriver'))
    return chromedriverpath

def chrome_options():
    options = webdriver.ChromeOptions()
    options.add_argument("--start-maximized")
    options.add_argument("--disable-popup-blocking")
    options.add_argument("--disable-infobars")
    options.add_experimental_option("detach", True)
    return options
