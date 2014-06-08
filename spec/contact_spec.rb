
require 'rspec'

require 'pry'

require_relative 'contact'

describe Contact do
  subject(:contact) do
    Contact.new('joecool','joe@cool.com')
  end
  describe "Initialization test cases" do
    # Expect that now when you check the instantiated item's name and weight,
    # for it to match the information passed in above.
    it{ should be_an(Contact)}
    its(:name) { should eq("joecool") }
    its(:email) { should eq('joe@cool.com') }
  end
end


describe Contact do
  describe "to_s test cases:" do
    it "check to_s return a csv.. " do
      email_tst = 'joe@cool.com'
      name_tst = 'joe cool'
      display_string = name_tst << ',' << email_tst
      new_guy = Contact.new(name_tst, email_tst)
      new_guy.to_s.should eq(display_string)
    end
  end   
end

describe Contact do
  # use . for class methods
  describe ".create" do
    it "Class method create should fail if name and email are omitted" do
      # binding
      expect {Contact.create()}.to raise_error 
      # binding
    end
    it "Class method create should fail if name or email is omitted" do
      # binding
      email_tst = 'joe@cool.com'
      expect {Contact.create(email_tst)}.to raise_error 
      # binding
    end

    it "Class method create should fail if extra parms are passed: name, email, name" do
      # binding
      email_tst = 'joe@cool.com'
      expect {Contact.create(name_tst, email_tst,"parm3")}.to raise_error 
      # binding
    end
    it "Class method create should not raise an error " do
        # binding
        email_tst = 'joe@cool.com'
        name_tst = 'joe cool'  
        expect {Contact.create(name_tst, email_tst)}.not_to raise_error 
        # binding
    end

  end
  
  describe Contact do  
  # use . for class methods
    describe ".find" do
      it "will accept a customer list index and return contact by index" do
        email_tst = 'joe@cool.com'
        name_tst = 'joe cool'  
        #add a contact to the list.. 
        expect {Contact.create(name_tst, email_tst)}.not_to raise_error  
        
        expect(Contact.find(0)).to be_a_kind_of(Contact)
      end
    end
  end
 
  # use . for class methods
  describe ".all" do
    it "Return the list of contactts, as is: returns an array of contacts..." do
      #create a customer ... and verify that .all returns an array of contacts..    
      email_tst = 'joe@cool.com'
      name_tst = 'joe cool'  
      #add a contact to the list.. 
      Contact.create(name_tst, email_tst)
      expect(Contact.all).to be_an(Array)
      expect(Contact.all.size).to be > 0
    end
  end 
end