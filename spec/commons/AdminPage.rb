#!/bin/env ruby
# encoding: utf-8
require 'page-object'
require 'pry'
# require 'selenium/webdriver'


class AdminPage
  include PageObject
  page_url 'http://dev:1337dev@anuser.onederlink.7bits.it/admin'
    
  text_fields(:promo, css: ".form-control")     
  buttons(:delete , css: ".btn.btn-default.promo-list-item.delete-promo" )
  buttons(:edit, css: ".btn.btn-default.promo-list-item.edit-promo")
  button(:submit, class: "btn btn-default add-promo")
  expected_element(:submit, 10)

  div(:alert, class: "modal-content")
  button(:ok, class: "btn btn-primary")

  #add new promo
  def add(promo_name)   
    self.promo_elements[0].when_visible
    self.promo_elements[0].clear
    self.promo_elements[0].append(promo_name)
    self.submit  
  end

  #delete promo with number num
  def delete_by_n(num)
    self.delete_elements[num].click
    self.alert_element.when_present
    ok    
  end

  def delete(promo_name)
    i=0
      self.promo_elements.each do |prom|
        # prom.when_present
        if (prom.value == promo_name)
          self.delete_elements[i-1].click
          self.alert_element.when_present
          ok
          break
        end
        i = i+1
      end
  end

  #edit some promo
  def edit(num)
    self.edit_elements[num].click
  end

  def size
    self.promo_elements.size-1
  end
  
  def find(promo_name)
    exists = false    
    self.promo_elements.each do |prom|      
      if prom.value == promo_name          
        exists = true
        break
      end
    end
    exists
  end

end