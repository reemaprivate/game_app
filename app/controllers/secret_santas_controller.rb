require "csv"

class SecretSantasController < ApplicationController

  def index

  end

  def create
    begin
      #create employees data
      CsvImportService.import_file params[:employee_csv].path
      @data = SecretSantaSelectionService.new().roulette
      output_path = Rails.root.join('tmp', 'secret_santa_result.csv')
      CsvExportService.export_file(@data,output_path)
      send_file output_path, filename: "secret_santa_result.csv"
    rescue Exception => e
      puts "---there was error in create!"
      puts e.full_message
      puts e.backtrace
    end
  end
end
