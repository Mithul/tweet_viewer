class AddAttachmentMediaFileToMedia < ActiveRecord::Migration
  def self.up
    change_table :media do |t|
      t.attachment :media_file
    end
  end

  def self.down
    remove_attachment :media, :media_file
  end
end
