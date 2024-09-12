# frozen_string_literal: true


class PartnerPolicy < BetterTogether::CommunityPolicy # rubocop:todo Style/Documentation
  

  class Scope < BetterTogether::CommunityPolicy::Scope # rubocop:todo Style/Documentation
    def resolve
      scope.order(:host, :identifier).where(permitted_query)
    end

    protected

    # rubocop:todo Metrics/MethodLength
    def permitted_query # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
      communities_table = Partner.arel_table
      person_community_memberships_table = ::BetterTogether::PersonCommunityMembership.arel_table

      # Only list communities that are public and where the current person is a member or a creator
      communities_table[:privacy].eq('public').or(
        communities_table[:id].in(
          person_community_memberships_table
            .where(person_community_memberships_table[:member_id]
            .eq(agent.id))
            .project(:joinable_id)
        )
      ).or(
        communities_table[:creator_id].eq(agent.id)
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
