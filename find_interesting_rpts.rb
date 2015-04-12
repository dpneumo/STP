module FindInterestingRpts
  attr_accessor :rpt, :interesting

  nothing_happened? = ->(line) { true }
  new_report? = ->(line) { /Page 1/.match line }
  end_of_report? = ->(line) { /80\: (LabCorp)|(Quest)/.match line }
  interesting? = ->(line) { /^\s*Eos/ }


  init_report =  ->(line) { rpt = [] }
  init_interesting = ->(line) { interesting = false }
  store_rpt_line =  ->(line) { rpt << line }
  mark_as_interesting =  ->(line) { interesting = true }
  save_report =  ->(line) { puts rpt }
  do_nothing = ->(line) {}

  # beginning state events
  def rpt_start_evnt
    { check: new_report?,
      new_state: :new_rpt,
      actions: [init_report, init_interesting],
      transforms: [] }
  end

  # new_rpt state events
  def rpt_end_evnt
    { check: end_of_report?,
      new_state: :wait4rpt
      actions: [store_rpt_line, save_report],
      transforms: [] }
  end

  def interesting_evnt
    { check: interesting?,
      new_state: nil,
      actions: [mark_as_interesting, store_rpt_line],
      transforms: [] }
  end

  # wait4rpt state events
  def rpt_start_evnt
    { check: new_report?,
      new_state: :new_rpt,
      actions: [init_report, init_interesting, store_rpt_line],
      transforms: [] }
  end

  # nothing happened events

  def skip_line_evnt
    { check: nothing_happened?,
      new_state: :wait4rpt,
      actions: [],
      transforms: [] }
  end

  def rpt_readln_evn
    { check: nothing_happened?,
      new_state: nil,
      actions: [store_rpt_line],
      transforms: [] }
  end
end
