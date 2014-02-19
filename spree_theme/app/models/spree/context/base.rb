module Spree
  module Context
    module Base
      # use string instead of symbol, parameter from client is string
      # first one is default 
      ContextEnum=Struct.new(:home, :list,:detail,:cart,:account,:checkout, :thanks,:signup,:login,:password, :either)[ :home, :list,:detail,:cart,:account,:checkout, :thanks,:signup,:login, :password, :""]
      
      #context may be array, datasource is nil for array.
      ContextDataSourceMap = { ContextEnum.list=>[:gpvs],ContextEnum.detail=>[:this_product]}
      DataSourceChainMap = {:gpvs=>[:gpv_product,:gpv_group, :gpv_either],
        :gpv_product=>[:product_images,:product_options], 
        :gpv_group=>[:group_products,:group_images],    
        :group_products=>[:product_images,:product_options],
        :this_product=>[]
        #keys should inclde all data_sources, test required.
        }
      DataSourceEmpty = :""
      
      def context_either?
        raise "unimplement"
      end
    end
  end
end
