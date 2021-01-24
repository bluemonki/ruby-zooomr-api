#This work is licenced under http://creativecommons.org/licenses/GPL/2.0/

require 'rubygems'
require 'json'

# Class to handle responses from Zooomr - allows testing for false so that it can look like a boolean
class ZooomrResponse
  
  attr_accessor :error_message, :error_code, :json_response
  
  # Constructor
  # Required Parameters:
  # * a_response => a response from Zooomr
  #
  def initialize(a_response)
    
    @return_code    = false
    @error_message  = "ok"
    @error_code     = "0"
    
    if (nil == a_response)
      
      @error_message  = "No response from Zooomr!"
      @json_response  = JSON.parse("{\"stat\": \"fail\", \"code\": \"98\", \"message\": \"No response from Zooomr\" }")
      
    else
      
      @json_response  = a_response
      
      if ('ok'.eql?(a_response['stat']))
        
        @return_code    = true
      
      else

        @error_code     = a_response['code']
        @error_message  = a_response['message']
        
      end
    end
  end
  
  def eql (a_value)
    return is_equal(a_value)
  end
  
  def eql? (a_value)
    return is_equal(a_value)
  end
  
  def equal (a_value)
    return is_equal(a_value)
  end
  
  def == (a_value)
    return is_equal(a_value)
  end
   
  def is_equal (a_value)
    puts "in eql"
    case a_value
      when ZooomrResponse
        raise ArgumentError, "Not a boolean", caller
    else
      # assume boolean
      return a_value.eql?(@return_code)
    end
  end
end
