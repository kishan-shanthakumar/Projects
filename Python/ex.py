import ctypes
from ctypes import wintypes
import time
import random
import string

start_time = time.time()

strlen_S = 10

user32 = ctypes.WinDLL('user32', use_last_error=True)

INPUT_MOUSE    = 0
INPUT_KEYBOARD = 1
INPUT_HARDWARE = 2

KEYEVENTF_EXTENDEDKEY = 0x0001
KEYEVENTF_KEYUP       = 0x0002
KEYEVENTF_UNICODE     = 0x0004
KEYEVENTF_SCANCODE    = 0x0008

MAPVK_VK_TO_VSC = 0

# msdn.microsoft.com/en-us/library/dd375731
VK_TAB  = 0x09
VK_MENU = 0x12
VK_CONTROL = 0x11
VK_RETURN = 0x0D
VK_LSHIFT = 0x10

# C struct definitions

wintypes.ULONG_PTR = wintypes.WPARAM

class MOUSEINPUT(ctypes.Structure):
    _fields_ = (("dx",          wintypes.LONG),
                ("dy",          wintypes.LONG),
                ("mouseData",   wintypes.DWORD),
                ("dwFlags",     wintypes.DWORD),
                ("time",        wintypes.DWORD),
                ("dwExtraInfo", wintypes.ULONG_PTR))

class KEYBDINPUT(ctypes.Structure):
    _fields_ = (("wVk",         wintypes.WORD),
                ("wScan",       wintypes.WORD),
                ("dwFlags",     wintypes.DWORD),
                ("time",        wintypes.DWORD),
                ("dwExtraInfo", wintypes.ULONG_PTR))

    def __init__(self, *args, **kwds):
        super(KEYBDINPUT, self).__init__(*args, **kwds)
        # some programs use the scan code even if KEYEVENTF_SCANCODE
        # isn't set in dwFflags, so attempt to map the correct code.
        if not self.dwFlags & KEYEVENTF_UNICODE:
            self.wScan = user32.MapVirtualKeyExW(self.wVk,
                                                 MAPVK_VK_TO_VSC, 0)

class HARDWAREINPUT(ctypes.Structure):
    _fields_ = (("uMsg",    wintypes.DWORD),
                ("wParamL", wintypes.WORD),
                ("wParamH", wintypes.WORD))

class INPUT(ctypes.Structure):
    class _INPUT(ctypes.Union):
        _fields_ = (("ki", KEYBDINPUT),
                    ("mi", MOUSEINPUT),
                    ("hi", HARDWAREINPUT))
    _anonymous_ = ("_input",)
    _fields_ = (("type",   wintypes.DWORD),
                ("_input", _INPUT))

LPINPUT = ctypes.POINTER(INPUT)

def _check_count(result, func, args):
    if result == 0:
        raise ctypes.WinError(ctypes.get_last_error())
    return args

user32.SendInput.errcheck = _check_count
user32.SendInput.argtypes = (wintypes.UINT, # nInputs
                             LPINPUT,       # pInputs
                             ctypes.c_int)  # cbSize

# Functions

def PressKey(hexKeyCode):
    x = INPUT(type=INPUT_KEYBOARD,
              ki=KEYBDINPUT(wVk=hexKeyCode))
    user32.SendInput(1, ctypes.byref(x), ctypes.sizeof(x))

def ReleaseKey(hexKeyCode):
    x = INPUT(type=INPUT_KEYBOARD,
              ki=KEYBDINPUT(wVk=hexKeyCode,
                            dwFlags=KEYEVENTF_KEYUP))
    user32.SendInput(1, ctypes.byref(x), ctypes.sizeof(x))

def AltTab():
    """Press Alt+Tab and hold Alt key for 2 seconds
    in order to see the overlay.
    """
    PressKey(VK_MENU)   # Alt
    PressKey(VK_TAB)    # Tab
    ReleaseKey(VK_TAB)  # Tab~
    time.sleep(0.05)
    ReleaseKey(VK_MENU) # Alt~

fi = open("lookup.txt",'r')
lookup = fi.readlines()
for i in range(len(lookup)):
    lookup[i] = lookup[i].split()[:-1]

lookup = dict(lookup)
lookup = dict((v,k) for k,v in lookup.items())

def text_lookup(inp):
    inp = inp.upper()
    if len(inp)==0:
        return
    elif inp == '\n':
        time.sleep(0.05)
        PressKey(VK_RETURN)
        time.sleep(0.05)
        ReleaseKey(VK_RETURN)
    elif inp == ' ':
        PressKey(0x20)
        time.sleep(0.05)
        ReleaseKey(0x20)
    elif inp == '(':
        PressKey(VK_LSHIFT)
        time.sleep(0.05)
        PressKey(0x39)
        time.sleep(0.05)
        ReleaseKey(0x39)
        time.sleep(0.05)
        ReleaseKey(VK_LSHIFT)
    elif inp == ')':
        PressKey(VK_LSHIFT)
        time.sleep(0.05)
        PressKey(0x30)
        time.sleep(0.05)
        ReleaseKey(0x30)
        time.sleep(0.05)
        ReleaseKey(VK_LSHIFT)
    elif inp == '#':
        PressKey(VK_LSHIFT)
        time.sleep(0.05)
        PressKey(0x33)
        time.sleep(0.05)
        ReleaseKey(0x33)
        time.sleep(0.05)
        ReleaseKey(VK_LSHIFT)
    elif inp == '+':
        PressKey(VK_LSHIFT)
        time.sleep(0.05)
        PressKey(int(lookup['='],0))
        time.sleep(0.05)
        ReleaseKey(int(lookup['='],0))
        time.sleep(0.05)
        ReleaseKey(VK_LSHIFT)
    elif inp == ':':
        PressKey(VK_LSHIFT)
        time.sleep(0.05)
        PressKey(int(lookup[';'],0))
        time.sleep(0.05)
        ReleaseKey(int(lookup[';'],0))
        time.sleep(0.05)
        ReleaseKey(VK_LSHIFT)
    elif inp == '_':
        PressKey(VK_LSHIFT)
        time.sleep(0.05)
        PressKey(int(lookup['-'],0))
        time.sleep(0.05)
        ReleaseKey(int(lookup['-'],0))
        time.sleep(0.05)
        ReleaseKey(VK_LSHIFT)
    elif inp == '<':
        PressKey(VK_LSHIFT)
        time.sleep(0.05)
        PressKey(int(lookup[','],0))
        time.sleep(0.05)
        ReleaseKey(int(lookup[','],0))
        time.sleep(0.05)
        ReleaseKey(VK_LSHIFT)
    elif inp == '>':
        PressKey(VK_LSHIFT)
        time.sleep(0.05)
        PressKey(int(lookup['.'],0))
        time.sleep(0.05)
        ReleaseKey(int(lookup['.'],0))
        time.sleep(0.05)
        ReleaseKey(VK_LSHIFT)
    else:
        for i in inp:
            PressKey(int(lookup[i],0))
            time.sleep(0.05)
            ReleaseKey(int(lookup[i],0))

AltTab()
for i in range(1000000):
    time.sleep(0.05)
    ran = ''.join(random.choices(string.ascii_uppercase + string.digits, k = random.randint(1,5)))
    text_lookup(ran)
    PressKey(VK_RETURN)
    ReleaseKey(VK_RETURN)

print(time.time()-start_time)