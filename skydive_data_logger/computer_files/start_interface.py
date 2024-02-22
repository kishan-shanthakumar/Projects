import tkinter as tk
from tkinter import ttk # all the widgets
from ttkbootstrap.toast import ToastNotification
import _thread
import time
try:
    from sensor_read import Sensors
except:
    print('import failed')

try:
    sensor = Sensors()
    _thread.start_new_thread(sensor.sensor_read ,(1, ))
except:
    print('Setup failed')

def update_window():
    # Update label values with new data
    try:
        di = sensor.values()
    except:
        pass
    try:
        lat_lon_label.config(text=di['gps']['lat']+' '+di['gps']['lon'])
        alt_label.config(text=di['gps']['alt']+' '+'m')

    except:
        print('GPS Data extraction failed')
        lat_lon_label.config(text='Not found')
        alt_label.config(text='Not found')

    try:
        acc_x_label.config(text='{:.2f} m /s\u00b2'.format(di['mpu6050']['ax']))
        acc_y_label.config(text='{:.2f} m /s\u00b2'.format(di['mpu6050']['ay']))
        acc_z_label.config(text='{:.2f} m /s\u00b2'.format(di['mpu6050']['az']))
        gy_x_label.config(text='{:.2f} deg /s'.format(di['mpu6050']['gx']))
        gy_y_label.config(text='{:.2f} deg /s'.format(di['mpu6050']['gy']))
        gy_z_label.config(text='{:.2f} deg /s'.format(di['mpu6050']['gz']))
        calc_gy_x_label.config(text='{:.2f} deg'.format(di['calc']['ox']))
        calc_gy_y_label.config(text='{:.2f} deg'.format(di['calc']['oy']))
        calc_gy_z_label.config(text='{:.2f} deg'.format(di['calc']['oz']))
        
    except:
        print('MPU Data extraction failed')
        acc_x_label.config(text='Not found')
        acc_y_label.config(text='Not found')
        acc_z_label.config(text='Not found')
        gy_x_label.config(text='Not found')
        gy_y_label.config(text='Not found')
        gy_z_label.config(text='Not found')
        calc_gy_x_label.config(text='Not found')
        calc_gy_y_label.config(text='Not found')
        calc_gy_z_label.config(text='Not found')

    try:
        pres_label.config(text='{:.2f} Pa'.format(di['dps']['pr']))
        temp_label.config(text='{:.2f} C'.format(di['dps']['te']))

    except:
        print('DPS Data extraction failed')
        pres_label.config(text='Not found')
        temp_label.config(text='Not found')

    try:
        e_temp_label.config(text='{:.2f} C'.format(di['et']))

    except:
        print('MCP Data extraction failed')
        e_temp_label.config(text='Not found')
        

    # Schedule the next update using `after` method
    window.after(1000, update_window) 

def start_log():
    try:
        if sensor.log == 1:
            toast_running.show_toast()
        else:
            sensor.start_log()
            toast_start.show_toast()
    except NameError:
        toast_error.show_toast()

def stop_log():
    try:
        if sensor.log == 0:
            toast_stopped.show_toast()
        else:
            fi = sensor.stop_log()
            toast_stop = ToastNotification(title="Stopping",
            message="Stopping Sensor Data Log and Saving file "+fi,
            duration=3000,
            alert=True,
            )
            toast_stop.show_toast()
    except NameError:
        toast_error.show_toast()

# Create a window
window = tk.Tk()
window.title('Sensor Data Logger') # title of the window
window.geometry('800x480') # size of the window

tabControl = ttk.Notebook(window) 

main_frame = ttk.Frame(tabControl)

tabControl.add(main_frame, text ='Live Sensor Data') 

canvas = tk.Canvas(main_frame, width=500, height=400)
canvas.pack(side="left", expand=1)

my_scrollbar = tk.Scrollbar(main_frame, orient="vertical", command=canvas.yview)
my_scrollbar.pack(side="right", fill="y")

# configure the canvas
canvas.configure(yscrollcommand=my_scrollbar.set)
canvas.bind(
    '<Configure>', lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
)

second_frame = ttk.Frame(canvas, height = 800)

# title
title_label = ttk.Label(
    master = second_frame, 
    text = 'Live Sensor Data', 
    font = 'Arial 18 bold')
title_label.pack()

# output
# GPS Data Frame
gps_frame = ttk.Frame(master = second_frame)
lat_lon_frame = ttk.Frame(master = gps_frame)
alt_frame = ttk.Frame(master = gps_frame)

gps_title = ttk.Label(
    master = gps_frame, 
    text = 'GPS Data', 
    font = 'Arial 16')

lat_lon_text = ttk.Label(
    master = lat_lon_frame, 
    text = 'Co-ordinates\t', 
    font = 'Arial 12')

lat_lon_label = ttk.Label(
    master = lat_lon_frame, 
    text = 'Output', 
    font = 'Arial 12')

alt_text = ttk.Label(
    master = alt_frame, 
    text = 'Altitude\t\t', 
    font = 'Arial 12')

alt_label = ttk.Label(
    master = alt_frame, 
    text = 'Output', 
    font = 'Arial 12')

gps_title.pack()
lat_lon_text.pack(side = 'left')
lat_lon_label.pack(side = 'left')
alt_text.pack(side = 'left')
alt_label.pack(side = 'left')
lat_lon_frame.pack()
alt_frame.pack()
gps_frame.pack(pady = 20)

# MPU Data Frame
mpu_frame = ttk.Frame(master = second_frame)
x_frame = ttk.Frame(master = mpu_frame)
y_frame = ttk.Frame(master = mpu_frame)
z_frame = ttk.Frame(master = mpu_frame)

mpu_title = ttk.Label(
    master = mpu_frame, 
    text = 'Accelerometer and Gyroscope', 
    font = 'Arial 16')

acc_x_text = ttk.Label(
    master = x_frame, 
    text = 'Acc X\t',
    font = 'Arial 12')

acc_y_text = ttk.Label(
    master = y_frame, 
    text = 'Acc Y\t',
    font = 'Arial 12')

acc_z_text = ttk.Label(
    master = z_frame, 
    text = 'Acc Z\t',
    font = 'Arial 12')

gy_x_text = ttk.Label(
    master = x_frame, 
    text = '\t\tGy X\t',
    font = 'Arial 12')

gy_y_text = ttk.Label(
    master = y_frame, 
    text = '\t\tGy Y\t',
    font = 'Arial 12')

gy_z_text = ttk.Label(
    master = z_frame, 
    text = '\t\tGy Z\t',
    font = 'Arial 12')

acc_x_label = ttk.Label(
    master = x_frame, 
    text = 'Output', 
    font = 'Arial 12')

acc_y_label = ttk.Label(
    master = y_frame, 
    text = 'Output', 
    font = 'Arial 12')

acc_z_label = ttk.Label(
    master = z_frame, 
    text = 'Output', 
    font = 'Arial 12')

gy_x_label = ttk.Label(
    master = x_frame, 
    text = 'Output', 
    font = 'Arial 12')

gy_y_label = ttk.Label(
    master = y_frame, 
    text = 'Output', 
    font = 'Arial 12')

gy_z_label = ttk.Label(
    master = z_frame, 
    text = 'Output', 
    font = 'Arial 12')

mpu_title.pack()
acc_x_text.pack(side='left')
acc_y_text.pack(side='left')
acc_z_text.pack(side='left')
acc_x_label.pack(side='left')
acc_y_label.pack(side='left')
acc_z_label.pack(side='left')
gy_x_text.pack(side='left')
gy_y_text.pack(side='left')
gy_z_text.pack(side='left')
gy_x_label.pack(side='left')
gy_y_label.pack(side='left')
gy_z_label.pack(side='left')
x_frame.pack()
y_frame.pack()
z_frame.pack()
mpu_frame.pack(pady = 20)

# Calc Data Frame
calc_frame = ttk.Frame(master = second_frame)
calc_x_frame = ttk.Frame(master = calc_frame)
calc_y_frame = ttk.Frame(master = calc_frame)
calc_z_frame = ttk.Frame(master = calc_frame)

calc_title = ttk.Label(
    master = calc_frame, 
    text = 'Orientation', 
    font = 'Arial 16')

calc_gy_x_text = ttk.Label(
    master = calc_x_frame, 
    text = '\t\tOr X\t',
    font = 'Arial 12')

calc_gy_y_text = ttk.Label(
    master = calc_y_frame, 
    text = '\t\tOr Y\t',
    font = 'Arial 12')

calc_gy_z_text = ttk.Label(
    master = calc_z_frame, 
    text = '\t\tOr Z\t',
    font = 'Arial 12')

calc_gy_x_label = ttk.Label(
    master = calc_x_frame, 
    text = 'Output', 
    font = 'Arial 12')

calc_gy_y_label = ttk.Label(
    master = calc_y_frame, 
    text = 'Output', 
    font = 'Arial 12')

calc_gy_z_label = ttk.Label(
    master = calc_z_frame, 
    text = 'Output', 
    font = 'Arial 12')

calc_title.pack()
calc_gy_x_text.pack(side='left')
calc_gy_x_label.pack(side='left')
calc_x_frame.pack()
calc_gy_y_text.pack(side='left')
calc_gy_y_label.pack(side='left')
calc_y_frame.pack()
calc_gy_z_text.pack(side='left')
calc_gy_z_label.pack(side='left')
calc_z_frame.pack()
calc_frame.pack(pady = 20)

# DPS Frame
dps_frame = ttk.Frame(master = second_frame)
pres_frame = ttk.Frame(master = dps_frame)
temp_frame = ttk.Frame(master = dps_frame)

dps_title = ttk.Label(
    master = dps_frame, 
    text = 'Pressure and Temperature', 
    font = 'Arial 16')

pres_text = ttk.Label(
    master = pres_frame, 
    text = 'Pressure\t\t', 
    font = 'Arial 12')

pres_label = ttk.Label(
    master = pres_frame,
    text = 'Output',
    font = 'Arial 12')

temp_text = ttk.Label(
    master = temp_frame, 
    text = 'Temperature\t', 
    font = 'Arial 12')

temp_label = ttk.Label(
    master = temp_frame,
    text = 'Output',
    font = 'Arial 12')

dps_title.pack()
pres_text.pack(side = 'left')
pres_label.pack(side = 'left')
pres_frame.pack()
temp_text.pack(side = 'left')
temp_label.pack(side = 'left')
temp_frame.pack()
dps_frame.pack(pady = 20)

# MCP Frame
mcp_frame = ttk.Frame(master = second_frame)
e_temp_frame = ttk.Frame(master = mcp_frame)

mcp_title = ttk.Label(
    master = mcp_frame, 
    text = 'External Temperature', 
    font = 'Arial 16')

e_temp_text = ttk.Label(
    master = e_temp_frame, 
    text = 'Temperature\t', 
    font = 'Arial 12')

e_temp_label = ttk.Label(
    master = e_temp_frame,
    text = 'Output',
    font = 'Arial 12')

mcp_title.pack()
e_temp_text.pack(side = 'left')
e_temp_label.pack(side = 'left')
e_temp_frame.pack()
mcp_frame.pack(pady = 20)

canvas.create_window((0, 0), window=second_frame, anchor="nw")

main_frame2 = ttk.Frame(tabControl)
tabControl.add(main_frame2, text ='Sensor Data Logger')

button_start = ttk.Button(main_frame2, text='Start Data Log', command=start_log)
button_stop = ttk.Button(main_frame2, text='Stop Data Log', command=stop_log)

button_start.pack(pady=20)
button_stop.pack(pady=20)

toast_start = ToastNotification(title="Starting",
	message="Starting Sensor Data Log",
	duration=3000,
	alert=True,
	)

toast_running = ToastNotification(title="Error",
	message="A log is already running",
	duration=3000,
	alert=True,
	)

toast_stopped = ToastNotification(title="Error",
	message="Starting Sensor Data Log",
	duration=3000,
	alert=True,
	)

toast_error = ToastNotification(title="Error",
	message="Sensors not found",
	duration=3000,
	alert=True,
	)

tabControl.pack(expand=1, fill='both')

# Run
time.sleep(1)
update_window()
window.mainloop()