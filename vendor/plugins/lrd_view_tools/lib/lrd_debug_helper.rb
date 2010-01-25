module LRD
  module DebugHelper
    require 'pp'
    require 'stringio'
  
    def lrd_debug(object)
     "<pre>#{h(pp_s(object))}</pre>"
    end     
  
    def pp_s(*objs)
        s = StringIO.new
        objs.each {|obj|
          PP.pp(obj, s)
        }
        s.rewind
        s.read
    end  
  end
end