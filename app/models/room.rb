class Room < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :reservations, dependent: :destroy

    validates :room_name, presence: true
    validates :introduction, presence: true, length: {maximum: 100}
    validates :price, numericality: true
    validates :address, presence: true
    validates :image, presence: true

    def self.search(search)
        where(["room_name like? or address like? or introduction like?", "%#{search}%", "%#{search}%", "%#{search}%"])
    end

end
