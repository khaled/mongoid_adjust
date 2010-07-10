require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

Mongoid.configure.master = Mongo::Connection.new.db('acts_as_list-test')

class Person
  include Mongoid::Document
  field :name, :type => String
  embeds_many :lists 
  
  # after_update :do_it    
  # def do_it
  #   puts "hello"
  # end
end  

class PosPerson
  include Mongoid::Document
  field :pos, :type => Integer
  field :name, :type => String
  embeds_many :lists   
end  


class List
  include Mongoid::Document
  field :pos, :type => Integer
  field :name, :type => String
  embedded_in :person, :inverse_of => :lists
  
  embeds_many :items
end


class Item
  include Mongoid::Document
  field :pos, :type => Integer  
  field :number, :type => Integer  
  
  field :assoc, :type => Symbol
  embedded_in :list, :inverse_of => :items   
end

describe "MongoidAdjust" do
  
  before :each do
    @person = Person.create! :name => 'Kristian'
    @pos_person = PosPerson.create! :name => 'Kristian'
    # person.lists = []               
    list = List.new :pos => 1, :name => 'My list'
    (1..3).each do |counter|  
      item = Item.new :pos => counter, :number => counter
      list.items << item  
    end
    @person.lists << list
    @person.save!
  end
  
  after :each do
    Mongoid.database.collections.each do |coll|
      coll.remove
    end
  end  
  
  describe '#adjust! numeric' do                            
    context 'on an array' do
      it "should add 1 to all positions greater than 1" do
        result = @person.lists[0].items.where(:pos.gt => 1).to_a.adjust!(:pos => 1)
        result.map(&:pos).should == [3, 4]
      end
    end

    context 'on a criteria' do
      it "should add 1 to all positions greater than 1" do
        result = @person.lists[0].items.where(:pos.gt => 1).adjust!(:pos => 1)
        result.map(&:pos).should == [3, 4]
      end
    end

    context 'on a document with a pos' do           
      it "should add 1 to the position" do      
        result = @pos_person.adjust!(:pos => 1)
        result.pos.should == 1
      end
    end

    context 'on a document without a pos field' do           
      it "should NOT add 1 to the position" do      
        result = @person.adjust!(:pos => 1)
        lambda {result.pos}.should raise_error
      end
    end  
  end

  describe '#adjust! by proc' do
    context 'on an array' do
      it "should times all positions (greater than 1) by 2" do
        result = @person.lists[0].items.where(:pos.gt => 1).to_a.adjust!(:pos => lambda {|e| e * 2})
        result.map(&:pos).should == [4, 6]
      end
    end

    context 'on a criteria' do
      it "should times all positions (greater than 1) by 2" do
        result = @person.lists[0].items.where(:pos.gt => 1).adjust!(:pos => lambda {|e| e * 2})
        result.map(&:pos).should == [4, 6]
      end
    end

    context 'on a document with a name field' do           
      it "should upcase the name" do      
        result = @person.adjust!(:name => lambda {|e| e.upcase })
        result.name.should == 'Kristian'.upcase
      end
    end            
  end          
  
  describe '#adjust! by symbol and string' do
    context 'on a document with a name field' do           
      it "should upcase the name - using string arg" do      
        result = @person.adjust!(:name => 'upcase')
        result.name.should == 'Kristian'.upcase
      end
    end            

    context 'on a document with a name field' do           
      it "should upcase the name - using symbol arg" do      
        result = @person.adjust!(:name => :upcase)
        result.name.should == 'Kristian'.upcase
      end
    end            
  end
end
