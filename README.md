##STP: Stateful Text Parser

This is a line oriented parser. It is designed to support both transforming each line as it passes through the state machine and to allow side effects to be generated based on the line and the current state of the machine. This is a mapping operation with respect to the original source of the lines. That source is not altered. The transformed lines are returned in #lines as an array of strings in the order of the lines in the source.

###The source document must be one of:

    a file:
        File.open('path/to/file') do |file|
          stp = STP.new(document: file, plan: plan)
          do_something_with stp.lines
        end

    an array of strings:
        stp = STP.new(document: [str1, str2, str3], plan: plan)
        do_something_with stp.lines

    a string
        stp = STP.new(document: "str1\nstr2\nstr3\n", plan: plan)
        do_something_with stp.lines


###The transformation plan has this form:

  plan = { curr_state1: protocol1,
           curr_state2: protocol2,
           ... }

  protocol1 =  [ rule1, rule2, ... ]

  rule1 = { event:     ->(line) { test1(line) },
            new_state: :another_state,
            lam:       ->(line) { transform1(line) }
          }

test **must** return true or false. It **should not** alter line nor have other side effects.

lam may transform line. It **must** return either the unaltered line, the transformed line
or nil. It **may** have side effects. eg. lam might push the transformed line into a file.


###Summary of the state machine internals:

As each line of the document is processed it is passed to foreman to check for a possible state change. Foreman checks the line against the rules defined in the protocol for the current state. The first rule that returns true for the line is used to change state. If no rule matches then the current state and protocol are not changed.

After foreman has processed the line it is passed to code runner. A lambda (lam) supplied by the transformation plan to code_runner will be called with each line currently being processed until a line triggers a state change. A state change detected by foreman will cause insertion of the new lambda into code_runner prior to submitting the line to code_runner.


              document
          (array of Lines)
                 |
                 |                     Plan
                 |                      |
            ____________     (line)     |
            |           | <==========> Foreman
            |           |                  |
            |  Mapper   |                  |
            |           |    (line)        |
            |___________| <==========> CodeRunner ----> Side Effects
                 |
                 |
                 |
              #lines
          (array of Lines)



Hopefully, this will be helpful to others. Corrections and suggestions for improvement are welcomed.

Mitch Kuppinger
(dpneumo)



**NB:** This is described in reference to a document that acts like or can be coerced to be an array of strings. However, in reality an array of any objects can be supplied if the lambdas in each rule behave correctly when called with the objects.
