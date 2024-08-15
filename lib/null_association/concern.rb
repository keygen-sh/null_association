# frozen_string_literal: true

require_relative 'decorator'

module NullAssociation
  module Concern
    extend ActiveSupport::Concern

    class_methods do
      def belongs_to(name, scope = nil, null_object: nil, **options, &extension)
        return super(name, scope, **options, &extension) if null_object.nil?

        unless options[:optional]
          raise ArgumentError, 'must be :optional to use :null_object'
        end

        # generate getter
        super(name, scope, **options, &extension)

        # decorate getter
        include Decorator[name, null_object:]
      end

      def has_one(name, scope = nil, null_object: nil, **options, &extension)
        return super(name, scope, **options, &extension) if null_object.nil?

        # generate getter
        super(name, scope, **options, &extension)

        # decorate getter
        include Decorator[name, null_object:]
      end
    end
  end
end

