require "csv"

class SecretSantasController < ApplicationController
  def index
  end

  def create
    begin
      # check for uploaded files
      if params[:employee_csv].blank? || params[:prev_csv].blank?
        flash[:alert] = "Both the CSV files are required!"
        render :index and return
      end

      CsvImportService.import_file params[:employee_csv].path
      CsvImportService.import_past_data params[:prev_csv].path, Date.today.prev_year.year
      @data = SecretSantaSelectionService.new.roulette
      output_path = Rails.root.join("tmp","secret_santa_result.csv")
      CsvExportService.export_file( @data, output_path)
      flash[:notice] = "Secret Santa result file has been successfully generated!" if File.exist? output_path
      send_file output_path, filename: "secret_santa_result.csv"
    rescue CsvImportService::FileMissingError, CsvImportService::IncorrectHeaderError, CsvImportService::InvalidData => e
      flash[:alert] = "CSV Import Error: #{e.message}"
      render :index
    rescue Exception => e
      flash[:alert] = "Error: #{e.message}"
      render :index
      puts e.backtrace
    end
  end
end
