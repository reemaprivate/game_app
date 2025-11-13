require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'creates a Employee class' do
    emp = Employee.new
    expect(emp).to be_kind_of(Employee)
  end

end
