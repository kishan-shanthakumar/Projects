import tkinter as tk
from tkinter import ttk # all the widgets
# import ttkbootstrap as ttk

# Create a window
window = tk.Tk()
window.title('Sensor Data Logger') # title of the window
window.geometry('800x480') # size of the window

# title
title_label = ttk.Label(
    master = window, 
    text = 'Live Sensor Data', 
    font = 'Arial 18 bold')
title_label.pack()

# output
# GPS Data Frame
gps_frame = ttk.Frame(master = window)
lat_lon_frame = ttk.Frame(master = gps_frame)
alt_frame = ttk.Frame(master = gps_frame)

gps_title = ttk.Label(
    master = gps_frame, 
    text = 'GPS Data', 
    font = 'Arial 16')

lat_lon = tk.StringVar()
lat_lon.set('52.12.4 N\t0.9.44 E')

alt = tk.StringVar()
alt.set('55 m')

lat_lon_text = ttk.Label(
    master = lat_lon_frame, 
    text = 'Co-ordinates\t', 
    font = 'Arial 12')

lat_lon_label = ttk.Label(
    master = lat_lon_frame, 
    text = 'Output', 
    font = 'Arial 12', 
    textvariable = lat_lon)

alt_text = ttk.Label(
    master = alt_frame, 
    text = 'Altitude\t\t', 
    font = 'Arial 12')

alt_label = ttk.Label(
    master = alt_frame, 
    text = 'Output', 
    font = 'Arial 12', 
    textvariable = alt)

gps_title.pack()
lat_lon_text.pack(side = 'left')
lat_lon_label.pack(side = 'left')
alt_text.pack(side = 'left')
alt_label.pack(side = 'left')
lat_lon_frame.pack()
alt_frame.pack()
gps_frame.pack(pady = 20)

# MPU Data Frame
mpu_frame = ttk.Frame(master = window)
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

acc_x = tk.StringVar()
acc_x.set('0 g')
acc_y = tk.StringVar()
acc_y.set('0 g')
acc_z = tk.StringVar()
acc_z.set('1 g')

gy_x = tk.StringVar()
gy_x.set('0 /s')
gy_y = tk.StringVar()
gy_y.set('0 /s')
gy_z = tk.StringVar()
gy_z.set('0 /s')

acc_x_label = ttk.Label(
    master = x_frame, 
    text = 'Output', 
    font = 'Arial 12',
    textvariable = acc_x)

acc_y_label = ttk.Label(
    master = y_frame, 
    text = 'Output', 
    font = 'Arial 12',
    textvariable = acc_y)

acc_z_label = ttk.Label(
    master = z_frame, 
    text = 'Output', 
    font = 'Arial 12',
    textvariable = acc_z)

gy_x_label = ttk.Label(
    master = x_frame, 
    text = 'Output', 
    font = 'Arial 12',
    textvariable = gy_x)

gy_y_label = ttk.Label(
    master = y_frame, 
    text = 'Output', 
    font = 'Arial 12',
    textvariable = gy_y)

gy_z_label = ttk.Label(
    master = z_frame, 
    text = 'Output', 
    font = 'Arial 12',
    textvariable = gy_z)

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
dps_frame = ttk.Frame(master = window)
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

pres = tk.StringVar()
pres.set('97850 Pa')

pres_label = ttk.Label(
    master = pres_frame,
    text = 'Output',
    font = 'Arial 12',
    textvariable = pres)

temp_text = ttk.Label(
    master = temp_frame, 
    text = 'Temperature\t', 
    font = 'Arial 12')

temp = tk.StringVar()
temp.set('25.8 C')

temp_label = ttk.Label(
    master = temp_frame,
    text = 'Output',
    font = 'Arial 12',
    textvariable = temp)

dps_title.pack()
pres_text.pack(side = 'left')
pres_label.pack(side = 'left')
pres_frame.pack()
temp_text.pack(side = 'left')
temp_label.pack(side = 'left')
temp_frame.pack()
dps_frame.pack(pady = 20)

# MCP Frame
mcp_frame = ttk.Frame(master = window)
e_temp_frame = ttk.Frame(master = mcp_frame)

mcp_title = ttk.Label(
    master = mcp_frame, 
    text = 'External Temperature', 
    font = 'Arial 16')

e_temp_text = ttk.Label(
    master = e_temp_frame, 
    text = 'Temperature\t', 
    font = 'Arial 12')

e_temp = tk.StringVar()
e_temp.set('25.8 C')

e_temp_label = ttk.Label(
    master = e_temp_frame,
    text = 'Output',
    font = 'Arial 12',
    textvariable = e_temp)

mcp_title.pack()
e_temp_text.pack(side = 'left')
e_temp_label.pack(side = 'left')
e_temp_frame.pack()
mcp_frame.pack(pady = 20)

# Run
window.mainloop()