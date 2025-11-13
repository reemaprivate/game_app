require 'rails_helper'

RSpec.describe SecretSantaAssociation, type: :model do
  it 'creates a SecretSantaAssociation class' do
    assoc = SecretSantaAssociation.new
    expect(assoc).to be_kind_of(SecretSantaAssociation)
  end
end
