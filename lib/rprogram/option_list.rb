require 'rprogram/extensions/hash'

module RProgram
  class OptionList < Hash

    #
    # Creates a new OptionList object with the given _options_.
    #
    def initialize(options={})
      super(options)
    end

    #
    # Returns the arguments for the option-list.
    #
    def arguments
      self.map do |key,sub_value|
        if sub_value == true
          key.to_s
        elsif sub_value
          "#{key}=#{sub_value}"
        end
      end
    end

    protected

    #
    # Provides transparent access to the options within the option list.
    #
    #   opt_list = OptionList.new(:name => 'test')
    #   opt_list.name
    #   # => "test"
    #
    def method_missing(sym,*args,&block)
      name = sym.to_s

      unless block
        if (name =~ /=$/ && args.length==1)
          return self[name.chop.to_sym] = args[0]
        elsif args.length==0
          return self[sym]
        end
      end

      super(sym,*args,&block)
    end

  end
end
