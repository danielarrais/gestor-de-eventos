class ActionsController < ApplicationController
  # GET /actions
  # GET /actions.json
  def index
    @actions = Action.all
  end
end
