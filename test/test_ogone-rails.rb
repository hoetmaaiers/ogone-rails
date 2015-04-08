# -*- encoding : utf-8 -*-
require 'helper'

class TestOgoneRails < Test::Unit::TestCase
  should "probably rename this file and start testing for real" do
    flunk "hey buddy, you should probably rename this file and start testing for real"
  end

  should "set amount correctly" do
    @ogone_fields = OgoneRails::Helpers.ogone_fields(amount: 586.8)
    assert_includes(@ogone_fields, "<input type='hidden' name='amount' value='58680' />")
  end
end
