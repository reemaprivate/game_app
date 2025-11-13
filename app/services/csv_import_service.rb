require 'csv'
class CsvImportService

  def self.import_file(file_path)
    CSV.foreach(file_path,:headers => true) do |row|
      Employee.find_or_create_by(:name => row["Employee_Name"], :email => row["Employee_EmailID"])
    end
  end
end