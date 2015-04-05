require 'minitest/autorun'
require 'pry'
require_relative '../lib/stp'

class STPTest < MiniTest::Test
  def setup
    plan = { beginning: [ {event: ->(line) { /Prevailed/.match line },
                            new_state: :middle,
                            lam: ->(line) { line.upcase   } }  ],

              middle:    [ {event: ->(line) { /at no/.match line },
                            new_state: :ending,
                            lam: ->(line) { line.downcase } }  ],

              ending:    [ {event: ->(line) { /On dear/.match line },
                            new_state: :beginning,
                            lam: ->(line) { line.swapcase } }  ],
            }
    arry_doc = [ "departure\n",
                 "Prevailed sincerity\n",
                 "to so do principle\n",
                 "at no propriety\n",
                 "On dear rent\n",
                 "smart there\n" ]
    str_doc = arry_doc.join

    @expect  = [ "departure\n",
                 "PREVAILED SINCERITY\n",
                 "TO SO DO PRINCIPLE\n",
                 "at no propriety\n",
                 "oN DEAR RENT\n",
                 "SMART THERE\n" ]

    @stp_str = STP.new(plan: plan, document: str_doc)
    @stp_ary = STP.new(plan: plan, document: arry_doc)
    @stp_num = STP.new(plan: plan, document: 42)
  end

  def test_stp_provided_string_document_and_plan_returns_transformed_document_in_lines
    assert_equal @expect, @stp_str.lines
  end

  def test_stp_provided_array_document_and_plan_returns_transformed_document_in_lines
    assert_equal @expect, @stp_ary.lines
  end

  def test_stp_provided_a_document_neither_string_or_array_raises_an_ArgumentError
    assert_raises(ArgumentError) { @stp_num.lines }
  end
end
