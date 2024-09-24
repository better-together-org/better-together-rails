class ResourcesController < BetterTogether::FriendlyResourceController
  before_action :set_resource, only: %i[ show edit update destroy download ]
  before_action :authorize_resource, only: %i[show edit update destroy download]
  after_action :verify_authorized, except: :index

  before_action only: %i[new update], if: -> { Rails.env.development? } do
    # Make sure that all BLock subclasses are loaded in dev to generate new block buttons
    resource_class.load_all_subclasses
  end

  # GET /resources
  def index
    authorize resource_class
    @resources = policy_scope(resource_collection)
  end

  # GET /resources/1
  def show
    # Dispatch the background job for tracking the page view
    BetterTogether::Metrics::TrackPageViewJob.perform_later(@resource, I18n.locale.to_s)
  end

  # GET /resources/new
  def new
    @resource = resource_class.new
    authorize_resource
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  def create
    @resource = resource_class.new(resource_params)
    authorize_resource

    if @resource.save
      redirect_to resources_path, notice: "Resource was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /resources/1
  def update
    if @resource.update(resource_params)
      redirect_to edit_resource_path(@resource), notice: "Resource was successfully updated.", status: :see_other
    else
      raise
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /resources/1
  def destroy
    @resource.destroy!
    redirect_to resources_url, notice: "Resource was successfully destroyed.", status: :see_other
  end

  def download
    if @resource.is_a?(Resource::Document) && @resource.file.attached?
      # Trigger the background job to log the download
      BetterTogether::Metrics::TrackDownloadJob.perform_later(
        @resource,                                     # Polymorphic resource model
        @resource.file.filename.to_s,                  # Filename
        @resource.file.content_type,                   # File type (content type)
        @resource.file.byte_size,                      # File size
        I18n.locale.to_s                               # Locale
      )

      send_data @resource.file.download,
                filename: @resource.file.filename.to_s,
                type: @resource.file.content_type,
                disposition: 'attachment'
    else
      redirect_to @resource, alert: t('resources.download_failed')
    end
  end

  protected

  # Adds a policy check for the resource
  def authorize_resource
    authorize @resource
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = set_resource_instance
  end

  # Only allow a list of trusted parameters through.
  def resource_params
    root_param = if params[:resource_document]
      :resource_document
    elsif params[:resource_link]
      :resource_link
    else
      :resource
    end

    params.require(root_param).permit(
      :type, :published_at, :author, :privacy, :language,
      *resource_class.localized_attribute_list,
      *@resource.class.extra_permitted_attributes
    )
  end

  def resource_class
    Resource
  end
end
