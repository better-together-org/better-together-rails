
module JourneyMapHelper
  def distribute_topic_indices(topics, max_slots = 14)
    total_topics = topics.length
    return (0...max_slots).to_a if total_topics == max_slots

    spacing = (max_slots - 1).to_f / (total_topics - 1)
    (0...total_topics).map { |index| (index * spacing).round }
  end
end