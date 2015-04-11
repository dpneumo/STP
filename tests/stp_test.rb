require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative '../lib/stp'

class STPTest < MiniTest::Test
  def setup
    plan = { beginning: [ { test: ->(line) { /Prevailed/.match line },
                            new_state: :middle,
                            actions: [],
                            transforms: [->(line) { line.upcase   }] },
                          { test: ->(line) { true },
                            actions: [],
                            new_state: :beginning,
                            transforms: [->(line) { line          }] }  ],

              middle:    [ {test: ->(line) { /at no/.match line },
                            new_state: :ending,
                            actions: [],
                            transforms: [->(line) { line.downcase }] },
                          { test: ->(line) { true },
                            new_state: :middle,
                            actions: [],
                            transforms: [->(line) { line.upcase          }] }  ],

              ending:    [ {test: ->(line) { /On dear/.match line },
                            new_state: :beginning,
                            actions: [],
                            transforms: [->(line) { line.swapcase }] },
                          { test: ->(line) { true },
                            new_state: :ending,
                            actions: [],
                            transforms: [->(line) { line.downcase          }] }  ],
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
                 "smart there\n" ]

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
