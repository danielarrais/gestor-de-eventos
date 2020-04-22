class PeopleController < ApplicationController
  def name
    @person = Person.select(:id, :name, :surname).find_by_cpf(params[:cpf])

    respond_to do |format|
      format.json { render json: @person }
    end
  end
end
