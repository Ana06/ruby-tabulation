# ruby-tabulation

Analyze if the Ruby hashing algorithm could be improved using Tabulation Hashing.
This is a project for my [Advanced Algorithms course](http://www.cs.columbia.edu/~andoni/advancedS20/index.html) by [Alexandr Andoni](http://www.cs.columbia.edu/~andoni) at Columbia University.

The written C code for the project is in the [tabulation_project branch](https://github.com/Ana06/ruby/compare/master...Ana06:tabulation_project) of my fork of the Ruby project (MRI) in GitHub.


## Results

[benchmark_tabulation.rb](benchmark_tabulation.rb) benchmarks the insertion of 600000 elements (by hashing their 64 bits ids) in an empty hash 100 times.
Below are the times (in seconds) I got executing this code for different versions of the Ruby code:

- master (without Simple Tabulation): 29.68
- master with Linear Probing (without Simple Tabulation): 99.76
- master with Quadratic Probing (without Simple Tabulation): 29.97
- master with Simple Tabulation: 15.76
- master with Linear Probing and Simple Tabulation: 24.23
- master with Quadratic Probing and Simple Tabulation: 13.73

`master` refers to ruby 2.8.0dev:
(2020-05-07T16:22:38Z master 7ded8fd) [x86_64-linux].
I tried with 8 x Intel i5-8265U.

This prove the potential of Simple Tabulation to improve current Ruby implementation.


## License

Code published under GNU GENERAL PUBLIC LICENSE v3 (see [LICENSE](LICENSE)).

