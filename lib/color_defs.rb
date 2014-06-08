require 'pry'
require 'term/ansicolor'
include Term::ANSIColor

module Term_Color
  RED = 0
  GREEN = 1
  BLUE = 2
  WHITE = 3
  BLACK =4
  YELLOW = 5
end

def display_msg_w_color (msg, req_color = Term_Color::WHITE)

  #  binding.pry 

  case req_color
    when Term_Color::WHITE
      puts  msg.white.bold
    when Term_Color::BLACK
      puts  msg.black.bold
    when Term_Color::RED
      puts  msg.red.bold
    when Term_Color::GREEN
      puts  msg.green.bold
    when Term_Color::BLUE
      puts  msg.blue.bold
    when Term_Color::YELLOW
      puts  msg.yellow.bold
    else
      puts  msg.white.bold
  end    


end  


