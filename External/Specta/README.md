# Specta

A light-weight TDD / BDD framework for Objective-C & Cocoa.

### FEATURES

* RSpec-like BDD DSL
* Super quick and easy to set up
* Runs on top of OCUnit
* Excellent Xcode integration

### SCREENSHOT

![Specta Screenshot](http://github.com/petejkim/stuff/raw/master/images/specta-screenshot.png)

### SETUP

Use [CocoaPods](http://github.com/CocoaPods/CocoaPods)

```ruby
target :MyApp do
  # your app dependencies
end

target :MyAppTests do
  pod 'Specta',      '~> 0.1.11'
  # pod 'Expecta',     '~> 0.2.1'   # expecta matchers
  # pod 'OCHamcrest',  '~> 1.7'     # hamcrest matchers
  # pod 'OCMock',      '~> 2.0.1'   # OCMock
  # pod 'LRMocky',     '~> 0.9.1'   # LRMocky
end
```

or

1. Clone from Github.
2. Run `rake` in project root to build.
3. Add a "Cocoa/Cocoa Touch Unit Testing Bundle" target if you don't already have one.
4. Copy and add all header files in `products` folder to the Test target in your Xcode project.
5. For **OS X projects**, copy and add `libSpecta-macosx.a` in `products` folder to the Test target in your Xcode project.  
   For **iOS projects**, copy and add `libSpecta-ios-universal.a` in `products` folder to the Test target in your Xcode project.
6. Add `-ObjC` and `-all_load` to the "Other Linker Flags" build setting for the Spec/Test target in your Xcode project.
7. Add the following to your test code.

```objective-c
#import "Specta.h"
```

Standard OCUnit matchers such as `STAssertEqualObjects` and `STAssertNil` work, but you probably want to add a nicer matcher framework - [Expecta](http://github.com/petejkim/expecta/) to your setup. Or if you really prefer, [OCHamcrest](https://github.com/jonreid/OCHamcrest) works fine too. Also, add a mocking framework: [OCMock](http://ocmock.org/).

## WRITING SPECS

```objective-c
#import "Specta.h"

SharedExamplesBegin(MySharedExamples)
// Global shared examples are shared across all spec files.

sharedExamplesFor(@"a shared behavior", ^(NSDictionary *data) {
  it(@"should do some stuff", ^{
    id obj = [data objectForKey:@"key"];
    // ...
  });
});

SharedExamplesEnd

SpecBegin(Thing)

describe(@"Thing", ^{
  sharedExamplesFor(@"another shared behavior", ^(NSDictionary *data) {
    // Locally defined shared examples can override global shared examples within its scope.
  });

  beforeAll(^{
    // This is run once and only once before all of the examples
    // in this group and before any beforeEach blocks.
  });

  beforeEach(^{
    // This is run before each example.
  });

  it(@"should do stuff", ^{
    // This is an example block. Place your assertions here.
  });

  it(@"should do some stuff asynchronously", ^AsyncBlock {
    // Async example blocks need to invoke done() callback.
    done();
  });
  // You'll have to build your project with Clang (Apple LLVM Compiler) in order to use this feature.

  itShouldBehaveLike(@"a shared behavior", [NSDictionary dictionaryWithObjectsAndKeys:@"obj", @"key", nil]);

  itShouldBehaveLike(@"another shared behavior", ^{
    // Use a block that returns a dictionary if you need the context to be evaluated lazily,
    // e.g. to use an object prepared in a beforeEach block.
    return [NSDictionary dictionaryWithObjectsAndKeys:@"obj", @"key", nil];
  });

  describe(@"Nested examples", ^{
    it(@"should do even more stuff", ^{
      // ...
    });
  });

  pending(@"pending example");

  pending(@"another pending example", ^{
    // ...
  });

  afterEach(^{
    // This is run after each example.
  });

  afterAll(^{
    // This is run once and only once after all of the examples
    // in this group and after any afterEach blocks.
  });
});

SpecEnd
```

* `beforeEach` and `afterEach` are also aliased as `before` and `after` respectively.
* `describe` is also aliased as `context`.
* `it` is also aliased as `example` and `specify`.
* `itShouldBehaveLike` is also aliased as `itBehavesLike`.
* Use `pending` or prepend `x` to `describe`, `context`, `example`, `it`, and `specify` to mark examples or groups as pending.
* Use `^AsyncBlock` as shown in the example above to make examples wait for completion. `done()` callback needs to be invoked to let Specta know that your test is complete. The default timeout is 10.0 seconds but this can be changed by calling the function `setAsyncSpecTimeout(NSTimeInterval timeout)`.
* `(before|after)(Each/All)` also accept `^AsyncBlock`s.
* Do `#define SPT_CEDAR_SYNTAX` before importing Specta if you prefer to write `SPEC_BEGIN` and `SPEC_END` instead of `SpecBegin` and `SpecEnd`.
* Prepend `f` to your `describe`, `context`, `example`, `it`, and `specify` to set focus on examples or groups. When specs are focused, all unfocused specs are skipped.

### RUNNING SPECS FROM COMMAND LINE / CI

~~Refer to
[this blog post](http://www.raingrove.com/2012/03/28/running-ocunit-and-specta-tests-from-command-line.html)
on how to run specs from command line or in continuous integration
servers.~~

Check out Facebook's [xctool](https://github.com/facebook/xctool).

### CONTRIBUTION GUIDELINES

* Please use only spaces and indent 2 spaces at a time.
* Please prefix instance variable names with a single underscore (`_`).
* Please prefix custom classes and functions defined in the global scope with `SPT`.

### CONTRIBUTORS

* Christian Niles [(nerdyc)](https://github.com/nerdyc)
* Dan Palmer [(danpalmer)](https://github.com/danpalmer)
* Justin Spahr-Summers [(jspahrsummers)](https://github.com/jspahrsummers)
* Josh Abernathy [(joshaber)](https://github.com/joshaber)
* Meiwin Fu [(meiwin)](https://github.com/meiwin)
* Robert Gilliam [(rhgills)](https://github.com/rhgills)
* Shawn Morel [(strangemonad)](https://github.com/strangemonad)
* Tom Brow [(brow)](https://github.com/brow)
* Tony Arnold [(tonyarnold)](https://github.com/tonyarnold)

## LICENSE

Copyright (c) 2012 Peter Jihoon Kim. This software is licensed under the [MIT License](http://github.com/petejkim/specta/raw/master/LICENSE).

