require "latinverb_deponent_string_deriver"
require "latinverb_stem_deriver/version"

module Linguistics
  module Latin
    module Verb
      class LatinVerb
        class StemDeriver
          FIRST_CONJUGATION_IDENTIFYING_SUFFIX = /(.*ā)re$/
          SECOND_CONJUGATION_IDENTIFYING_SUFFIX = /(.*ē)re$/
          THIRD_CONJUGATION_IDENTIFYING_SUFFIX = /(.*)ere$/
          THIRDIO_CONJUGATION_IDENTIFYING_SUFFIX_ACTIVE_INDICATIVE_PRESENT_FIRST_SINGULAR = /iō/
          THIRD_STEM_PARTICLE = "e"
          THIRDIO_STEM_PARTICLE = "iē"
          FOURTH_CONJUGATION_IDENTIFYING_SUFFIX = /(.*)īre$/

          def initialize(verb, opts = {})
            @verb = verb
            @opts = opts
          end

          def stem
            return calculate_deponent_proxy_stem unless verb_is_regular?
            return $1 if present_active_infinitive =~ FIRST_CONJUGATION_IDENTIFYING_SUFFIX
            return $1 if present_active_infinitive =~ SECOND_CONJUGATION_IDENTIFYING_SUFFIX
            return $1 if present_active_infinitive =~ THIRD_CONJUGATION_IDENTIFYING_SUFFIX
            return $1 if present_active_infinitive =~ FOURTH_CONJUGATION_IDENTIFYING_SUFFIX
          end

          def participial_stem
            return $1 if present_active_infinitive.to_s =~ FIRST_CONJUGATION_IDENTIFYING_SUFFIX
            return $1 if present_active_infinitive.to_s =~ SECOND_CONJUGATION_IDENTIFYING_SUFFIX
            return $1 + calculate_particle($1) if present_active_infinitive.to_s =~ THIRD_CONJUGATION_IDENTIFYING_SUFFIX
            return $1 + THIRDIO_STEM_PARTICLE if present_active_infinitive.to_s =~ FOURTH_CONJUGATION_IDENTIFYING_SUFFIX
          end

          private

            def verb_is_regular?
              @verb.regular?
            end

            def calculate_deponent_proxy_stem
              proxy_string.split(/\s+/)[1]
            end

            def proxy_string
              klass = (@opts[:proxy_string_deriver] || Linguistics::Latin::Verb::LatinVerb::DeponentStringDeriver)
              klass.new(original_string).proxy_string
            end

            def original_string
              @verb.original_string
            end

            def present_active_infinitive
              @verb.present_active_infinitive
            end

            def first_person_singular
              @verb.first_person_singular
            end

            def deponent_or_impersonal?
              @verb.deponent? || @verb.semideponent? || @verb.impersonal?
            end

            def calculate_particle(portion)
              first_person_singular =~ THIRDIO_CONJUGATION_IDENTIFYING_SUFFIX_ACTIVE_INDICATIVE_PRESENT_FIRST_SINGULAR ? THIRDIO_STEM_PARTICLE : THIRD_STEM_PARTICLE
            end
        end
      end
    end
  end
end
