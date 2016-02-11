#!/bin/env ruby
# encoding: utf-8
require 'page-object'
require 'pry'
# require 'selenium/webdriver'


class PromoPage
  include PageObject
  
  expected_element(:new_name, 10)
  # promo
  text_field(:promo,    id: "promo-input")
  button(:edit_promo,   id: "enable-promo-edit")
  button(:commit_promo, id: "commit-promo-edit")
  button(:generate_qr,  id: "generate-qr")

  # targets
  divs(:target_ex,   css: ".target-container.existing")
  text_fields(:name, css: ".form-control")
  labels(:choosed, class: "filter-string")
  buttons(:edit,     css: ".btn.btn-default.edit-target")  
  buttons(:delete,   css: ".btn.btn-default.delete-target")
  buttons(:device, class: "btn dropdown-toggle btn-default")
  buttons(:cancel,   css: ".btn.btn-primary.cancel-fields")
  buttons(:save,     css: ".btn.btn-primary.save-fields")

  #new target
  div(:new_target,  id: "new-target-container")
  text_field(:new_name, id: "new-target-value")  
  div(:dev_open,    css: ".dropdown-menu.open")

  # modal window
  div(:alert, class: "modal-content")
  button(:ok, class: "btn btn-primary")
  # button(:alert_no, data-bb-handler: "cancel")
  

  def add_target
    size = buttons(css: ".btn.btn-default").size 
    buttons(css: ".btn.btn-default")[size-1].click
  end

  def alert_no
    buttons(css: ".btn.btn-default").each do |but|
      but.click if (but.visible?)
    end
  end

  def add(tar_name, t_device)   
    binding.pry
    new_target.when_visible
    new_name = tar_name
    self.add_target
    device_elements[device_elements.size-1].click
    self.dev_open.ul.lis.each do |ldevice|
      ldevice.a.click if (ldevice.a.text.include? t_device)
    end
    save_elements[save_elements.size-1].click
  end

  def target_num(tar_name)
    binding.pry
    i = 0
    exists =false
    name_elements.each do |tar|    
      if (tar.visible? && tar.value == tar_name && tar_element.title = 'target')
        exists = true
        break
      end
      i = i + 1
    end
    if (exists) 
      return i 
    end
    return -1
  end

  def delete(tar_name)
    binding.pry
    delete_elements[self.target_num(tar_name)].click
    self.alert_element.when_present
    ok
  end

  def edit(tar_name, t_device)
    binding.pry
    num = self.target_num(tar_name)
    edit_elements[num].click    
    # device_elements[num].click
    # self.dev_open.ul.lis.each do |ldevice|
    #   ldevice.a.click if (ldevice.a.text.include? t_device)
    # end
    save_elements[save_elements.size-1].click
  end

  def size
    self.target_ex_elements.size-1
  end
  
  def find(tar_name)    
    if self.target_num(tar_name) == -1
      return false
    end
    return true
  end
end