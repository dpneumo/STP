###########################################
#
#   interesting runner.rb
#
#   Use STP to parse a file for interesting records
#
###########################################
require_relative 'lib/stp'
require_relative 'find_interesting_rpts.rb'

include FindInterestingRpts

plan = { beginning: [ rpt_start_evnt, skip_line_evnt ],
         new_rpt:   [ rpt_end_evnt, interesting_evnt, rpt_readln_evnt ],
         wait4rpt:  [ rpt_start_evnt, skip_line_evnt ]
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
stp.each {|line|  }
