import os
import hashlib
import codecs
import binascii
import sys
import json
import random
from selenium import webdriver
import decimal
import datetime
from robot.libraries.BuiltIn import BuiltIn
#import redis

def convert_today_to_string_without_zeropad(format):
    today = datetime.date.today()
    # write_to_console(string_today)
    return today.strftime(format).lstrip("0").replace("-0", "-")

def get_canonical_path(path):
    return os.path.abspath(path)

def py_convert_to_float(data) : 
    return float(data)

def py_convert_to_string(data) : 
    return str(data)

def py_convert_to_int(data) : 
    return int(data)

def write_to_console(s):
	BuiltIn().log_to_console(s)

def write(): 
	write_to_console("Hello World")

def string_to_md5(data):
	m = hashlib.md5(binascii.unhexlify(m)).hexdigest()
	m.update(data)
	return m
#	return m.hexdigest()

def get_data_from_list_by_index(data, index):
    try:
        return data[int(index)]
    except:
        return ""

def get_user_index_from_list_by_value(data,value):
    print(value)  
    print(data)
    for i in range(len(data)):
        if data[i]['username'] == value :
            return i

def encode_to_UTF8(data) :
    parameter = (data) 
    parameter = parameter.encode("utf-8")
    return (parameter)

def get_chrome_mobile_options(user_agent_string):
		chrome_options = webdriver.ChromeOptions()
		chrome_options.add_argument("--user-agent={0}".format(user_agent_string))
		return chrome_options

def set_number_format_2digit(data) :
    print(data)
    new_data = decimal.Decimal(str(data)).quantize(decimal.Decimal('.01'), rounding=decimal.ROUND_HALF_UP)
    print(new_data)
    result = "{0:,.2f}".format(float(new_data))
    print(result)
    return result

def set_number_format_4digit(data) :
    result = "{0:,.4f}".format(float(data))
    return result

#def delete_invoice_redis_session() :
#     redis_db = redis.StrictRedis(host="beta-redis.oneplanets.com", port=6379, db=0)
#     key = redis_db.keys()

#     for i in key :
#         if 'InvoiceCreateGRSession' in i :
#             print(i)
#             redis_db.delete(i)

def random_int(start,end) :
    result = random.randint(int(start),int(end))

    return result