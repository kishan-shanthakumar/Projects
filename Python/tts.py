#TTS

import pyttsx3
engine=pyttsx3.init()
print("Enter 'qqq' to exit")
print("Enter the text")
txt=input()

while(txt!='qqq'):
    engine.say(txt)
    engine.runAndWait()
    print("Enter the text")
    txt=input()

print("Program successfully terminated")
