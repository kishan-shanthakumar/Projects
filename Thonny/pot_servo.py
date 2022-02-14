from machine import Pin, PWM, ADC

pwm = PWM(Pin(15))
adc = ADC(Pin(26))

pwm.freq(50)

while True:
	duty = adc.read_u16()
	duty = int(duty/20);
	duty += 3251
	pwm.duty_u16(duty)