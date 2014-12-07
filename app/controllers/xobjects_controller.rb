class XobjectsController < ApplicationController

  def index
    render json: Xobject.all
  end

  def show
    @xobject = Xobject.find_by_uid(params[:id])
    if @xobject
      render json: @xobject, except: :id, status: :created, location: @xobject
    else
      render json: {verb: "GET", url: "https://cisco-rails-api.herokuapp.com/objects/#{params[:id]}", message: "uid does not exist"}
    end
  end

  def create

    json_string = params[:xobject].to_json # not parsed correctly
    json_object = {:arb_object => json_string}
    @xobject = Xobject.new(json_object)

    if @xobject.save
      render json: @xobject, except: :id, status: :created, location: @xobject
    else
      render json: {verb: "POST", url: "https://cisco-rails-api.herokuapp.com/objects/", message: "Not a JSON object"}
    end
  end

  def update
    @xobject = Xobject.find_by_uid(params[:id])

    if @xobject.update(allowed_params)
      render json: @xobject, except: :id, status: :created, location: @xobject
    else
      render json: @xobject.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @xobject = Xobject.find_by_uid(params[:id])

    if @xobject.destroy
      render json: @xobject, except: :id, status: :created, location: @xobject
    else
      render json: @xobject.errors, status: :unprocessable_entity
    end
  end


  private

  def allowed_params
    # I wonder what happens with timestamp fields?
    params.require(:xobject).permit(:uid)
  end

end
