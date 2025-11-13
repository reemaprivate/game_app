class SecretSantaAssociation < ApplicationRecord

  belongs_to :giver , :class_name => "Employee"
  belongs_to :recipient, :class_name => "Employee"

  validates :giver_id,:recipient_id,:year , :presence => true
  validates :giver_id, :uniqueness => {:scope =>  :year ,message: "is already assigned for a recipient this year!" }
  validates :recipient_id, :uniqueness => {:scope => :year ,message: "is already assigned to a giver this year!" }


end
