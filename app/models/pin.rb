class Pin < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  # attr_accessible :description

  validates :image, presence: true
  validates :description, presence: true

  include PgSearch
  pg_search_scope :search, :against => [:description]




  def self.search(search)
    if search.present?
      # where(['description ilike ?', "%#{search}%"])
      # where(['description ilike :q', q: "%#{search}%"])
      where("to_tsvector('english',description) @@ plainto_tsquery(:q)", q: search)
    else
      all
    end
  end
end

