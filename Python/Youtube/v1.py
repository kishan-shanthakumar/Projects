import pyttsx3
engine=pyttsx3.init()

tts = "Hey everyone. I am THE ELECTRONICS guy. This channel is for electronics projects, elctronics basics tutorials, and some 3d modelling. It will also have some programming with python and other languages as well. Well programming is not just for computer science now, is it? So, all the entusiastic creaters out there; like and subscribe to this channel for interesting content. See you guys around."

engine.setProperty('rate', 140)
engine.setProperty('voice',"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Speech\Voices\Tokens\TTS_MS_EN-US_ZIRA_11.0")

engine.say(tts)
engine.runAndWait()
engine.save_to_file(tts,"v1.mp3")
engine.runAndWait()
