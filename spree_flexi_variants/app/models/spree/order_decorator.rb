module Spree
  Order.class_eval do

    def find_line_item_by_variant(variant, ad_hoc_option_value_ids=[], product_customizations=[])
      line_items.detect do |li|
        li.variant_id == variant.id &&
          matching_configurations(li.ad_hoc_option_values,ad_hoc_option_value_ids) &&
          matching_customizations(li.product_customizations,product_customizations)
      end
    end

    # copy original method merge! here, only change the way get current_line_item
    def merge!(order, user = nil)
      order.line_items.each do |line_item|
        next unless line_item.currency == currency
        # change the way get current_line_item
        current_line_item = find_line_item_by_variant( line_item.variant, line_item.ad_hoc_option_value_ids, line_item.product_customizations )
        if current_line_item
          current_line_item.quantity += line_item.quantity
          current_line_item.save
        else
          line_item.order_id = self.id
          line_item.save
        end
      end
      
      self.associate_user!(user) if !self.user && !user.blank?

      # So that the destroy doesn't take out line items which may have been re-assigned
      order.line_items.reload
      order.destroy
    end

    private

    # produces a list of [customizable_product_option.id,value] pairs for subsequent comparison
    def customization_pairs(product_customizations)
      pairs= product_customizations.map(&:customized_product_options).flatten.map do |m|
        [m.customizable_product_option.id, m.value.present? ? m.value : m.customization_image.to_s ]
      end

      Set.new pairs
    end

    def matching_configurations(existing_povs,new_povs)
      # if there aren't any povs, there's a 'match'
      return true if existing_povs.empty? && new_povs.empty?

      existing_povs.map(&:id).sort == new_povs.map(&:to_i).sort
    end

    def matching_customizations(existing_customizations,new_customizations)

      # if there aren't any customizations, there's a 'match'
      return true if existing_customizations.empty? && new_customizations.empty?

      # exact match of all customization types?
      return false unless existing_customizations.map(&:product_customization_type_id).sort == new_customizations.map(&:product_customization_type_id).sort

      # get a list of [customizable_product_option.id,value] pairs
      existing_vals = customization_pairs existing_customizations
      new_vals      = customization_pairs new_customizations

      # do a set-compare here
      existing_vals == new_vals
    end
  end
end