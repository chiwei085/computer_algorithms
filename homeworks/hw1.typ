#import "../templates/exam-paper.typ" as exam-paper
#import "@preview/algo:0.3.4": algo, d, i

#show: exam-paper.template.with(
  title: "Design and Analysis of Computer Algorithms HW1",
  subtitle: "Solution Version",
  course: "Design and Analysis of Computer Algorithms",
  exam: "Homework 1",
  source: "HW1.pdf",
  year: "2026",
)

#let question = exam-paper.question
#let answer = exam-paper.reference-answer
#let remark = exam-paper.remark

// Q1
#question[
  We can express insertion sort as a recursive procedure. Please write the
  pseudo-code for insertion sort in a recursive fashion and provide the
  recurrence of the running time.
]

#answer[
  Sort the first $n - 1$ elements recursively, and then insert the last element
  into the correct position among those sorted elements.

  #algo(
    title: "Recursive-Insertion-Sort",
    parameters: ("A", "n"),
  )[
    if $n <= 1$:#i\
    return#d\
    \
    $"Recursive-Insertion-Sort"(A, n - 1)$\
    let $"key" <- A[n]$\
    let $i <- n - 1$\
    while $i >= 1$ and $A[i] > "key"$:#i\
    $A[i + 1] <- A[i]$\
    $i <- i - 1$#d\
    $A[i + 1] <- "key"$
  ]

  The insertion step may scan and shift $n - 1$ elements in the worst case.
  Since $Theta(n - 1) = Theta(n)$, the recurrence is

  $
    T(n) = cases(
      Theta(1) quad & n = 1,
      T(n - 1) + Theta(n) quad & n > 1.
    )
  $
]

// Q2
#question[
  Although merge sort runs in $Theta(n lg n)$ worst-case time and insertion sort
  runs in $Theta(n^2)$ worst-case time, the constant factors in insertion sort
  can make it faster in practice for small problem sizes on many machines. Thus,
  it makes sense to coarsen the leaves of the recursion by using insertion sort
  within merge sort when subproblems become sufficiently small. Consider a
  modification to merge sort in which $n / k$ sublists of length $k$ are sorted
  using insertion sort and then merged using the standard merging mechanism,
  where $k$ is a value to be determined.

  #enum(numbering: "(a)")[
    Show that insertion sort can sort the $n / k$ sublists, each of length $k$,
    in $Theta(n k)$ worst-case time.
  ][
    Show how to merge the sublists in $Theta(n lg(n / k))$ worst-case time.
  ][
    Given that the modified algorithm runs in
    $Theta(n k + n lg(n / k))$ worst-case time, what is the largest value of
    $k$ as a function of $n$ for which the modified algorithm has the same
    running time as standard merge sort, in terms of $Theta$-notation.
  ][
    How should we choose $k$ in practice?
  ]
]

#answer[
  #enum(numbering: "(a)")[
    Insertion sort takes $Theta(k^2)$ worst-case time on one sublist of length
    $k$. There are $n / k$ sublists, so the total time is

    $ frac(n, k) dot Theta(k^2) = Theta(n k). $
  ][
    After the sublists are sorted, treat them as the leaves of a merge-sort
    tree. At each merging level, every element is merged once, so each level
    costs $Theta(n)$. Since the number of sorted sublists is $n / k$, the number
    of merging levels is $ceil(lg(n / k))$. Hence the merging time is

    $
      Theta(n) dot ceil(lg(n / k)) = Theta(n lg(n / k)).
    $
  ][
    Standard merge sort runs in $Theta(n lg n)$. For the modified algorithm to
    remain $Theta(n lg n)$, the term $n k$ must not exceed $Theta(n lg n)$, so
    $k = O(lg n)$.

    Taking $k = Theta(lg n)$ gives $n k = Theta(n lg n)$. Also,

    $
      n lg(n / k)
      = n lg n - n lg k.
    $

    Since $lg k = Theta(lg lg n)$, we have
    $n lg k = Theta(n lg lg n) = o(n lg n)$, and hence
    $n lg(n / k) = Theta(n lg n)$. Therefore,

    $
      n k + n lg(n / k) = Theta(n lg n),
    $

    and the largest asymptotic choice is

    $ k = Theta(lg n). $
  ][
    In practice, choose $k$ by benchmarking on the target machine and
    implementation. The best value is usually a small machine-dependent
    constant affected by cache behavior, branch prediction, and function-call
    overhead, rather than a symbolic value chosen only from the asymptotic
    analysis.
  ]
]

// Q3
#question[
  Please verify the following statements. If it is true, please show it;
  otherwise, give an argument to show the incorrectness.

  #enum(numbering: "(a)")[
    $2^(n + 1) = O(2^n)$
  ][
    $2^(2 n) = O(2^n)$
  ]
]

#answer[
  #enum(numbering: "(a)")[
    True. Since

    $ 2^(n + 1) = 2 dot 2^n, $

    we can choose $c = 2$ and $n_0 = 1$. Then
    $2^(n + 1) <= c 2^n$ for all $n >= n_0$, so
    $2^(n + 1) = O(2^n)$.
  ][
    False. We have

    $ frac(2^(2 n), 2^n) = 2^n, $

    which grows without bound as $n -> infinity$. Thus no positive constant
    $c$ can satisfy $2^(2 n) <= c 2^n$ for all sufficiently large $n$.
    Therefore, $2^(2 n) != O(2^n)$.
  ]
]

// Q4
#question[
  We can extend the notation to the case of two parameters $n$ and $m$ that can
  go to infinity independently at different rates. For a given function
  $g(n, m)$, we denote by $O(g(n, m))$ the set of functions

  $
    O(g(n, m)) = { f(n, m) : \
      "there exist positive constants " c, n_0, " and " m_0 \
      "such that " 0 <= f(n, m) <= c dot g(n, m) \
      "for all " n >= n_0 " or " m >= m_0 }.
  $

  Give corresponding definitions for $Omega(g(n, m))$ and $Theta(g(n, m))$.
]

#answer[
  The corresponding lower-bound definition is

  $
    Omega(g(n, m)) = { f(n, m) : \
      "there exist positive constants " c, n_0, " and " m_0 \
      "such that " 0 <= c dot g(n, m) <= f(n, m) \
      "for all " n >= n_0 " or " m >= m_0 }.
  $

  The tight-bound definition is

  $
    Theta(g(n, m)) = { f(n, m) : \
      "there exist positive constants " c_1, c_2, n_0, " and " m_0 \
      "such that " 0 <= c_1 dot g(n, m) <= f(n, m) \
      <= c_2 dot g(n, m) \
      "for all " n >= n_0 " or " m >= m_0 }.
  $

  Equivalently,

  $ Theta(g(n, m)) = O(g(n, m)) inter Omega(g(n, m)). $
]

// Q5
#question[
  Design an algorithm for computing $floor(sqrt(n))$ for any positive integer
  $n$. Besides assignment and comparison, your algorithm may only use the four
  basic arithmetical operations. In your answer, you first describe the idea
  (approach) and then the pseudo-code. Furthermore, please give a short
  explanation to claim that your algorithm is correct and what the time
  complexity of your algorithm is.
]

#answer[
  *Idea.* Use binary search for the largest integer $x$ such that $x^2 <= n$.
  Since $floor(sqrt(n)) <= n$ for every positive integer $n$, the interval
  $[1, n]$ is a valid search range. This avoids using a square-root operation;
  the test only needs multiplication and comparison.

  #algo(
    title: "Floor-Sqrt",
    parameters: ("n",),
  )[
    let $"low" <- 1$\
    let $"high" <- n$\
    let $"ans" <- 0$\
    \
    while $"low" <= "high"$:#i\
    let $"mid" <- floor(("low" + "high") / 2)$\
    if $"mid" dot "mid" <= n$:#i\
    $"ans" <- "mid"$\
    $"low" <- "mid" + 1$#d\
    else:#i\
    $"high" <- "mid" - 1$#d#d\
    return $"ans"$
  ]

  *Correctness.* The algorithm keeps `ans` as the largest value found so far
  whose square is at most $n$. If $"mid"^2 <= n$, then $"mid"$ is a feasible
  candidate, and any larger feasible value must be to the right, so we set
  $"low" = "mid" + 1$. If $"mid"^2 > n$, then $"mid"$ and every larger value are
  too large, so we set $"high" = "mid" - 1$. Binary search therefore discards
  only impossible candidates. When the loop ends, `ans` is exactly the largest
  integer $x$ satisfying $x^2 <= n$, which is $floor(sqrt(n))$.

  Each iteration halves the search interval, so the time complexity is
  $Theta(lg n)$.
]
