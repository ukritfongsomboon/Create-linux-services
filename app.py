import time
import os 

from datetime import datetime
while True:
    with open(os.path.join(os.getcwd(),"timestamp.txt"), "a") as f:
        f.write("The current timestamp is: " + str(datetime.now()))
        f.close()
    time.sleep(10)
