class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins

  validates :name, presence: true

  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      scoped
    end
  end
end

