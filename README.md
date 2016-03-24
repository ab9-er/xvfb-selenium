# xvfb-selenium
Xvfb based selenium supporting firefox and chromium

This image uses `alpine:3.3` as its base image and contains firefox and chromium.

Simply run this image and map the ports.

To verify if the selenium hub is available locally,

- Copy the IP address of the docker machine
- Shoot up a browser and go to `http://IP_ADDRESS:4444/wd/hub`

To execute a test on a remote firefox browser initialise the webdriver as follows

~~~python
from selenium import webdriver

remote_firefox = webdriver.Remote(command_executor="http://192.168.99.100:4444/wd/hub",desired_capabilities={'browserName':'firefox'})
~~~

You can find an image ready to be consumed on Docker Hub @

`ab9er/xvfb-selenium:latest`

For more details, send me an email on,

`abhinav.gamer@gmail.com`

or send a tweet to `@a_bhi_9`
