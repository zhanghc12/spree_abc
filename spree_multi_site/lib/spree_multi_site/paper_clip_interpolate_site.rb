unless Paperclip::Interpolations.all.include? :site
  Paperclip.interpolates :site do |attachment, style_name|
    Spree::Site.current.id
  end
end