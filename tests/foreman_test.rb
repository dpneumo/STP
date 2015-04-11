require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative '../lib/foreman'

class ForemanTest < MiniTest::Test
  def setup
    plan = { beginning: [ {test: ->(line) { /REa/.match line }, new_state: :middle,    actions: [], transforms: [->(line) { line.upcase   }] },
                          {test: ->(line) { /REb/.match line }, new_state: :ending,    actions: [], transforms: [->(line) { line.reverse  }] },
                          {test: ->(line) { true },             new_state: :beginning, actions: [], transforms: [->(line) { line          }] }  ],
              middle:   [ {test: ->(line) { /REc/.match line }, new_state: :ending,    actions: [], transforms: [->(line) { line.downcase }] }  ],
              ending:   [ {test: ->(line) { /REd/.match line }, new_state: :beginning, actions: [], transforms: [->(line) { line.swapcase }] }  ],
            }
    @fm = Foreman.new( coderunner: MiniTest::Mock.new,
                       plan:       Plan.new(master: plan) )
    @fm.coderunner.expect :actions=, nil, [[]]
    @fm.coderunner.expect :transforms=, nil, [->(line) { line }]
  end

  def test_correctly_handles_transition_when_line_matches_an_allowed_transition
    @fm.call('REa')
    assert_equal :middle, @fm.current_state
    @fm.coderunner.verify
  end

  def test_state_is_not_changed_if_line_does_not_match_an_allowed_transition
    @fm.call('will not match')
    assert_equal :beginning, @fm.current_state
  end
end
