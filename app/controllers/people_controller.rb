class PeopleController < ApplicationController
  def name
    @person = Person.select(:id, :name, :surname).find_by_cpf(params[:cpf])

    respond_to do |format|
      format.json { render json: @person }
    end
  end

  def autocomplete_by_cpf
    @person = Person.select(:id, :name, :cpf, :surname)
                .limit(10)
                .where(cpf: params[:value])
                .where.not(id: params[:selecteds])
                .map { |v| { label: v.full_name, value: v.id, id: v.id } }

    respond_to do |format|
      format.json { render json: @person }
    end
  end
end
