# OWASP-ZAP-Docker-Auth-Scan-Using-Selenium-Python

This project adds support to perform authenticated scans using the OWASP ZAP Docker.

This tool automates web application login and retrieves authentication cookies , which are then passed to the OWASP ZAP for an authenticated scan. Since this authentication solution uses a web driver a custom image is needed to meet these requirements.
 
use **docker build** command to build the docker image from the Dockerfile.

1. ``git clone https://github.com/akashc99/OWASP-ZAP-Docker-Auth-Scan-Using-Selenium-Python.git``
2. ``cd OWASP-ZAP-Docker-Auth-Scan-Using-Selenium-Python``
3. ``sudo docker build -t zap2docker .``

# Examples using authentication scan

Running a passive scan with automatic authentication.

`` sudo docker run --rm -v $(pwd):/zap/wrk/:rw -t zap2docker:latest bash baseline.sh $URL $LOGIN_EMAIL $LOGIN_PASSWORD $USERNAME_FIELD $PASSWORD_FIELD $SUBMIT_FIELD ``

Running a full scan (max 10 mins spider and max 60 min scanning) with automatic authentication.

`` sudo docker run --rm -v $(pwd):/zap/wrk/:rw -t zap2docker:latest bash fullscan.sh $URL $LOGIN_EMAIL $LOGIN_PASSWORD $USERNAME_FIELD $PASSWORD_FIELD $SUBMIT_FIELD ``

1. $URL : URL of the application.
2. $LOGIN_EMAIL : A valid username.
3. $LOGIN_PASSWORD : A valid password.
4. $USERNAME_FIELD : The HTML id attribute of the username field.
5. $PASSWORD_FIELD : The HTML id attribute of the password field.
6. $SUBMIT_FIELD : The HTML id attribute of the submit field.


For more info on the different scantypes and parameters take a look at: https://www.zaproxy.org/docs/docker/

