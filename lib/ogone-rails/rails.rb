# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), 'helpers')

ActionView::Base.send(:include, OgoneRails::Helpers) if defined? ActionView
