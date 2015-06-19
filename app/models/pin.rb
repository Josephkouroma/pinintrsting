class Pin < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  # attr no longer used in rails 4 (now protected by )
  # attr_accessible :description

  # accepts_nested_attributes_for :pin_params

  validates :image, presence: true
  validates :description, presence: true

  include PgSearch
  # multisearchable against: [:description]
  pg_search_scope :pins, :against => [:description],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {user: :name }




  def self.search(search)
    if search.present?
      # where(['description ilike ?', "%#{search}%"])
      # where(['description ilike :q', q: "%#{search}%"])
      # where("description @@ :q", :q => search)
      # where("to_tsvector('english',description) @@ plainto_tsquery('english',:q)", q: search)
      where("to_tsvector('english',description) @@ plainto_tsquery('english',:q)", q: "%#{search}%")
      # where("to_tsvector('english',:q) @@ plainto_tsquery('english',:q)", q: search)
    else
      all
    end
  end
end


