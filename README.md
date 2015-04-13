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

    rule1 = { check:      ->(line) { test1(line) },
              new_state:  :a_state,
              actions:    [ ->(line) {action1}, ->(line) {action2}, ...],
              transforms: [ ->(line) {transform1(line)}, ...]
            }

_check_ **must** return true or false. It **should not** alter _line_ nor have other side effects.

_new_state_ must be any valid state including the current state. It must be a symbol.

_actions_ must be either nil or and array (possibly empty) of actions. If nil is provided _coderunner.actions_ will not be changed by this rule

An _action_ is not a line transform and does not affect the line flowing through the code runner. An action may create "side effects" such as printing a reformatted line to a file.

_transforms_ must be either nil or and array (possibly empty) of transforms. If nil is provided _coderunner.transforms will not be changed by this rule

A _transform_ may transform _line_. It **must** return either the unaltered _line_, the transformed _line_ or nil. It **should not** have side effects. eg. push the transformed _line_ into a file.


###Summary of the state machine internals:

As each _line_ of the document is processed by _mapper_ it is passed to _foreman_ to check for a possible state change. _Foreman_ checks _line_ against the rules defined in the protocol for the current state. Each _line_ presented is treated as a new event. The first rule that returns true for _line_ is used to select the event response. It is expected that _line_ will match one of the rules defined for the current state. The last rule in the current state protocol should always match _line_.

As _foreman_ processes _line_ it identifies the applicable rule. From that rule it updates _coderunner_ with the rule associated actions and transforms. The new state specified by the rule is also captured by _foreman_ for use in guiding the next protocol selection.

Once _foreman_ has processed the rule selected by _line_ it passes control back to _mapper_. _Mapper_ in turn passes _line_ to _coderunner_ to be handled first by the updated actions and then by the updated transforms.

Each action within the actions array is called in turn with _line_ as the sole parameter. If the value of _line_ passed to the first action is modified, the modified _line_ is passed to the next action in the list. When the last action is finished the possibly modified _line_ is discarded.

The list of transforms is then processed with the original value of _line_ passed to _coderunner_. _Line_ is passed sequentially through the transforms and finally returned as transformed by _coderunner_ to _mapper_.

_Mapper_ returns the transformed list of lines in an array to its caller.



              document
          (array of lines)
                 |
                 |                     Plan
                 |                      |
            ____________     (line)     |
            |           | <==========> Foreman
            |           |                  |
            |  Mapper   |                  |
            |           |    (line)        |
            |___________| <==========> CodeRunner ----> side effects
                 |
                 |
                 |
              #lines
          (array of lines)



Hopefully, this will be helpful to others. Corrections and suggestions for improvement are welcomed.

Mitch Kuppinger
(dpneumo)

ToDo:
  1. ~~Fix ReadMe.~~
  2. Improve naming throughout the code base to align names with function.
  3. Cleanup Foreman interaction with Plan.
  4. ~~Cleanup Stp initialization.~~
        ~~initial_transforms aren't required and make no sense in this context.~~

**NB:** This is described in reference to a document that acts like or can be coerced to be an array of strings. However, in reality an array of any objects can be supplied if the lambdas in each rule behave correctly when called with the objects.
