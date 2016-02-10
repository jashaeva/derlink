#!/bin/env ruby
# encoding: utf-8
require "pry"

require_relative '../spec/spec_helper'
require_relative '../spec/commons/useful_func'
require_relative '../spec/commons/AdminPage'

describe "AdminPage" do
  page = nil
  promo_name = "promo_test_1"      

  context "Promo" do
    
    before (:each) do
      page = AdminPage.new(browser, true)
      expect(page.has_expected_element?).to be_truthy
    end

    it "promo's name can not be empty"   do
      page.add("")     
      not_first = false
      page.promo_elements.each do |prom|        
        expect(prom.value != "").to be_truthy if (not_first && prom.visible?) 
        not_first = true
      end         
    end   

    it "user can add promo" do      
      page.add(promo_name)           
      page = AdminPage.new(browser, true)           
      expect(page.find(promo_name)).to be_truthy        
    end


    after (:all) do
      page = AdminPage.new(browser, true)      
      expect(page.has_expected_element?).to be_truthy      
      page.delete(promo_name)                 
      page = AdminPage.new(browser, true)      
      expect(page.has_expected_element?).to be_truthy      
      expect(page.find(promo_name)).to be_falsey       
    end
  end  

end