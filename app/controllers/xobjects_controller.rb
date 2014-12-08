class XobjectsController < ApplicationController

  def index
    render json: Xobject.generate_object_urls
  end

  def show
    xobj = Xobject.find_by_uid(params[:id])
    if xobj
      @xobject = Xobject.inflate_xobject(xobj)
      render json: @xobject, except: [:id, :created_at, :updated_at], status: :created, location: @xobject
    else
      render json: {verb: "GET", url: "https://cisco-rails-api-2.herokuapp.com/objects/#{params[:id]}", message: "bad URL or uid does not exist"}
    end
  end

  def create
    xobject_string = Xobject.deflate_xobject(params)
    @xobject = Xobject.new({:arb_object => xobject_string})

    if @xobject.save
      inflated_xobject = Xobject.inflate_xobject(@xobject)
      render json: inflated_xobject, except: [:id, :created_at, :updated_at], status: :created, location: @xobject
    else
      render json: {verb: "POST", url: "https://cisco-rails-api-2.herokuapp.com/objects/", message: "Not a JSON object"}
    end
  end

  def update
    xobject_string = Xobject.deflate_xobject(params)
    @xobject = Xobject.find_by_uid(params[:id])

    if @xobject.update({:arb_object => xobject_string})
      inflated_xobject = Xobject.inflate_xobject(@xobject)
      render json: inflated_xobject, except: [:id, :created_at, :updated_at], status: :created, location: @xobject
    else
      render json: {verb: "GET", url: "https://cisco-rails-api-2.herokuapp.com/objects/#{params[:id]}", message: "Not a JSON object"}
    end
  end

  def destroy
    @xobject = Xobject.find_by_uid(params[:id])
    if @xobject == nil
      render json: {verb: "GET", url: "https://cisco-rails-api-2.herokuapp.com/objects/#{params[:id]}", message: "bad URL or uid does not exist"}
    else
      if @xobject.destroy
        # render json: @xobject, except: :id, status: :created, location: @xobject
      else
        render json: {verb: "GET", url: "https://cisco-rails-api-2.herokuapp.com/objects/#{params[:id]}", message: "something went wrong"}
      end
    end
  end


  private

  def allowed_params
    params.require(:xobject).permit(:uid) #this method is not being used
  end

end
