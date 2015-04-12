require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative '../lib/stp'
require_relative 'plan_helper'

class STPTest < MiniTest::Test
  include PlanHelper
  def setup
    plan = { beginning: [ prevailed_evnt, skip_beg_line_evnt ],
             middle:    [ at_no_evnt, skip_mid_line_evnt ],
             ending:    [ on_dear_evnt, skip_end_line_evnt ] }

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
