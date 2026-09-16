import _thread
import time

# Define a function for the thread
def print_time( threadName, delay):
   while 1:
      time.sleep(delay)
      print(threadName )

# Create two threads as follows
try:
   _thread.start_new_thread( print_time, ("Thread-1", 1, ) )
   _thread.start_new_thread( print_time, ("Thread-2", 2, ) )
except:
   print( "Error: unable to start thread")

while 1:
   pass

