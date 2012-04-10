module ActiveRecord
  module Acts
    module Extensible
      
      def self.included(base)
        base.extend(ClassMethods)  
      end
      
      module ClassMethods
        def acts_as_extensible(*args)
          include ActiveRecord::Acts::Extensible::InstanceMethods        
          for column in args
            class_eval <<-METHOD
            def #{column}=(msg)
              set_element(:#{column}, msg)
            end
            
            def #{column}
              element(:#{column})
            end 
            METHOD
          end
        end

      end
      
      module InstanceMethods
        require "rexml/document"
        include REXML
        
        def elements(tag)
          doc = Document.new(self.xml)
          doc.elements("root/#{tag}")
        end
        
        def element(tag)
          return '' if self.xml.nil?
          matches = self.xml.match(/<#{tag}>(.*?)<\/#{tag}>/m)
          return '' if matches.nil?
          
          return CGI::unescapeHTML(matches[1] || '')
        end
        
        def set_element(tag, value)
          doc = Document.new(self.xml)
          el = doc.elements["root/#{tag.to_s}"]
          if el.nil?
            if doc.elements["root"].nil?
              doc.add_element "root"
            end
            el1 = Element.new tag.to_s 
            el1.text = value
            
            doc.elements["root"].elements << el1
          else
            doc.elements["root/#{tag.to_s}"].text = value
          end
          self.xml = doc.to_s
        end
        
        def xml=(xml)
          self[:xml] = xml
        end
        
        def xml
          return self[:xml]
        end
      end
    end
  end
end
ActiveRecord::Base.send(:include, ActiveRecord::Acts::Extensible)
