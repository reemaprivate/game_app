class SecretSantaSelectionService

  def initialize
    @employees = Employee.all
  end

  def roulette
    #initital logic to create test data
    first = @employees.first
    last = @employees.last
    data = []
    @employees.each_with_index  do |emp,index|
      @employees[index+1]
      if emp == last
        data << {:giver => emp, :recipient => first}
      else
        data << {:giver => emp, :recipient => @employees[index+1]}
      end
    end
    data
  end

end

