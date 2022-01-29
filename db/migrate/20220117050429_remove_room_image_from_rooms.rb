class RemoveRoomImageFromRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :room_image, :string
  end
end
