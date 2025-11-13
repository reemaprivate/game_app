class SecretSantaSelectionService

  def initialize
    @employees = Employee.all
  end

  def assign_secret_santa(givers, available_recipients, past_year_pairs = {})
    return [] if givers.empty?

    giver = givers.first

    available_recipients.each do |child|
      next if child == giver
      next if past_year_pairs[giver.id]&.include?(child.id)

      remaining_givers = givers[1..-1]
      remaining_children = available_recipients - [child]

      result = assign_secret_santa(remaining_givers, remaining_children, past_year_pairs)
      if result
        return [{ giver: giver, recipient: child }] + result
      end
    end
    return nil
  end

  def roulette
    employees = Employee.all.to_a
    data = []
    past_year_pairs = {}
    @employees.each do |emp|
      past_year_pairs[emp.id] = emp.giver_associations.past_year.pluck(:recipient_id)
    end

    assignments = assign_secret_santa(employees, employees, past_year_pairs)

    if assignments
      assignments.each do |pair|
        SecretSantaAssociation.create!(
          giver: pair[:giver],
          recipient: pair[:recipient],
          year: Date.today.year
        )
        data << { :giver => pair[:giver], :recipient => pair[:recipient] }
      end
    else
      puts "-invalid data -"
    end

    data
  end

end

