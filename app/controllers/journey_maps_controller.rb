
class JourneyMapsController < ApplicationController
  before_action :set_journey_map_and_stage
  before_action :set_topic

  def show
    categories = [@journey_stage&.id, @topic&.id]

    @pages = BetterTogether::Page.with_journey_stage(@journey_stage&.id)
                                 .with_topic(@topic&.id)

    @resources = Resource.with_journey_stage(@journey_stage&.id)
                         .with_topic(@topic&.id)

    respond_to do |format|
      format.html
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.replace(
            helpers.dom_id(@journey_map, :pages),
            partial: 'journey_maps/pages', locals: {
              pages: @pages, journey_map: @journey_map, topic: @topic
            }
          ),
          turbo_stream.replace(
            helpers.dom_id(@journey_map, :resources),
            partial: 'journey_maps/resources', locals: {
              resources: @resources, journey_map: @journey_map, topic: @topic
            }
          )
        ]
      }
    end
  end

  protected

  def set_journey_map_and_stage
    @journey_map = JourneyMap.find params[:journey_map_id]
    @journey_stage = @journey_map.journey_stage
  end

  def set_topic
    @topic = Topic.find_by(identifier: params[:topic_identifier])
  end
end
