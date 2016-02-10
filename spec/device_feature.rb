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
      page.add ""         
      not_first = false
      page.promo_elements.each do |prom|        
        expect(prom.value != "").to be_truthy if (not_first && prom.visible?) 
        not_first = true
      end         
    end   

    it "user can add promo" do      
      page.add(promo_name)      
     
      # page.save_screenshot "add_1_promo.png" if page.has_expected_element?
      # binding.pry       
      page = AdminPage.new(browser, true)     
      # page.add(promo_name)
      # page = AdminPage.new(browser, true)
      # page.save_screenshot "add_2_promo.png" if page.has_expected_element?
      # page.alert_element.when_present 
      # expect(page.alert.include?  "Промо #{promo_name} уже существует").to be_truthy
      # page.save_screenshot "add_1_promo.png"   if page.has_expected_element?
      exists=false
      # page.save_screenshot "add_2_promo.png" if page.has_expected_element?
      page.promo_elements.each do |prom|
        if prom.value == promo_name          
          exists = true
          break
        end
      end
      expect(exists).to be_truthy


      # page.ok      
    end

    after (:all) do
      page = AdminPage.new(browser, true)
      page.has_expected_element?
      i=0
      page.promo_elements.each do |prom|
        if (prom.value == promo_name)
          page.delete(i-1) 
          break
        end
        i = i+1
      end
    end
  end  

end