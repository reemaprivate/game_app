require 'csv'
class CsvExportService

  def self.export_file data , output_path
    begin
    puts data

    CSV.open(output_path, "w") do |csv|
      csv << ['Employee_Name', 'Employee_EmailID', 'Secret_Child_Name', 'Secret_Child_EmailID']
      data.each do |emp|
        csv << [
          emp[:giver].name,
          emp[:giver].email,
          emp[:recipient].name,
          emp[:recipient].email
        ]
      end
    end
    rescue Exception => e
      puts "--im in exception"
      puts e.full_message
      puts e.backtrace
      CSV.open(output_path, "w") do |csv|
        csv << ['Employee_Name', 'Employee_EmailID', 'Secret_Child_Name', 'Secret_Child_EmailID']
      end
    end

  end
end
