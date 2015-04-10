module Rules
  # Events
  report_start =        ->(line) { /Page 1/.match line }
  report_continuation = ->(line) { /Page [^1]/.match line }
    header_start =  ->(line) { /(LabCorp)|(Quest)/.match line }
      specimen_id = ->(line) { /Specimen ID\:\s*(\w+)\s*$/.match line}
    header_end =    ->(line) { /Provider/.match line }
    body_start =    ->(line) { /Test\/Component/.match line}
      #test_start = ->(line) { /-Specimen Information-/.match line }
      test_start =  ->(line) { /^([A-Z][\w\s,\(\)]+)\[\d*\]/.match line }
      interest_found = ->(line) { test line }
    body_end =      ->(line) { /80\: (LabCorp)|(Quest)/.match line }
  page_end =        ->(line) { /Results were for /.match line }

  # States
  states = [:new_rpt, :continuing_rpt, :in_header, :spec_id_found,
            :in_body, :new_test, :leave_body ]
end

