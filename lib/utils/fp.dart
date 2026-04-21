/// Functional Programming Utilities
///
/// This file contains utility functions for functional programming patterns
/// including function composition, currying, and other FP concepts.

// ignore_for_file: dangling_library_doc_comments

/// Composes two functions: compose(f, g)(x) = f(g(x))
///
/// Example:
/// ```dart
/// final addOne = (int x) => x + 1;
/// final multiplyByTwo = (int x) => x * 2;
/// final addThenMultiply = compose(multiplyByTwo, addOne);
/// print(addThenMultiply(3)); // Output: 8 (3 + 1 = 4, 4 * 2 = 8)
/// ```
C Function(A) compose<A, B, C>(C Function(B) f, B Function(A) g) {
  return (A a) => f(g(a));
}

/// Composes three functions: compose3(f, g, h)(x) = f(g(h(x)))
///
/// Example:
/// ```dart
/// final addOne = (int x) => x + 1;
/// final multiplyByTwo = (int x) => x * 2;
/// final toString = (int x) => x.toString();
/// final transform = compose3(toString, multiplyByTwo, addOne);
/// print(transform(3)); // Output: "8"
/// ```
D Function(A) compose3<A, B, C, D>(
  D Function(C) f,
  C Function(B) g,
  B Function(A) h,
) {
  return (A a) => f(g(h(a)));
}

/// Composes four functions: compose4(f, g, h, i)(x) = f(g(h(i(x))))
E Function(A) compose4<A, B, C, D, E>(
  E Function(D) f,
  D Function(C) g,
  C Function(B) h,
  B Function(A) i,
) {
  return (A a) => f(g(h(i(a))));
}

/// Composes a list of functions from right to left
/// The rightmost function can accept multiple arguments,
/// the remaining functions must accept only one argument.
///
/// Example:
/// ```dart
/// final multiplyByTwo = (int x) => x * 2;
/// final toString = (int x) => x.toString();
///
/// final composed = composeList([toString, multiplyByTwo]);
/// final result = composed(5); // 5 * 2 = 10, then "10"
/// ```
dynamic composeList(List<dynamic Function(dynamic)> functions) {
  if (functions.isEmpty) {
    throw ArgumentError('Cannot compose an empty list of functions');
  }

  if (functions.length == 1) {
    return functions.first;
  }

  return functions.reduce((f, g) => (x) => f(g(x)));
}

/// Pipe function - applies functions from left to right (opposite of compose)
/// pipe(f, g)(x) = g(f(x))
///
/// Example:
/// ```dart
/// final addOne = (int x) => x + 1;
/// final multiplyByTwo = (int x) => x * 2;
/// final addThenMultiply = pipe(addOne, multiplyByTwo);
/// print(addThenMultiply(3)); // Output: 8 (3 + 1 = 4, 4 * 2 = 8)
/// ```
C Function(A) pipe<A, B, C>(B Function(A) f, C Function(B) g) {
  return (A a) => g(f(a));
}

/// Pipe three functions from left to right
D Function(A) pipe3<A, B, C, D>(
  B Function(A) f,
  C Function(B) g,
  D Function(C) h,
) {
  return (A a) => h(g(f(a)));
}

/// Pipe a list of functions from left to right
dynamic pipeList(List<dynamic Function(dynamic)> functions) {
  if (functions.isEmpty) {
    throw ArgumentError('Cannot pipe an empty list of functions');
  }

  if (functions.length == 1) {
    return functions.first;
  }

  return functions.reduce((f, g) => (x) => g(f(x)));
}

/// Curry a function with two parameters
///
/// Example:
/// ```dart
/// final add = (int a, int b) => a + b;
/// final curriedAdd = curry2(add);
/// final addFive = curriedAdd(5);
/// print(addFive(3)); // Output: 8
/// ```
C Function(B) Function(A) curry2<A, B, C>(C Function(A, B) f) {
  return (A a) => (B b) => f(a, b);
}

/// Curry a function with three parameters
D Function(C) Function(B) Function(A) curry3<A, B, C, D>(
    D Function(A, B, C) f) {
  return (A a) => (B b) => (C c) => f(a, b, c);
}

/// Uncurry a curried function with two parameters
C Function(A, B) uncurry2<A, B, C>(C Function(B) Function(A) f) {
  return (A a, B b) => f(a)(b);
}

/// Flip the arguments of a two-parameter function
///
/// Example:
/// ```dart
/// final subtract = (int a, int b) => a - b;
/// final flippedSubtract = flip(subtract);
/// print(subtract(10, 3));        // Output: 7
/// print(flippedSubtract(10, 3)); // Output: -7
/// ```
C Function(B, A) flip<A, B, C>(C Function(A, B) f) {
  return (B b, A a) => f(a, b);
}

/// Identity function - returns the input unchanged
///
/// Example:
/// ```dart
/// print(identity(42));    // Output: 42
/// print(identity("hello")); // Output: "hello"
/// ```
T identity<T>(T x) => x;

/// Constant function - returns a function that always returns the same value
///
/// Example:
/// ```dart
/// final alwaysFive = constant(5);
/// print(alwaysFive("anything")); // Output: 5
/// print(alwaysFive(42));         // Output: 5
/// ```
A Function(dynamic) constant<A>(A value) {
  return (_) => value;
}

/// Partial application - fixes some arguments of a function
///
/// Example:
/// ```dart
/// final greet = (String greeting, String name) => "$greeting, $name!";
/// final sayHello = partial1(greet, "Hello");
/// print(sayHello("World")); // Output: "Hello, World!"
/// ```
C Function(B) partial1<A, B, C>(C Function(A, B) f, A a) {
  return (B b) => f(a, b);
}

/// Memoization - caches function results
///
/// Example:
/// ```dart
/// int expensiveFunction(int n) {
///   print("Computing for $n");
///   return n * n;
/// }
///
/// final memoized = memoize(expensiveFunction);
/// print(memoized(5)); // Computing for 5, Output: 25
/// print(memoized(5)); // Output: 25 (cached, no computation)
/// ```
R Function(T) memoize<T, R>(R Function(T) f) {
  final cache = <T, R>{};
  return (T input) {
    if (cache.containsKey(input)) {
      return cache[input]!;
    }
    final result = f(input);
    cache[input] = result;
    return result;
  };
}

/// Function composition operator class for method chaining
///
/// Example:
/// ```dart
/// final addOne = (int x) => x + 1;
/// final multiplyByTwo = (int x) => x * 2;
/// final toString = (int x) => x.toString();
///
/// final result = FunctionComposer(addOne)
///     .then(multiplyByTwo)
///     .then(toString)
///     .call(3);
/// print(result); // Output: "8"
/// ```
class FunctionComposer<A, B> {
  final B Function(A) _function;

  const FunctionComposer(this._function);

  /// Compose with another function
  FunctionComposer<A, C> then<C>(C Function(B) f) {
    return FunctionComposer<A, C>((A a) => f(_function(a)));
  }

  /// Execute the composed function
  B call(A input) => _function(input);

  /// Get the underlying function
  B Function(A) get function => _function;
}

/// Extension methods for easier function composition
extension FunctionComposition<A, B> on B Function(A) {
  /// Compose this function with another: this.andThen(f)(x) = f(this(x))
  C Function(A) andThen<C>(C Function(B) f) {
    return pipe(this, f);
  }

  /// Compose another function with this: this.compose(f)(x) = this(f(x))
  B Function(C) composeBefore<C>(A Function(C) f) {
    return compose(this, f);
  }

  /// Create a memoized version of this function
  B Function(A) memoized() {
    return memoize(this);
  }
}
