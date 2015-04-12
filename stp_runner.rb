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
                        actions: [],
                        transforms: [->(line) { line.upcase   }] },
                      { check: ->(line) { true },
                        new_state: :beginning,
                        actions: [],
                        transforms: [->(line) { line          }] }  ],

          middle:    [ {check: ->(line) { /at no/.match line },
                        new_state: :ending,
                        actions: [],
                        transforms: [->(line) { line.downcase }] },
                      { check: ->(line) { true },
                        new_state: :middle,
                        actions: [],
                        transforms: [->(line) { line.upcase          }] }  ],

          ending:    [ {check: ->(line) { /On dear/.match line },
                        new_state: :beginning,
                        actions: [],
                        transforms: [->(line) { line.swapcase }] },
                      { check: ->(line) { true },
                        new_state: :ending,
                        actions: [],
                        transforms: [->(line) { line.downcase          }] }  ]
       }

initial_transforms = [->(line) { nil }]

document =  [ "departure\n",
              "Prevailed sincerity\n",
              "to so do principle\n",
              "at no propriety\n",
              "On dear rent\n",
              "smart there\n" ]

stp = STP.new( plan: plan, initial_transforms: initial_transforms, document: document )
stp.each {|line| puts line }

