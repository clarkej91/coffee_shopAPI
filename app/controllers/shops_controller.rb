class ShopsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Shop.all
  end

  def show
    render json: Shop.find(params["id"])
  end

  def create
    render json: Shop.create(params["shop"])
  end

  def delete
    render json: Shop.delete(params["id"])
  end

  def update
    render json: Shop.update(params["id"], params["shop"])
  end

end
