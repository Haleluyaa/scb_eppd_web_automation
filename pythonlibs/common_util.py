from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.service import Service
from robot.api.deco import keyword, not_keyword, library
import os

def find_chromedriver_path():
    current_path = os.path.abspath(__file__)
    chromedriverpath = os.path.abspath(os.path.join(current_path, '../../drivers/chromedriver-mac-arm64_11906045105/chromedriver'))
    return chromedriverpath

def find_chromeapp_path():
    current_path = os.path.abspath(__file__)
    chromeapppath = os.path.abspath(os.path.join(current_path, '../../drivers/chrome-mac-arm64-testing_11906045105/Google_Chrome_for_Testing.app/Contents/MacOS/Google Chrome for Testing'))
    return chromeapppath

@keyword('set chrome options')
def chrome_options():
    options = webdriver.ChromeOptions()
    chromeapp = find_chromeapp_path()
    options.binary_location = chromeapp
    options.add_argument("--start-maximized")
    options.add_argument("--disable-popup-blocking")
    options.add_argument("--disable-infobars")
    options.add_experimental_option("detach", True)
    return options

# chrome_options = chrome_options()
# print(chrome_options.__dict__)









