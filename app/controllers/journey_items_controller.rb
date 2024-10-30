# frozen_string_literal: true

class JourneyItemsController < ApplicationController
  before_action :set_journey

  def index
    @journey_items = @journey.journey_items
  end

  def create
    @journey_item = @journey.journey_items.new(journey_item_params)

    if @journey_item.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream_replace(@journey_item.journeyable) }
        format.html do
          redirect_back fallback_location: helpers.base_url, notice: 'Journey item was successfully created.'
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream_replace(@journey_item.journeyable, partial: 'error_partial')
        end
        format.html { redirect_back fallback_location: helpers.base_url, alert: 'Error creating journey item.' }
      end
    end
  end

  def destroy
    @journey_item = JourneyItem.find(params[:id])

    if @journey_item.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream_replace(@journey_item.journeyable),
            turbo_stream.remove(helpers.dom_id(@journey_item, @journey_item.journeyable))
          ]
        end
        format.html do
          redirect_back fallback_location: helpers.base_url, notice: 'Journey item was successfully removed.'
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream_replace(@journey_item.journeyable, partial: 'error_partial')
        end
        format.html { redirect_back fallback_location: helpers.base_url, alert: 'Error removing journey item.' }
      end
    end
  end

  protected

  def set_journey
    @journey = helpers.current_person&.journey
  end

  def journey_item_params
    params.require(:journey_item).permit(:journeyable_id, :journeyable_type, :journey_stage_id)
  end

  private

  def turbo_stream_replace(journeyable, partial: 'journey_items/journey_item_toggle')
    turbo_stream.replace helpers.dom_id(journeyable, 'journey_item_toggle'), partial:,
                                                                             locals: { journeyable: }
  end
end
