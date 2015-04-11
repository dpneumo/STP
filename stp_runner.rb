###########################################
#
#   stp_runner.rb
#
#   A brief demonstration of the use of STP
#
###########################################
require_relative 'lib/stp'

def atest(line)
  puts line
  /Prevailed/.match line
end

plan = { beginning: [ { test: ->(line) { atest line },
                        new_state: :middle,
                        actions: [],
                        transforms: [->(line) { line.upcase   }] },
                      { test: ->(line) { true },
                        new_state: :beginning,
                        actions: [],
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

