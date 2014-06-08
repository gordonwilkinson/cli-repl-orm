require 'pry' 
require './contact'


class Application
  require 'pry'


  def initialize 
    @app_running = true 
  end      

  def run
    # init_database
    #todo valid input 
    while @app_running
      show_main_menu
      input = gets.chomp.strip 
      handle_menu_request (input)
    end
  end
 
  private
 
  # Prints the main menu only
  def show_main_menu
    puts "Welcome to the app. What's next?"
    puts " new      - Create a new contact"
    puts " show     - Show a contact"
    puts " update   - Update contact"
    puts " list     - List all contacts"
    puts " clear    - Clear the screen"
    puts " quit     - Exit Application"
    print ">"
  end


  #todo  check for sql injecttion!!!!!!!


  def new_customer_req
    parms = {}
    puts "Please enter first name:"
    new_firstname = gets.chomp.strip.capitalize
    parms[:firstname] = new_firstname
    puts "Please enter last name:"
    new_lname = gets.chomp.strip.capitalize
    parms[:lastname] = new_lname
    #todo email RFC 5322 REGEX '/^(?!(?>(?1)"?(?>\\\[ -~]|[^"])"?(?1)){255,})(?!(?>(?1)"?(?>\\\[ -~]|[^"])"?(?1)){65,}@)((?>(?>(?>((?>(?>(?>\x0D\x0A)?[\x09 ])+|(?>[\x09 ]*\x0D\x0A)?[\x09 ]+)?)(\((?>(?2)(?>[\x01-\x08\x0B\x0C\x0E-\'*-\[\]-\x7F]|\\\[\x00-\x7F]|(?3)))*(?2)\)))+(?2))|(?2))?)([!#-\'*+\/-9=?^-~-]+|"(?>(?2)(?>[\x01-\x08\x0B\x0C\x0E-!#-\[\]-\x7F]|\\\[\x00-\x7F]))*(?2)")(?>(?1)\.(?1)(?4))*(?1)@(?!(?1)[a-z0-9-]{64,})(?1)(?>([a-z0-9](?>[a-z0-9-]*[a-z0-9])?)(?>(?1)\.(?!(?1)[a-z0-9-]{64,})(?1)(?5)){0,126}|\[(?:(?>IPv6:(?>([a-f0-9]{1,4})(?>:(?6)){7}|(?!(?:.*[a-f0-9][:\]]){8,})((?6)(?>:(?6)){0,6})?::(?7)?))|(?>(?>IPv6:(?>(?6)(?>:(?6)){5}:|(?!(?:.*[a-f0-9]:){6,})(?8)?::(?>((?6)(?>:(?6)){0,4}):)?))?(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?9)){3}))\])(?1)$/isD'
    puts "Please enter email:"
    new_email = gets.chomp.strip
    parms[:email] = new_email
    puts "Please enter telephone number:"
    new_tel_number = gets.chomp.strip
    parms[:tel_number] = new_tel_number

        c = Contact.create(parms)
    
    puts "Welcome #{c.firstname}.\nYour email address #{c.email} has been added to the contacts list."
  
  end

  def list_customers_req
    # binding.pry 
    clist = Contact.all
    # binding.pry 
    if Contact.count > 0 
      puts ""
      clist = Contact.all
      clist.each do |contact|
        puts   contact.id << contact.firstname << " " << contact.lastname << " " << contact.email << " " << contact.tel_number
      end
      puts ""
    else
      
      puts "No contacts found."
    end   
  end

  def clear_screen_req
    puts "\e[H\e[2J"
  end


  def quit_request
    @app_running = false 

  end

  def show_customers_req 

    if !(Contact.all.nil?)  
      reg = '^[0-9]*$'
      puts "Please enter the customer id(999):"
      new_idx = gets.chomp.strip
      if new_idx.match(reg)  
        c = Contact.find(new_idx.to_i) 
        puts "Found"
        puts  c.firstname
        puts  c.lastname
        puts  c.email
        puts  c.tel_number
  
      else
        puts "Customer #{new_idx} not found " 

      end  
    else
      puts "No customers found."      
    end
  end


  def update_customers_req 

    if !(Contact.all.nil?)  
      reg = '^[0-9]*$'
      puts "Please enter the customer id(999):"
      new_idx = gets.chomp.strip
      if new_idx.match(reg)  
        
        contact = Contact.find(new_idx.to_i) 

        puts ""
        puts "First name: #{contact.firstname}"
        puts "Last name: #{contact.lastname}"
        puts "email name: #{contact.email}"
        puts "Telephone: #{contact.tel_number}"
       



        puts "Current first name: #{contact.firstname} - please enter new first name:"
        contact.firstname = gets.chomp.strip.capitalize
        puts "Current last name: #{contact.lastname} - please enter new last name:"
        contact.lastname = gets.chomp.strip.capitalize
        #todo email RFC 5322 REGEX '/^(?!(?>(?1)"?(?>\\\[ -~]|[^"])"?(?1)){255,})(?!(?>(?1)"?(?>\\\[ -~]|[^"])"?(?1)){65,}@)((?>(?>(?>((?>(?>(?>\x0D\x0A)?[\x09 ])+|(?>[\x09 ]*\x0D\x0A)?[\x09 ]+)?)(\((?>(?2)(?>[\x01-\x08\x0B\x0C\x0E-\'*-\[\]-\x7F]|\\\[\x00-\x7F]|(?3)))*(?2)\)))+(?2))|(?2))?)([!#-\'*+\/-9=?^-~-]+|"(?>(?2)(?>[\x01-\x08\x0B\x0C\x0E-!#-\[\]-\x7F]|\\\[\x00-\x7F]))*(?2)")(?>(?1)\.(?1)(?4))*(?1)@(?!(?1)[a-z0-9-]{64,})(?1)(?>([a-z0-9](?>[a-z0-9-]*[a-z0-9])?)(?>(?1)\.(?!(?1)[a-z0-9-]{64,})(?1)(?5)){0,126}|\[(?:(?>IPv6:(?>([a-f0-9]{1,4})(?>:(?6)){7}|(?!(?:.*[a-f0-9][:\]]){8,})((?6)(?>:(?6)){0,6})?::(?7)?))|(?>(?>IPv6:(?>(?6)(?>:(?6)){5}:|(?!(?:.*[a-f0-9]:){6,})(?8)?::(?>((?6)(?>:(?6)){0,4}):)?))?(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?9)){3}))\])(?1)$/isD'
        puts "Current email: #{contact.email} - please enter new email:"
        contact.email = gets.chomp.strip
        puts "Current telephone: #{contact.tel_number} - please enter new telephone number:"
        contact.tel_number = gets.chomp.strip

        puts "Contact info will be update to the following values"
        puts "First name: #{contact.firstname}"
        puts "Last name: #{contact.lastname}"
        puts "email name: #{contact.email}"
        puts "Telephone: #{contact.tel_number}"


        puts ""
        puts "Save changes? (y/n)"
        if gets.chomp.strip == 'y'
          contact.save   
          puts "#{contact.firstname} updated."
        else
          puts "Update cancelled."
        end  
        

      else
        puts "Customer #{new_idx} not found " 
      end  
    else
      puts "No customers found."      
    end
  end

  def handle_menu_request (input)
    if input == 'new'
      new_customer_req

    elsif input == 'show'
      show_customers_req
        
    elsif input == 'list'
      list_customers_req

    elsif input == 'update'
      update_customers_req

    elsif input == 'quit'
      quit_request

    elsif input == 'clear'    
      clear_screen_req

    else
      puts "Invalid input"      
    end
          
  end 

end