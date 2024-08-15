# frozen_string_literal: true

module NullAssociation
  ActiveSupport.on_load :active_record do
    include Concern
  end
end
