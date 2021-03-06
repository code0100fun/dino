#
# This is an example of how to use the sensor class
# with a potentiometer to control the flash speed of an
# LED. The set_delay callback reads from the potentiometer
# and changes the sleep delay for the LED on/off cycle.  
#  

require '../lib/dino'

board = Dino::Board.new(Dino::TxRx.new)
led = Dino::Components::Led.new(pin: 13, board: board)
potentiometer = Dino::Components::Sensor.new(pin: 'A0', board: board)

delay = 500.0

set_delay = Proc.new do |data|
  puts "DATA: #{delay = data.to_i}"
end

potentiometer.when_data_received(set_delay)

[:on, :off].cycle do |switch|
  puts "DELAY: #{seconds = (delay / 1000.0)}"
  led.send(switch)
  sleep seconds
end
