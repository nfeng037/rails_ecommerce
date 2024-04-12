class StaticPage < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "id_value", "identifier", "title", "updated_at"]
  end

  validates :title, :content, presence: true

end
