require 'csv'
class CsvImportService
  class FileMissingError < StandardError; end
  class IncorrectHeaderError < StandardError; end
  class InvalidData < StandardError; end

  def self.import_file(file_path)
    raise FileMissingError, "Employee CSV file not found at #{file_path}" unless File.exist?(file_path)

    csv_data = CSV.read(file_path , headers: true)
    unless csv_data.headers.include?("Employee_Name") && csv_data.headers.include?("Employee_EmailID")
      raise IncorrectHeaderError, "CSV headers must include Employee_Name and Employee_EmailID !"
    end


    CSV.foreach(file_path,:headers => true) do |row|
      Employee.find_or_create_by(:name => row["Employee_Name"], :email => row["Employee_EmailID"])
    end
  end

  def self.import_past_data(file_path, year)
    raise FileMissingError, "Employee CSV file not found at #{file_path}" unless File.exist?(file_path)

    csv_data = CSV.read(file_path , headers: true)
    unless csv_data.headers.include?("Employee_Name") && csv_data.headers.include?("Employee_EmailID") && csv_data.headers.include?("Secret_Child_Name") && csv_data.headers.include?("Secret_Child_EmailID")
      raise IncorrectHeaderError, "CSV headers for previous year's file must include Employee_Name, Employee_EmailID,Secret_Child_Name, Secret_Child_EmailID !"
    end

    CSV.foreach(file_path,:headers => true) do |row|
      assoc = SecretSantaAssociation.find_or_create_by(:giver => Employee.find_by_email(row["Employee_EmailID"]), :recipient => Employee.find_by_email(row["Secret_Child_EmailID"]),:year => year)
      if assoc.errors.any?
        SecretSantaAssociation.past_year.delete_all
        raise InvalidData, "Please pass correct previous year's data !" and return
      end
    end
  end
end