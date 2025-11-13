class Employee < ApplicationRecord

  has_many :giver_associations , :class_name => "SecretSantaAssociation",:foreign_key => :giver_id
  has_many :recipient_associations , :class_name => "SecretSantaAssociation",:foreign_key => :recipient_id

  validates :name, presence: true
end
