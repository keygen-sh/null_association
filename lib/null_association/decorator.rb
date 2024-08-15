# frozen_string_literal: true

module NullAssociation
  module Decorator
    extend self

    def [](association_name, null_object: nil)
      Module.new do
        define_method association_name do
          super().presence || case null_object
                              in String => class_name
                                class_name.classify.constantize.new
                              in Class => klass if klass < Singleton
                                klass.instance
                              in Singleton => singleton
                                singleton
                              in Class => klass
                                klass.new
                              in Object => instance
                                instance
                              else
                                nil
                              end
        end
      end
    end
  end
end

