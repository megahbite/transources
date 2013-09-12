class ResourcesController < ApplicationController
  authorize_actions_for Resource, except: [:show, :search]

  def index

  end

  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource }
    end
  end

  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource }
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def create
    @resource = Resource.new(resource_params)

    @resource.longlat = "POINT(#{@resource.long} #{@resource.lat})" 

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
        format.json { render json: @resource, status: :created, location: @resource }
      else
        format.html { render action: "new" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @resource = Resource.find(params[:id])
    p = resource_params 
    p.merge!({"longlat" => "POINT(#{p[:long]} #{p[:lat]})"}) if p.has_key? :long and p.has_key? :lat
    respond_to do |format|
      if @resource.update_attributes(p)
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end

  def search
    @resources = Resource.all
    if params[:lat] and params[:lng]
      @resources = @resources.where("ST_DWithin(longlat, ST_GeographyFromText('SRID=4326;POINT(#{params[:lng]} #{params[:lat]})'), #{params[:radius].to_i * 1000})")
    end

    render json: @resources.to_json(include: :categories), status: :ok
  end

private

  def resource_params
    params.require(:resource).permit(:title, :description, :address_line_1, :address_line_2, :town, :country, :lat, :long, category_ids: [])
  end


end
