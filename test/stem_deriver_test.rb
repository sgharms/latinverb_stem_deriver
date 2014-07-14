class StemDeriverTest < Minitest::Test
  def test_first
    stub = OpenStruct.new(present_active_infinitive: "laudāre", regular?: true )
    assert_equal Linguistics::Latin::Verb::LatinVerb::StemDeriver.new(stub).stem, "laudā"
  end

  def test_second
    stub = OpenStruct.new(present_active_infinitive: "monēre", regular?: true )
    assert_equal Linguistics::Latin::Verb::LatinVerb::StemDeriver.new(stub).stem, "monē"
  end

  def test_third
    stub = OpenStruct.new(present_active_infinitive: "agere", regular?: true, first_person_singular: "agō" )
    assert_equal Linguistics::Latin::Verb::LatinVerb::StemDeriver.new(stub).stem, "ag"
  end

  def test_thirdio
    stub = OpenStruct.new(present_active_infinitive: "capere", regular?: true, first_person_singular: "capiō" )
    assert_equal Linguistics::Latin::Verb::LatinVerb::StemDeriver.new(stub).stem, "cap"
  end

  def test_fourth
    stub = OpenStruct.new(present_active_infinitive: "audīre", regular?: true )
    assert_equal Linguistics::Latin::Verb::LatinVerb::StemDeriver.new(stub).stem, "aud"
  end

  def test_deponent
    stub = OpenStruct.new(regular?: false, original_string: "hi didldy do neighbor")
    assert_equal Linguistics::Latin::Verb::LatinVerb::StemDeriver.new(stub).stem, "didldyre"
  end
end
