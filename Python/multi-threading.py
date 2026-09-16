import _thread
import time

# Define a function for the thread
def print_time( threadName, delay):
   while 1:
      time.sleep(delay)
      print( "%s: %s" % ( threadName, time.ctime(time.time()) ) )

# Create two threads as follows
try:
   _thread.start_new_thread( print_time, ("Thread-1", 1, ) )
   _thread.start_new_thread( print_time, ("Thread-2", 1.6, ) )
except:
   print( "Error: unable to start thread")

while 1:
   pass
