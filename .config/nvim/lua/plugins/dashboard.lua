local max_line_width = 44

local quotes = {
  { "Configure, don't integrate.", 'Implement technology choices for an application as configuration options, not through integration or engineering.', '' },
  { "Costly tools don't produce better designs.", 'Beware of vendor hype, industry dogma, and the aura of the price tag. Judge tools on their merits.', '' },
  { "DRY - Don't Repeat Yourself.", 'Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.', '' },
  { "Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.", 'Brian Kernighan' },
  { "Don't assume it - prove it.", 'Prove your assumptions in the actual environment - with real data and boundary conditions.', '' },
  { "Don't be a slave to formal methods.", "Don't blindly adopt any technique without putting it into the context of your development practices and capabilities.", '' },
  { "Don't gather requirements - dig for them.", "Requirements rarely lie on the surface. They're buried deep beneath layers of assumptions, misconceptions, and politics.", '' },
  { "Don't live with broken windows.", 'Fix bad designs, wrong decisions, and poor code when you see them.', '' },
  { "Don't panic when debugging", 'Take a deep breath and THINK! about what could be causing the bug.', '' },
  { "Don't program by coincidence.", "Rely only on reliable things. Beware of accidental complexity, and don't confuse a happy coincidence with a purposeful plan.", '' },
  { "Don't think outside the box - find the box.", 'When faced with an impossible problem, identify the real constraints. Ask yourself: "Does it have to be done this way? Does it have to be done at all?"', '' },
  { "Don't use manual procedures.", 'A shell script or batch file will execute the same instructions, in the same order, time after time.', '' },
  { "Don't use wizard code you don't understand.", 'Wizards can generate reams of code. Make sure you understand all of it before you incorporate it into your project.', '' },
  { "Don't worry if it doesn't work right. If everything did, you'd be out of a job.", "Mosher's Law of Software Engineering" },
  { "Gently exceed your users' expectations.", "Come to understand your users' expectations, then deliver just that little bit more.", '' },
  { "I've finally learned what \"upward compatible\" means. It means we get to keep all our old mistakes.", 'Dennie van Tassel' },
  { "If you can't explain something to a six-year-old, you really don't understand it yourself.", 'Albert Einstein' },
  { "If you don't fail at least 90% of the time, you're not aiming high enough.", 'Alan Kay' },
  { "If you don't finish then you're just busy, not productive.", '' },
  { "If you don't make mistakes, you're not working on hard enough problems.", 'Frank Wilczek' },
  { "If you don't start with a spec, every piece of code you write is a patch.", 'Leslie Lamport' },
  { "In software, we rarely have meaningful requirements. Even if we do, the only measure of success that matters is whether our solution solves the customer's shifting idea of what their problem is.", 'Jeff Atwood' },
  { "It's both what you say and the way you say it.", "There's no point in having great ideas if you don't communicate them effectively.", '' },
  { "It's ridiculous to live 100 years and only be able to remember 30 million bytes. You know, less than a compact disc. The human condition is really becoming more obsolete every minute.", 'Marvin Minsky' },
  { "Progress in a fixed context is almost always a form of optimization. Creative acts generally don't stay in the context that they are in.", 'Alan Kay' },
  { "Provide options, don't make lame excuses.", "Instead of excuses, provide options. Don't say it can't be done; explain what can be done.", '' },
  { "Start when you're ready.", "You've been building experience all your life. Don't ignore niggling doubts.", '' },
  { "The average user doesn't give a damn what happens, as long as (1) it works and (2) it's fast.", 'Daniel J. Bernstein' },
  { "The bulk of all patents are crap. Spending time reading them is stupid. It's up to the patent owner to do so, and to enforce them.", 'Linus Torvalds' },
  { "The city's central computer told you? R2D2, you know better than to trust a strange computer!", 'C3PO' },
  { "The computing scientist's main challenge is not to get confused by the complexities of his own making.", 'Edsger W. Dijkstra' },
  { "There are two major products that come out of Berkeley: LSD and UNIX. We don't believe this to be a coincidence.", 'Jeremy S. Anderson' },
  { "There's an old story about the person who wished his computer were as easy to use as his telephone. That wish has come true, since I no longer know how to use my telephone.", 'Bjarne Stroustrup' },
  { "You can't write perfect software.", "Software can't be perfect. Protect your code and users from the inevitable errors.", '' },
  { "\"select\" isn't broken.", 'It is rare to find a bug in the OS or the compiler, or even a third-party product or library. The bug is most likely in the application.', '' },
  { "dd is horrible on purpose. It's a joke about OS/360 JCL. But today it's an internationally standardized joke. I guess that says it all.", 'Rob Pike' },
  { '640K ought to be enough for anybody.', 'Bill Gates, 1981' },
  { 'A LISP programmer knows the value of everything, but the cost of nothing.', 'Alan J. Perlis' },
  { 'A good programmer is someone who always looks both ways before crossing a one-way street.', 'Doug Linder' },
  { 'A programming language is for thinking about programs, not for expressing programs you’ve already thought of. It should be a pencil, not a pen', 'Paul Graham' },
  { 'Abstraction is not about vagueness, it is about being precise at a new semantic level.', 'Edsger W. Dijkstra' },
  { 'Abstractions live longer than details.', 'Invest in the abstraction, not the implementation. Abstractions can survive the barrage of changes from different implementations and new technologies.', '' },
  { 'Active programming consists of the design of new programs rather than the contemplation of old programs', 'Niklaus Wirth' },
  { 'Adapting old programs to fit new machines usually means adapting new machines to behave like old ones.', 'Alan Perlis' },
  { 'All idioms must be learned. Good idioms only need to be learned once.', 'Alan Cooper' },
  { 'All loops are infinite ones for faulty RAM modules.', '' },
  { 'All problems in computer science can be solved with another level of indirection.', 'David Wheeler' },
  { 'All programming is an exercise in caching.', 'Terje Mathisen' },
  { 'Almost every programming language is overrated by its practitioners.', 'Larry Wall' },
  { 'Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live', 'John Woods' },
  { 'Always design for concurrency.', "Allow for concurrency, and you'll design cleaner interfaces with fewer assumptions.", '' },
  { 'Always use source code control.', 'Source code control is a time machine for your work - you can go back.', '' },
  { 'Analyze workflow to improve concurrency.', "Exploit concurrency in your user's workflow.", '' },
  { 'Any fool can write code that a computer can understand. Good programmers write code that humans can understand', 'Martin Fowler' },
  { 'As a programmer, it is your job to put yourself out of business. What you do today can be automated tomorrow', 'Doug McIlroy' },
  { 'Bad programmers worry about the code. Good programmers worry about data structures and their relationships', 'Linus Torvalds' },
  { 'Be a catalyst for change.', "You can't force change on people. Instead, show them how the future might be and help them participate in creating it.", '' },
  { 'Be curious. Read widely. Try new things. I think a lot of what people call intelligence boils down to curiosity.', 'Aaron Swartz' },
  { 'Before software can be reusable it first has to be usable', 'Ralph Johnson' },
  { 'C makes it easy to shoot yourself in the foot; C++ makes it harder, but when you do, it blows away your whole leg', 'Bjarne Stroustrup' },
  { 'Caches are bugs waiting to happen.', 'Rob Pike' },
  { 'Care about your craft.', 'Why spend your life developing software unless you care about doing it well?', '' },
  { 'Complexity kills. It sucks the life out of developers, it makes products difficult to plan, build and test, it introduces security challenges, and it causes end-user and administrator frustration.', 'Ray Ozzie' },
  { 'Computer science education cannot make anybody an expert programmer any more than studying brushes and pigment can make somebody an expert painter.', 'Eric S. Raymond' },
  { 'Computers are harder to maintain at high altitude. Thinner air means less cushion between disk heads and platters. Also more radiation.', '' },
  { 'Computers are useless. They can only give you answers.', 'Pablo Picasso' },
  { 'Contrary to popular belief, Unix is user friendly. It just happens to be very selective about who it decides to make friends with.', '' },
  { 'Controlling complexity is the essence of computer programming.', 'Brian Kernighan' },
  { 'Crash early.', 'A dead program normally does a lot less damage than a crippled one.', '' },
  { 'Critically analyze what you read and hear.', "Don't be swayed by vendors, media hype, or dogma. Analyze information in terms of you and your project.", '' },
  { 'Debugging becomes significantly easier if you first admit that you are the problem', 'William Laeder' },
  { 'Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it', 'Rajanand' },
  { 'Design With contracts.', 'Use contracts to document and verify that code does no more and no less than it claims to do.', '' },
  { 'Design to test.', 'Start thinking about testing before you write a line of code.', '' },
  { 'Design using services.', 'Design in terms of services-independent, concurrent objects behind well-defined, consistent interfaces.', '' },
  { 'Developing tolerance for imperfection is the key factor in turning chronic starters into consistent finishers.', 'Jon Acuff' },
  { 'Don’t comment bad code - rewrite it', 'Brian Kernighan' },
  { 'Easy things should be easy and hard things should be possible.', 'Larry Wall' },
  { 'Eliminate effects between unrelated things.', 'Design components that are self-contained, independent, and have a single, well-defined purpose.', '' },
  { 'English is just a programming language.', 'Write documents as you would write code: honor the DRY principle, use metadata, MVC, automatic generation, and so on.', '' },
  { 'Estimate the order of your algorithms.', 'Get a feel for how long things are likely to take before you write code.', '' },
  { 'Estimate to avoid surprises.', "Estimate before you start. You'll spot potential problems up front.", '' },
  { 'Every great developer you know got there by solving problems they were unqualified to solve until they actually did it.', 'Patrick McKenzie' },
  { 'Everybody in this country should learn to program a computer because it teaches you how to think', 'Steve Jobs' },
  { 'Everyday life is like programming, I guess. If you love something, you can put beauty into it', 'Donald Knuth' },
  { 'Experience is the name everyone gives to their mistakes', 'Oscar Wilde' },
  { 'Fancy algorithms are slow when n is small, and n is usually small.', 'Rob Pike' },
  { 'Find bugs once.', 'Once a human tester finds a bug, it should be the last time a human tester finds that bug. Automatic tests should check for it from then on.', '' },
  { 'Finish what you start.', 'Where possible, the routine or object that allocates a resource should be responsible for deallocating it.', '' },
  { 'First, solve the problem. Then, write the code.', 'John Johnson' },
  { 'Fix the cause, not the symptom', 'Steve Maguire' },
  { 'Fix the problem, not the blame.', "It doesn't really matter whether the bug is your fault or someone else's - it is still your problem, and it still needs to be fixed.", '' },
  { 'Fools ignore complexity. Pragmatists suffer it. Some can avoid it. Geniuses remove it.', 'Alan Perlis' },
  { 'For a successful technology, reality must take precedence over public relations, for Nature cannot be fooled.', 'Richard Feynman' },
  { 'Functions delay binding; data structures induce binding. Moral: Structure data late in the programming process.', 'Alan J. Perlis' },
  { 'Give someone a program; you frustrate them for a day; teach them how to program, and you frustrate them for a lifetime', 'David Leinweber' },
  { 'I don’t care if it works on your machine! We are not shipping your machine', 'Vidiu Platon' },
  { 'I think a lot of new programmers like to use advanced data structures and advanced language features as a way of demonstrating their ability. I call it the lion-tamer syndrome. Such demonstrations are impressive, but unless they actually translate into real wins for the project, avoid them.', 'Glyn Williams' },
  { 'I would rather die of passion than of boredom.', 'Vincent Van Gogh' },
  { 'If a system is to serve the creative spirit, it must be entirely comprehensible to a single individual.', '' },
  { 'If debugging is the process of removing bugs, then programming must be the process of putting them in.', 'Edsger W. Dijkstra' },
  { 'If programmers were electricians, parallel programmers would be bomb disposal experts. Both cut wires.', 'Bartosz Milewski' },
  { 'If the code and the comments do not match, possibly both are incorrect', 'Norm Schryer' },
  { 'If you optimize everything, you will always be unhappy', 'Donald Knuth' },
  { 'In programming, if someone tells you you’re overcomplicating it, they’re either 10 steps behind you or 10 steps ahead of you', 'Andrew Clark' },
  { 'In programming, the hard part isn’t solving problems but deciding what problems to solve', 'Paul Graham' },
  { 'Invest regularly in your knowledge portfolio.', 'Make learning a habit.', '' },
  { 'It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures.', 'Alan Perlis' },
  { 'It is easier to change the specification to fit the program than vice versa.', 'Alan Perlis' },
  { 'It is far, far easier to make a correct program fast than to make a fast program correct', 'Herb Sutter' },
  { 'Iterate the schedule with the code.', 'Use experience you gain as you implement to refine the project time scales.', '' },
  { 'It´s better to wait for a productive programmer to become available than it is to wait for the first available programmer to become productive', 'Steve McConnell' },
  { 'Keep knowledge in plain text.', "Plain text won't become obsolete. It helps leverage your work and simplifies debugging and testing.", '' },
  { 'Learn a text manipulation language.', 'You spend a large part of each day working with text. Why not have the computer do some of it for you?', '' },
  { 'Make it easy to reuse.', "If it's easy to reuse, people will. Create an environment that supports reuse.", '' },
  { 'Make it work, make it right, make it fast', 'Kent Beck' },
  { 'Make quality a requirements issue.', "Involve your users in determining the project's real quality requirements.", '' },
  { 'Making code does what it’s supposed to do is the easy part. Handling the myriad ways it can go wrong is the real work', 'Aaron Lozier' },
  { 'Measuring programming progress by lines of code is like measuring aircraft building progress by weight.', 'Bill Gates' },
  { 'Methods are just functions with a special first argument.', 'Andrew Gerrand' },
  { 'Minimize coupling between modules.', 'Avoid coupling by writing "shy" code and applying the Law of Demeter.', '' },
  { 'Most good programmers do programming not because they expect to get paid or get adulation by the public but because it is fun to program', 'Linus Torvalds' },
  { 'Most of you are familiar with the virtues of a programmer. There are three, of course: laziness, impatience, and hubris.', 'Larry Wall' },
  { 'Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves.', 'Alan Kay' },
  { 'No matter how far down the wrong road you have gone, turn back now.', '' },
  { 'No one in the brief history of computing has ever written a piece of perfect software. It’s unlikely that you’ll be the first', 'Andy Hunt' },
  { 'Nothing is more permanent than a temporary solution.', '' },
  { 'One of my most productive days was throwing away 1000 lines of code', 'Ken Thompson' },
  { 'Optimism is an occupational hazard of programming; feedback is the treatment.', 'Kent Beck' },
  { 'Optimization hinders evolution.', 'Alan Perlis' },
  { 'Organize teams around functionality.', "Don't separate designers from coders, testers from data modelers. Build teams the way you build code.", '' },
  { 'Patterns mean "I have run out of language."', 'Rich Hickey' },
  { 'People don’t care about what you say, they care about what you build', 'Mark Zuckerberg' },
  { 'Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away.', '' },
  { 'Program close to the problem domain.', "Design and code in your user's language.", '' },
  { 'Programs must be written for people to read, and only incidentally for machines to execute', 'Harold Abelson' },
  { 'Prototype to learn.', 'Prototyping is a learning experience. Its value lies not in the code you produce, but in the lessons you learn.', '' },
  { 'Put abstractions in code, details in metadata.', 'Program for the general case, and put the specifics outside the compiled code base.', '' },
  { 'Question: How does a large software project get to be one year late?', 'Answer: One day at a time!', '' },
  { 'Recursion is the root of computation since it trades description for time.', 'Alan Perlis' },
  { 'Refactor early, refactor often.', 'Just as you might weed and rearrange a garden, rewrite, rework, and re-architect code when it needs it. Fix the root of the problem.', '' },
  { 'Remember the big picture.', "Don't get so engrossed in the details that you forget to check what's happening around you.", '' },
  { 'Separate views from models.', 'Gain flexibility at low cost by designing your application in terms of models and views.', '' },
  { 'Sign your work.', 'Craftsmen of an earlier age were proud to sign their work. You should be, too.', '' },
  { 'Simplicity does not precede complexity, but follows it.', 'Alan Perlis' },
  { 'Small minds are concerned with the extraordinary, great minds with the ordinary', 'Blaise Pascal' },
  { 'Software is hard.', 'Donald Knuth' },
  { 'Some things are better done than described.', "Don't fall into the specification spiral - at some point you need to start coding.", '' },
  { 'Sometimes it pays to stay in bed on Monday rather than spending the rest of the week debugging Monday’s code', 'Dan Salomon' },
  { 'System programmers are the high priests of a low cult', 'Robert S. Barton' },
  { 'Talk is cheap. Show me the code', 'Linus Torvalds' },
  { 'Test early. Test often. Test automatically.', 'Tests that run with every build are much more effective than test plans that sit on a shelf.', '' },
  { 'Test state coverage, not code coverage.', "Identify and test significant program states. Just testing lines of code isn't enough.", '' },
  { 'Test your estimates.', "Mathematical analysis of algorithms doesn't tell you everything. Try timing your code in its target environment.", '' },
  { 'Test your software, or your users will.', "Test ruthlessly. Don't make your users find bugs for you.", '' },
  { 'Testing can only prove the presence of bugs, not their absence', 'Edsger W. Dijkstra' },
  { 'The computer was born to solve problems that did not exist before', 'Bill Gates' },
  { 'The essence of XML is this: the problem it solves is not hard, and it does not solve the problem well.', 'Phil Wadler' },
  { 'The first 90% of the code accounts for the first 90% of the development time. The remaining 10% of the code accounts for the other 90% of the development time.', 'Tom Cargill' },
  { 'The function of good software is to make the complex appear to be simple.', 'Grady Booch' },
  { 'The object-oriented model makes it easy to build up programs by accretion. What this often means, in practice, is that it provides a structured way to write spaghetti code.', 'Paul Graham' },
  { 'The question of whether computers can think is like the question of whether submarines can swim.', 'Edsger W. Dijkstra' },
  { 'The trouble with programmers is that you can never tell what a programmer is doing until it’s too late', 'Seymour Cray' },
  { 'There are no final decisions.', 'No decision is cast in stone. Instead, consider each as being written in the sand at the beach, and plan for change.', '' },
  { 'There are only two industries that refer to their customers as "users".', 'Edward Tufte' },
  { 'There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies.', 'C.A.R. Hoare' },
  { 'There is a big difference between making a simple product & making a product simple', 'Des Traynor' },
  { 'There is nothing quite so useless as doing with great efficiency something that should not be done at all.', 'Peter Drucker' },
  { 'They did not know it was impossible, so they did it!', 'Mark Twain' },
  { 'Think about your work.', 'Turn off the autopilot and take control. Constantly critique and appraise your work.', '' },
  { 'Think twice, code once.', '' },
  { 'To iterate is human, to recurse divine.', 'L. Peter Deutsch' },
  { 'To understand recursion, one must first understand recursion.', 'Stephen Hawking' },
  { 'Truth can only be found in one place: the code', 'Robert C. Martin' },
  { 'Unix was not designed to stop its users from doing stupid things, as that would also stop them from doing clever things.', '' },
  { 'Use a project glossary.', 'Create and maintain a single source of all the specific terms and vocabulary for a project.', '' },
  { 'Use a single editor well.', 'The editor should be an extension of your hand; make sure your editor is configurable, extensible, and programmable.', '' },
  { 'Use assertions to prevent the impossible.', 'Assertions validate your assumptions. Use them to protect your code from an uncertain world.', '' },
  { 'Use blackboards to coordinate workflow.', 'Use blackboards to coordinate disparate facts and agents, while maintaining independence and isolation among participants.', '' },
  { 'Use exceptions for exceptional problems.', 'Exceptions can suffer from all the readability and maintainability problems of classic spaghetti code. Reserve exceptions for exceptional things.', '' },
  { 'Use saboteurs to test your testing.', 'Introduce bugs on purpose in a separate copy of the source to verify that testing will catch them.', '' },
  { 'Use the power of command shells.', "Use the shell when graphical user interfaces don't cut it.", '' },
  { 'Walking on water and developing software from a specification are easy if both are frozen.', 'Edward V. Berard' },
  { 'We have to stop optimizing for programmers and start optimizing for users', 'Jeff Atwood' },
  { 'Weeks of programming can save you hours of planning.', '' },
  { 'What one programmer can do in one month, two programmers can do in two months.', 'Frederick P. Brooks' },
  { 'Why do we never have time to do it right, but always have time to do it over?', '' },
  { 'Work with a user to think like a user.', "It's the best way to gain insight into how the system will really be used.", '' },
  { 'Write code that writes code.', 'Code generators increase your productivity and help avoid duplication.', '' },
  { 'Your mind is programmable - if you’re not programming your mind, else will program it for you', 'Jeremy Hammond' },
  { 'Your most unhappy customers are your greatest source of learning', 'Bill Gates' },
}

local function get_nvim_version()
    local version = vim.version()
    return string.format('%d.%d.%d', version.major, version.minor, version.patch)
end

local function random_quote()
  math.randomseed(os.time())

  local quote_lines = quotes[ math.random(#quotes) ]
  local ret = { '', '' }
  local author = quote_lines[#quote_lines]

  -- break on each ','
  -- break when max_line_length exceeded
  for i, line in ipairs(quote_lines) do
      if i == #quote_lines then
          break
      end

      local char_count = 0
      local tokens = { }

      for token in line:gmatch('[^%s]+') do
          table.insert(tokens, token)
          char_count = char_count + #token + 1
          if char_count >= max_line_width then
              table.insert(ret, table.concat(tokens, ' '))
              char_count = 0
              tokens = { }
          end
      end

      if #tokens > 0 then
          table.insert(ret, table.concat(tokens, ' '))
      end
  end

  if #author > 0 then
      table.insert(ret, '')
      table.insert(ret, string.format('- %s', author))
  end

  return ret
end

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = {
    disable_move = true,
    shortcut_type = 'number',
    config = {
      header = {
        [[     __                _           ]],
        [[  /\ \ \___  ___/\   /(_)_ __ ___  ]],
        [[ /  \/ / _ \/ _ \ \ / / | '_ ` _ \ ]],
        [[/ /\  /  __/ (_) \ V /| | | | | | |]],
        [[\_\ \/ \___|\___/ \_/ |_|_| |_| |_|]],
        [[]],
      },
      shortcut = {
        -- { desc = ' delta62', },
        { desc = string.format('  %s', get_nvim_version()) },
      },
      footer = random_quote()
    },
    hide = {
      statusline = true,
      tabline = true,
      winbar = true,
    }
  },
  dependencies = { {'nvim-tree/nvim-web-devicons'} }
}
