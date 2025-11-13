require 'csv'
class CsvImportService

  def self.import_file(file_path)
    CSV.foreach(file_path,:headers => true) do |row|
      Employee.find_or_create_by(:name => row["Employee_Name"], :email => row["Employee_EmailID"])
    end
  end

  def self.import_past_data(file_path, year)
    CSV.foreach(file_path,:headers => true) do |row|
      SecretSantaAssociation.find_or_create_by(:giver => Employee.find_by_email(row["Employee_EmailID"]), :recipient => Employee.find_by_email(row["Secret_Child_EmailID"]),:year => year)
    end
  end
end