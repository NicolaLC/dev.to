module Search
  module QueryBuilders
    class User < QueryBase
      QUERY_KEYS = %i[
        search_fields
      ].freeze

      # Search keys from our controllers may not match what we have stored in Elasticsearch so we map them here,
      # this allows us to change our Elasticsearch docs without worrying about the frontend
      EXCLUDED_TERM_KEYS = {
        exclude_roles: "roles"
      }.freeze

      DEFAULT_PARAMS = {
        sort_by: "hotness_score",
        sort_direction: "desc",
        size: 0
      }.freeze

      def initialize(params)
        @params = params.deep_symbolize_keys

        # default to excluding users who are banned
        @params[:exclude_roles] = ["banned"]

        build_body
      end

      private

      def build_queries
        @body[:query] = { bool: {} }
        @body[:query][:bool][:must] = query_conditions if query_keys_present?
        @body[:query][:bool][:must_not] = excluded_term_keys if excluded_term_keys_present?
      end

      def excluded_term_keys_present?
        self.class::EXCLUDED_TERM_KEYS.detect { |key, _| @params[key].present? }
      end

      def excluded_term_keys
        EXCLUDED_TERM_KEYS.map do |term_key, search_key|
          next unless @params.key? term_key

          { terms: { search_key => Array.wrap(@params[term_key]) } }
        end.compact
      end
    end
  end
end
