import tkinter as tk
from tkinter import ttk # all the widgets
import sensor_read
# import ttkbootstrap as ttk

def update_window():
    # Update label values with new data
    di = sensor_read.sensor_read()
    lat_lon_label.config(text='Not found')
    alt_label.config(text='Not found')
    acc_x_label.config(text='{:.2f} m /s\u00b2'.format(di['mpu6050']['ax']))
    acc_y_label.config(text='{:.2f} m /s\u00b2'.format(di['mpu6050']['ay']))
    acc_z_label.config(text='{:.2f} m /s\u00b2'.format(di['mpu6050']['az']))
    gy_x_label.config(text='{:.2f} deg /s'.format(di['mpu6050']['gx']))
    gy_y_label.config(text='{:.2f} deg /s'.format(di['mpu6050']['gy']))
    gy_z_label.config(text='{:.2f} deg /s'.format(di['mpu6050']['gz']))
    pres_label.config(text='{:.2f} Pa'.format(di['dps']['pr']))
    temp_label.config(text='{:.2f} C'.format(di['dps']['te']))
    e_temp_label.config(text='Not found')

    # Schedule the next update using `after` method
    window.after(1000, update_window) 

# Create a window
window = tk.Tk()
window.title('Sensor Data Logger') # title of the window
window.geometry('800x480') # size of the window

main_frame = ttk.Frame(window)
main_frame.pack(fill="both", expand=1)

canvas = tk.Canvas(main_frame)
canvas.pack(side="left", fill="both", expand=1)

my_scrollbar = tk.Scrollbar(main_frame, orient="vertical", command=canvas.yview)
my_scrollbar.pack(side="right", fill="y")

# mx_scrollbar = tk.Scrollbar(main_frame, orient="horizontal", command=canvas.xview)
# mx_scrollbar.pack(side="bottom", fill="x")

# configure the canvas
canvas.configure(yscrollcommand=my_scrollbar.set)
canvas.bind(
    '<Configure>', lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
)

# canvas.configure(xscrollcommand=mx_scrollbar.set)
# canvas.bind(
#     '<Configure>', lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
# )

second_frame = ttk.Frame(canvas, width = 786, height = 800)

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

# Run
update_window()
window.mainloop()