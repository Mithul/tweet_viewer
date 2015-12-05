class Media < ActiveRecord::Base
 	has_attached_file :media_file, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :media_file, content_type: /\Aimage\/.*\Z/

 	def picture_from_url(url)
    		self.media_file = open(url)
  	end
end
