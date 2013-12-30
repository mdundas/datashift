class ModelMapper
  
  # Helper to deal with string versions of modules/namespaced classes
  # Find and return the base class from a string.
  # 
  # e.g "Spree::Property" returns the Spree::Property class
  # Raises exception if no such class found
  def self.const_get_from_string(str)
    str.to_s.split('::').inject(Object) do |mod, class_name| 
      mod.const_get(class_name) 
    end 
  end 


  # Similar to const_get_from_string except this version
  # returns nil if no such class found
  # Support modules e.g "Spree::Property"
  # 
  def self.class_from_string( str )
      begin
        ModelMapper::const_get_from_string(str.to_s)  #Kernel.const_get(model)
      rescue NameError => e
       return nil
      end
  end
  
end