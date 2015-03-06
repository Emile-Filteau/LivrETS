Paperclip::Attachment.default_options[:storage]         = :s3
Paperclip::Attachment.default_options[:s3_credentials]  = "#{Rails.root}/config/s3.yml"
Paperclip::Attachment.default_options[:s3_protocol]     = :https
Paperclip::Attachment.default_options[:url]             = '/:class/:attachment/:id_partition/:basename-:style.:extension'
Paperclip::Attachment.default_options[:path]            = ':class/:attachment/:id_partition/:basename-:style.:extension'
Paperclip::Attachment.default_options[:processors]      = [:thumbnail]
Paperclip::Attachment.default_options[:styles]          = {}
Paperclip::Attachment.default_options[:convert_options] = {}
Paperclip::Attachment.default_options[:default_url]     = '/images/:class/:attachment/default_:style.png'
Paperclip::Attachment.default_options[:default_style]   = :original
Paperclip::Attachment.default_options[:escape_url]      = false