require 'test/unit'

class Customer < ActiveRecord::Base; end

class HumanAttributeOverrideTest < Test::Unit::TestCase
  def teardown
    Customer.write_inheritable_attribute "attr_human_name", nil
  end
  
  def test_human_name_override
    # no human name overrides defined
    assert_nil Customer.human_name_attributes
    
    # test normal value of human attribute names
    assert_equal 'Address street', Customer.human_attribute_name('address_street')
    assert_equal 'Address city',   Customer.human_attribute_name('address_city')
    
    # override the humanized version
    Customer.attr_human_name 'address_street' => 'Street Address'
    
    # test that we now have the new version of the humanized attribute
    assert_equal 'Street Address', Customer.human_attribute_name('address_street')
    # test the unchanged attribute still converts normally
    assert_equal 'Address city',   Customer.human_attribute_name('address_city')

    # check the attributes that we've overridden exist
    assert_equal({'address_street' => 'Street Address'}, Customer.human_name_attributes)
  end
end
