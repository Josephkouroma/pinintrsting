class Pin < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  # attr_accessible :description

  validates :image, presence: true
  validates :description, presence: true

  define_index do
    indexes image.description
    indexes description, sortable: true
    indexes comments.content, as: :comment_content
    indexes [author.first_name, author.last_name], as: :author_name

    has author_id, published_at
  end

#   def self.search(search)
#     if search
#       where(['description LIKE ?', "%#{search}%"])
#     else
#       scoped
#     end
#   end
end

