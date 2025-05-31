# frozen_string_literal: true

module VenuesHelper # rubocop:todo Style/Documentation
  def bookable_venues
    policy_scope(Venue)
  end

  def render_quick_fact_icons(venue) # rubocop:todo Metrics/MethodLength
    content_tag(:ul, class: 'venue-quick-facts list-inline mb-0 d-flex justify-content-center') do
      quick_fact_items(venue).map do |icon, title, value, badge|
        content_tag(:li, class: "#{title.parameterize} list-inline-item position-relative",
                         title: dynamic_title(title, value), data: { bs_toggle: 'tooltip' }) do
          content_tag(:span, class: 'fa-stack') do
            concat(content_tag(:i, '', class: "#{icon} fa-stack-1x"))
            concat(content_tag(:i, '', class: 'fas fa-ban fa-stack-2x text-danger')) unless value
          end +
            (badge ? render_capacity_badge(badge) : '')
        end
      end.join.html_safe
    end
  end

  def venues_map
    @venues_map ||= VenueCollectionMap.find_or_initialize_by(identifier: 'venues')
  end

  private

  def quick_fact_items(venue)
    [
      ['fas fa-users', 'Capacity', venue.capacity.present?, venue.capacity],
      ['fas fa-music', 'Sound Tech', venue.sound_tech],
      ['fas fa-lightbulb', 'Lighting Tech', venue.lighting_tech],
      ['fas fa-wheelchair', 'Accessible', venue.accessible]
    ]
  end

  def dynamic_title(title, value)
    value ? title : "#{title} (#{value.humanize})"
  end

  def render_capacity_badge(capacity)
    content_tag(:span, capacity, class: 'badge bg-primary rounded-pill position-absolute capacity-badge')
  end
end
