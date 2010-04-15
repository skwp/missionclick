module RiCal
  module Properties #:nodoc:
    #- ©2009 Rick DeNatale
    #- All rights reserved. Refer to the file README.txt for the license
    #
    # Properties::Calendar provides property accessing methods for the Calendar class
    # This source file is generated by the  rical:gen_propmodules rake tasks, DO NOT EDIT
    module Calendar

      # return the the CALSCALE property
      # which will be an instances of RiCal::PropertyValueText
      # 
      # [purpose (from RFC 2445)]
      # This property defines the calendar scale used for the calendar information specified in the calendar object.
      # 
      # see RFC 2445 4.7.1 p 73
      def calscale_property
        @calscale_property ||= RiCal::PropertyValue::Text.convert(self, "GREGORIAN")
      end

      # return the value of the CALSCALE property
      # which will be an instance of String
      def calscale
        calscale_property ? calscale_property.ruby_value : nil
      end

      def calscale_property_from_string(line) # :nodoc:
        @calscale_property = RiCal::PropertyValue::Text.new(self, line)
      end


      # return the the METHOD property
      # which will be an instances of RiCal::PropertyValueText
      # 
      # [purpose (from RFC 2445)]
      # This property defines the iCalendar object method associated with the calendar object
      # 
      # see RFC 2445 4.7.2 p 74-75
      def method_property
        @method_property
      end

      # set the METHOD property
      # property value should be an instance of RiCal::PropertyValueText
      def method_property=(property_value)
        @method_property = property_value
      end

      # set the value of the METHOD property
      def icalendar_method=(ruby_value)
        self.method_property= RiCal::PropertyValue::Text.convert(self, ruby_value)
      end

      # return the value of the METHOD property
      # which will be an instance of String
      def icalendar_method
        method_property ? method_property.ruby_value : nil
      end

      def method_property_from_string(line) # :nodoc:
        @method_property = RiCal::PropertyValue::Text.new(self, line)
      end


      # return the the PRODID property
      # which will be an instances of RiCal::PropertyValueText
      # 
      # [purpose (from RFC 2445)]
      # This property specifies the identifier for the product that created the iCalendar object.
      # 
      # see RFC 2445 4.7.3 pp 75-76
      def prodid_property
        @prodid_property ||= RiCal::PropertyValue::Text.convert(self, "-//com.denhaven2/NONSGML ri_cal gem//EN")
      end

      # set the PRODID property
      # property value should be an instance of RiCal::PropertyValueText
      def prodid_property=(property_value)
        @prodid_property = property_value
      end

      # set the value of the PRODID property
      def prodid=(ruby_value)
        self.prodid_property= RiCal::PropertyValue::Text.convert(self, ruby_value)
      end

      # return the value of the PRODID property
      # which will be an instance of String
      def prodid
        prodid_property ? prodid_property.ruby_value : nil
      end

      def prodid_property_from_string(line) # :nodoc:
        @prodid_property = RiCal::PropertyValue::Text.new(self, line)
      end


      # return the the VERSION property
      # which will be an instances of RiCal::PropertyValueText
      # 
      # [purpose (from RFC 2445)]
      # This property specifies the identifier corresponding to thehighest version number or the minimum and maximum range of the iCalendar specification that is required in order to interpret the iCalendar object.
      # 
      # see RFC 2445 4.7.4 pp 76-77
      def version_property
        @version_property ||= RiCal::PropertyValue::Text.convert(self, "2.0")
      end

      # return the value of the VERSION property
      # which will be an instance of String
      def version
        version_property ? version_property.ruby_value : nil
      end

      def version_property_from_string(line) # :nodoc:
        @version_property = RiCal::PropertyValue::Text.new(self, line)
      end


      def export_properties_to(export_stream) #:nodoc:
        export_prop_to(export_stream, "PRODID", @prodid_property)
        export_prop_to(export_stream, "CALSCALE", @calscale_property)
        export_prop_to(export_stream, "VERSION", @version_property)
        export_prop_to(export_stream, "METHOD", @method_property)
      end

      def ==(o) #:nodoc:
        if o.class == self.class
        (prodid_property == o.prodid_property) &&
        (calscale_property == o.calscale_property) &&
        (version_property == o.version_property) &&
        (method_property == o.method_property)
        else
           super
        end
      end

      def initialize_copy(o) #:nodoc:
        super
        prodid_property = prodid_property && prodid_property.dup
        calscale_property = calscale_property && calscale_property.dup
        version_property = version_property && version_property.dup
        method_property = method_property && method_property.dup
      end

      def add_date_times_to(required_timezones) #:nodoc:
      end

      module ClassMethods #:nodoc:
        def property_parser #:nodoc:
          {"METHOD"=>:method_property_from_string, "VERSION"=>:version_property_from_string, "PRODID"=>:prodid_property_from_string, "CALSCALE"=>:calscale_property_from_string}
        end
      end

      def self.included(mod) #:nodoc:
        mod.extend ClassMethods
      end

      def mutual_exclusion_violation #:nodoc:
        false
      end
    end
  end
end
