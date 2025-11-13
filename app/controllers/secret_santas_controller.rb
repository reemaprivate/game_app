require "csv"

class SecretSantasController < ApplicationController

  def index

  end

  def create
    #create employees data
    CsvImportService.import_file params[:employee_csv].path


  end
end
