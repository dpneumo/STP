module FindInterestingRpts
  attr_accessor :rpt, :interesting

  nothing_happened? = EventTest.new( ->(line) { true } )
  new_report? = EventTest.new( ->(line) { /Page 1/.match line } )
  end_of_report? = EventTest.new( ->(line) { /80\: (LabCorp)|(Quest)/.match line } )
  interesting? = EventTest.new( ->(line) { /^\s*Eos/ } )


  init_report = Action.new( ->(line) { rpt = [] } )
  init_interesting = Action.new( ->(line) { interesting = false } )
  store_rpt_line = Action.new( ->(line) { rpt << line } )
  mark_as_interesting = Action.new( ->(line) { interesting = true } )
  save_report = Action.new( ->(line) { puts rpt } )
  do_nothing = Action.new

  # beginning state events
  rpt_start_evnt = Event.new( test: new_report?,
                              new_state: :new_rpt,
                              actions: [init_report, init_interesting],
                              transforms: [] )

  # new_rpt state events
  rpt_end_evnt =   Event.new( test: end_of_report?,
                              new_state: :wait4rpt
                              actions: [store_rpt_line, save_report],
                              transforms: [] )

  interesting_evnt = Event.new( test: interesting?,
                                new_state: nil,
                                actions: [mark_as_interesting, store_rpt_line],
                                transforms: [] )

  # wait4rpt state events
  rpt_start_evnt = Event.new( test: new_report?,
                              new_state: :new_rpt,
                              actions: [init_report, init_interesting, store_rpt_line],
                              transforms: [] )

  # nothing happened events

  skip_line_evnt =  Event.new( test: nothing_happened?,
                               new_state: :wait4rpt,
                               actions: [],
                               transforms: [] )

  rpt_readln_evnt = Event.new( test: nothing_happened?,
                               new_state: nil,
                               actions: [store_rpt_line],
                               transforms: [] )
end
