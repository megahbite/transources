class ResourcesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :search, :tag, :search_all]

  def index
    @categories = ActsAsTaggableOn::Tag
    .includes(:taggings)
    .where(taggings: { context: 'categories' })
    .distinct
  end

  def show
    @resource = Resource.find(params[:id]).decorate

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource, include: { scores: { only: :value } } }
    end
  end

  def new
    @resource = Resource.new
    authorize @resource
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource }
    end
  end

  def edit
    @resource = Resource.find(params[:id])
    authorize @resource
  end

  def create
    @resource = Resource.new(resource_params)
    authorize @resource
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
    authorize @resource
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
    authorize @resource
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def search
    #byebug
    @resources = Resource.all
    if params[:lat] and params[:lng]
      @resources = @resources.where("ST_DWithin(longlat, ST_GeographyFromText('SRID=4326;POINT(#{params[:lng]} #{params[:lat]})'), #{params[:radius].to_i * 1000})")
    end

    @resources = @resources.tagged_with(params[:categories], any: true) unless params[:categories].blank?

    render json: @resources.to_json(include: [:categories, :scores]), status: :ok
  end

  def search_all
    @resources = Resource.select([:id, :title, :town])
      .where("title like :q", q: "%#{params[:q]}%")
      .order(:title)
      .page(params[:page]).per(params[:per])
    resources_count = Resource.select([:id, :title, :town])
      .where("title like :q", q: "%#{params[:q]}%").count

    respond_to do |format|
      format.json {
        render json: {
          total: resources_count,
          resources: @resources.map { |e| { id: e.id, text: "#{e.title} (#{e.town})" } }
        }
      }
    end
  end

  def tag
    @resources = Resource.tagged_with(params[:tag_id])
  end

  def manage
    @resources = Resource.all
    authorize @resources

    @resources = @resources.tagged_with(params[:categories], any: true) unless params[:categories].blank?

    @resources = @resources.decorate
    @categories = ActsAsTaggableOn::Tag
    .includes(:taggings)
    .where(taggings: { context: 'categories' })
    .distinct
  end

  def score
    @score = Score.find_or_initialize_by(resource_id: params[:id], user_id: current_user.id)
    @score.value = params[:score]
    @score.save
    render nothing: true
  end

private

  def resource_params
    params.require(:resource).permit(:title, :description, :address_line_1, :address_line_2, :town, :country, :lat, :long, :category_list)
  end


end
