class SecretSantaAssociation < ApplicationRecord

  belongs_to :giver , :class_name => "Employee"
  belongs_to :recipient, :class_name => "Employee"

end
