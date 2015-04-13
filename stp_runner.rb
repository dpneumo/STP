###########################################
#
#   stp_runner.rb
#
#   A brief demonstration of the use of STP
#
###########################################
require_relative 'lib/stp'

def acheck(line)
  puts line
  /Prevailed/.match line
end

plan = { beginning: [ { check: ->(line) { acheck line },
                        new_state: :middle,
                        actions: nil,
                        transforms: [->(line) { line.upcase   }] },
                      { check: ->(line) { true },
                        new_state: :beginning,
                        actions: nil,
                        transforms: nil } ],

          middle:    [ {check: ->(line) { /at no/.match line },
                        new_state: :ending,
                        actions: [],
                        transforms: [->(line) { line.downcase }] },
                      { check: ->(line) { true },
                        new_state: :middle,
                        actions: [],
                        transforms: nil }  ],

          ending:    [ {check: ->(line) { /On dear/.match line },
                        new_state: :beginning,
                        actions: [],
                        transforms: [->(line) { line.swapcase }] },
                      { check: ->(line) { true },
                        new_state: :ending,
                        actions: [],
                        transforms: nil }  ]
       }

document =  [ "departure\n",
              "Prevailed sincerity\n",
              "to so do principle\n",
              "at no propriety\n",
              "On dear rent\n",
              "smart there\n" ]

stp = STP.new( plan: plan, document: document )
stp.each {|line| puts line }

