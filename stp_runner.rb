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

plan = {  beginning: [ {event: ->(line) { atest line },
                        new_state: :middle,
                        lam: ->(line) { line.upcase   } }  ],

          middle:    [ {event: ->(line) { /at no/.match line },
                        new_state: :ending,
                        lam: ->(line) { line.downcase } }  ],

          ending:    [ {event: ->(line) { /On dear/.match line },
                        new_state: :beginning,
                        lam: ->(line) { line.swapcase } }  ],
        }

beginning_lambda = ->(line) { nil }

document = <<EOP
asdf
Prevailed sincerity behaviour
to so do principle mr. As departure
at no propriety zealously my.
On dear rent if girl view. First on
smart there he sense. Earnestly
EOP

stp = STP.new( plan: plan, beginning_lambda: beginning_lambda, document: document )
stp.each {|line| puts line }
