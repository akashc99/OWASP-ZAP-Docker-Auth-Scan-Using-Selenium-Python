import sys
from selenium import webdriver 
from warnings import filterwarnings
import time

def fetchcookie(url, email, password, user_field, password_field, submit_button_field):
    filterwarnings("ignore")
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    driver = webdriver.Chrome(options=options)
    driver.set_window_size(1920, 1080)
    driver.maximize_window()
    driver.get(url)
    time.sleep(25.0)

    driver.find_element_by_id(user_field).send_keys(email)
    time.sleep(1.0)
    driver.find_element_by_id (password_field).send_keys(password)
    time.sleep(1.0)
    driver.find_element_by_id(submit_button_field).click()
    time.sleep(25.0)

    # print all the cookies
    cookies_list = driver.get_cookies()
    cookies_dict = {}
    for cookie in cookies_list:
    	    cookies_dict[cookie['name']] = cookie['value']
    print(cookies_dict)
    driver.quit()

def main():
    if len(sys.argv) != 7:
        print ("(+) usage: %s <URL> <Email> <Password> <User_Field> <Password_Field> <Submit_Field>" % sys.argv[0])
        sys.exit(-1)
    url = sys.argv[1]
    email = sys.argv[2]
    password = sys.argv[3]
    user_field = sys.argv[4]
    password_field = sys.argv[5]
    submit_button_field = sys.argv[6]

    
    fetchcookie(url, email, password, user_field, password_field, submit_button_field)
    
if __name__ == "__main__":
    main()
