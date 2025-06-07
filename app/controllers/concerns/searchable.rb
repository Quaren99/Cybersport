# app/models/concerns/searchable.rb
require "active_support/concern"

module Searchable
  extend ActiveSupport::Concern

  # This block adds the .search method to any model that includes this concern.
  class_methods do
    # @param params [Hash] The parameters hash, usually from the controller.
    # @param exact_filters [Array<Symbol>] A list of keys to use for exact matching.
    # @param text_fields [Array<Symbol>] A list of fields for case-insensitive text search.
    # @return [ActiveRecord::Relation] A chainable query result.
    def search(params: {}, exact_filters: [], text_fields: [])
      # Start with a chainable relation for the current model (e.g., Team.all)
      results = all

      # 1. Apply Exact Match Filters
      # ---------------------------
      # Extracts only the keys specified in `exact_filters` from the params.
      # .compact removes any pairs where the value is nil.
      exact_conditions = params.slice(*exact_filters).compact
      results = results.where(exact_conditions) if exact_conditions.present?

      # 2. Apply Text Search Filters
      # ----------------------------
      # The search term is expected under the :query key in params.
      query_term = params[:query]
      results = text_filter(results, query_term, text_fields) if query_term.present? && text_fields.any?

      # 3. Return the final, chainable ActiveRecord::Relation
      # ----------------------------------------------------
      results
    end

    private

    def text_filter(results, query_term, text_fields)
      # Prepare the search term for a LIKE query
      search_value = "%#{query_term.downcase}%"

      # Build the SQL string fragment dynamically.
      # e.g., "LOWER(name) LIKE ? OR LOWER(description) LIKE ?"
      # `quote_column_name` is a safe way to wrap column names in quotes (""),
      # preventing SQL injection if the field names were ever dynamic.
      sql_fragments = text_fields.map do |field|
        "LOWER(#{connection.quote_column_name(field)}) LIKE ?"
      end.join(" OR ")

      # Create the arguments array for the `where` clause.
      # It looks like: ["LOWER(name) LIKE ? OR ...", "%search%", "%search%"]
      # We need one `search_value` for each `?` placeholder.
      sql_arguments = [sql_fragments] + ([search_value] * text_fields.length)

      # Chain the text search `where` clause to our results
      results.where(*sql_arguments)
    end
  end
end
