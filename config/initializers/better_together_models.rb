
Rails.application.config.to_prepare do
  require_dependency 'better_together/content/block'
  require_dependency 'better_together/content/template'
  require_dependency 'better_together/navigation_item'
  require_dependency 'better_together/page'

  BetterTogether::Content::Block.include(NewToNlContentBlock)
  BetterTogether::Content::Template.include(NewToNlContentTemplate)
  BetterTogether::NavigationItem.include(NewToNlNavigationItem)
  BetterTogether::Page.include(NewToNlJourneyStage)
  BetterTogether::Page.include(NewToNlTopic)
end
