#import "../templates/exam-paper.typ" as exam-paper
#import "@preview/algo:0.3.4": algo, d, i

#show: exam-paper.template.with(
  title: "Design and Analysis of Computer Algorithms HW3",
  subtitle: "Solution Version",
  course: "Design and Analysis of Computer Algorithms",
  exam: "Homework 3",
  source: "HW3.pdf",
  year: "2026",
)

#let question = exam-paper.question
#let answer = exam-paper.reference-answer
#let remark = exam-paper.remark

// Q1
#question[
  Find a tight lower-bound class for the problem of finding two closest numbers among $n$ real numbers, $x_1, x_2, dots, x_n$. (Hint: Find a problem with a known lower-bound and use reduction.)
]


#answer[
  *Lower bound.* We reduce #emph[Element Uniqueness] to Closest Numbers.

  Define $delta := limits(min)_(i != j) |x_i - x_j|.$ Element Uniqueness asks whether all input numbers are distinct. The key observation is

  $
    "all " x_i " distinct" quad <==> quad delta > 0.
  $

  Equivalently, using the Vandermonde product,

  $
    V(x_1, dots, x_n) := product_(1 <= i < j <= n) (x_j - x_i),
  $

  we have

  $
    V != 0 quad <==> quad delta > 0.
  $

  Given an algorithm for Closest Numbers, run it on the same input. If it returns the closest pair $(x_i, x_j)$, compute $|x_i - x_j|$. This distance is $0$ iff the input contains duplicate numbers. Therefore Element Uniqueness can be solved with only $O(1)$ extra work after solving Closest Numbers.

  Since Element Uniqueness has lower bound $Omega(n lg n)$ in the comparison decision-tree model, Closest Numbers also has lower bound $Omega(n lg n). quad qed$
]



//Q2
#question[
  Recall the definition and property of binomial trees. Furthermore, we define the node at depth $k$ for a binomial tree $B_k$ is the handle of the $B_k$ tree. Prove the following characterization of an $B_k$ tree: Let $T$ be an $B_k$ tree with handle $v$. There are disjoint trees $T_0, T_1, dots, T_(k-1)$ , not containing $v$, with roots $r_0, r_1, dots, r_(k-1)$ , respectively such that
  #enum(numbering: "(1)")[
    $T_i$ is an $B_i$ tree, $0 <= i <= k-1$, and
  ][
    $T$ results from attaching $v$ to $r_0$, and $r_i$ to $r_(i+1)$, for $0 <= i < k-1$
  ]
]

#answer[
  #enum(numbering: "(1)")[
    *Base case $k=1$.* The tree $B_1$ consists of a root $r_0$ and one child $v$, and $v$ is the handle. Let $T_0$ be the one-node tree consisting of $r_0$. Then $T_0$ is a $B_0$ tree, and $T$ is obtained by attaching $v$ to $r_0$. Hence both (1) and (2) hold.

    *Inductive step.* Assume the statement is true for $B_(k-1)$. By the recursive definition of binomial trees, $B_k$ is obtained by linking two disjoint copies of $B_(k-1)$. The handle $v$ of $B_k$ must lie in the copy that is attached below the other one, because every node in the upper copy has depth at most $k-1$, while nodes in the lower copy have their depths increased by $1$, so its handle is now at depth $k$.

    Apply the induction hypothesis to that lower $B_(k-1)$ containing $v$. Then there exist disjoint trees $T_0, T_1, dots, T_(k-2)$, not containing $v$, such that $T_i$ is a $B_i$ tree. Let $T_(k-1)$ be the other (upper) copy of $B_(k-1)$. Since the two copies are disjoint and $v$ lies in the lower copy, $T_(k-1)$ does not contain $v$. Hence $T_0, T_1, dots, T_(k-1)$ are disjoint, do not contain $v$, and satisfy (1). $qed$
  ][
    For $k=1$, statement (2) was proved in the base case above.

    For $k > 1$, by the induction hypothesis, inside the lower copy we can build that $B_(k-1)$ by attaching $v$ to $r_0$, and $r_i$ to $r_(i+1)$ for $0 <= i < k-2$. Since the whole $B_k$ is formed by attaching the root $r_(k-2)$ of this lower $B_(k-1)$ to the root $r_(k-1)$ of the other $B_(k-1)$, we obtain exactly the chain

    $
      v -> r_0 -> r_1 -> dots -> r_(k-2) -> r_(k-1),
    $

    which is equivalent to attaching $v$ to $r_0$, and $r_i$ to $r_(i+1)$ for all $0 <= i < k-1$. Therefore (2) holds. Thus both statements are true for every $k$. $qed$
  ]
]

//Q3
#question[
  A sequence of $n$ operations is performed on a data structure. The $i$th operation costs $i$ if $i$ is an exact power of $2$, and $1$ otherwise. Please determine the amortized cost per operation using

  #enum(numbering: "(a)")[
    aggregate analysis
  ][
    accounting method of analysis
  ][
    potential method of analysis
  ]
]

#answer[
  #enum(numbering: "(a)")[
    Let $m = floor(lg n)$. The operations at power-of-$2$ indices are exactly

    $
      1, 2, 4, dots, 2^m.
    $

    Therefore the total cost of $n$ operations is

    $
      sum_(j=0)^m 2^j + (n-(m+1))
      = (2^(m+1)-1) + n - m - 1.
    $

    Since $2^m <= n < 2^(m+1)$, we have $2^(m+1) <= 2n$. Hence

    $
      sum_(i=1)^n c_i <= (2n-1) + n = 3n-1.
    $

    Thus the amortized cost per operation is at most $(3n-1)/n < 3$, which is $O(1)$.
  ][
    Charge an amortized cost of $3$ to every operation.

    For operation $i=1$, the actual cost is $1$, so the remaining $2$ units are stored as credit.

    If operation $i > 1$ is not a power of $2$, then its actual cost is $1$, so we place the remaining $2$ units as credit on the data structure.

    Now consider operation $i = 2^j$ for $j >= 1$. Since the previous power of $2$ is $2^(j-1)$, the operations

    $
      2^(j-1)+1, 2^(j-1)+2, dots, 2^j-1
    $

    are all non-powers of $2$. There are $2^(j-1)-1$ such operations, so they store

    $
      2(2^(j-1)-1) = 2^j - 2
    $

    units of credit. The actual cost of operation $2^j$ is $2^j$, and its own amortized charge covers $3$ units of this cost, so the remaining $2^j-3$ units must be drawn from stored credit. Since

    $
      2^j - 2 >= 2^j - 3,
    $

    the stored credit is sufficient. For $j=1$, this interval is empty, but then the actual cost is $2$ and the amortized charge $3$ already pays for it. Therefore the credit balance never becomes negative.

    Hence charging $3$ per operation pays for the entire sequence, so the amortized cost per operation is $3 = O(1)$.
  ][
    Let $D_i$ denote the data structure after the $i$th operation, and define the potential function

    $
      Phi(D_0) = 0, quad
      Phi(D_i) = 2(i - 2^(floor(lg i))) quad (i >= 1).
    $

    This potential is always nonnegative, because $i >= 2^(floor(lg i))$.

    The amortized cost of the $i$th operation is

    $
      hat(c_i) = c_i + Phi(D_i) - Phi(D_(i-1)).
    $

    If $i$ is not a power of $2$, then $floor(lg i) = floor(lg(i-1))$, so

    $
      Phi(D_i) - Phi(D_(i-1)) = 2.
    $

    Since $c_i = 1$, we get

    $
      hat(c_i) = 1 + 2 = 3.
    $

    If $i=1$, then

    $
      hat(c_1) = c_1 + Phi(D_1) - Phi(D_0) = 1 + 0 - 0 = 1.
    $

    If $i = 2^j$ for $j >= 1$, then

    $
      Phi(D_i) = 0
    $

    and

    $
      Phi(D_(i-1)) = 2((2^j - 1) - 2^(j-1)) = 2^j - 2.
    $

    Since $c_i = 2^j$, we have

    $
      hat(c_i) = 2^j + 0 - (2^j - 2) = 2.
    $

    Thus every operation has amortized cost at most $3$, so the amortized cost per operation is $O(1)$.
  ]
]

#remark[
  In CLRS, the three methods differ only in how we prove an upper bound on the total cost.

  For *aggregate analysis*, we do not design any extra bookkeeping. We simply compute or bound the total actual cost of a sequence of $n$ operations, and then divide by $n$.

  For *accounting method*, the design question is: how much should each operation be charged? We assign each operation an amortized charge, possibly larger than its actual cost, and store the extra amount as credit. Usually the cheap operations save credit to pay for a later expensive operation. The invariant is that the total credit is always nonnegative.

  For *potential method*, the design question is: what potential function should we choose? We choose $Phi(D_i) >= 0$ with $Phi(D_0)=0$, and define

  $
    hat(c_i) = c_i + Phi(D_i) - Phi(D_(i-1)).
  $

  Then

  $
    sum_(i=1)^n hat(c_i) = sum_(i=1)^n c_i + Phi(D_n) - Phi(D_0) >= sum_(i=1)^n c_i.
  $

  In general, the accounting and potential methods are equivalent at the theorem level. Once an amortized-cost scheme $hat(c_i)$ is fixed, its cumulative excess charge

  $
    sum_(t=1)^i (hat(c_t) - c_t)
  $

  can be viewed as a potential $Phi(D_i)$, and conversely any potential function induces amortized costs through $hat(c_i) = c_i + Phi(D_i) - Phi(D_(i-1))$.

  In this problem, part (b) and part (c) use different schemes. Part (b) uses the uniform charge $hat(c_i)=3$ for every operation. Part (c) uses the pattern: $3$ for non-powers of $2$, $2$ for powers $2^j$ with $j >= 1$, and $1$ for $i=1$.

  Thus

  $
    Phi(D_i) = 2(i - 2^(floor(lg i)))
  $

  should be interpreted only as the potential for the scheme in part (c), not as the total stored credit in part (b).

  The reason this $Phi$ works is that it has a sawtooth shape: right after an expensive operation at a power of $2$, it resets to $0$; between two consecutive powers of $2$, it grows linearly and accumulates just enough credit to cover the next expensive operation.

  Thus the usual pipeline is:

  #enum[
    identify which operations are expensive and how often they occur
  ][
    choose the proof framework: direct summation, credit scheme, or potential function
  ][
    if using accounting, decide how the cheap operations save credit for future expensive ones
  ][
    if using potential, design $Phi$ so that its increases on cheap operations offset the later drop at an expensive one
  ][
    verify the nonnegativity condition and conclude a uniform upper bound
  ]

]

//Q4
#question[
  Recall the basic operations related to a minimum priority queue include $mono("MINIMUM")$, $mono("INSERT")$, and $mono("DELETE-MIN")$. Suppose that we use a binary search tree $T$ to implement a minimum priority queue $P Q$. Please describe how the binary search tree $T$ can support these operations. Besides, we would like $P Q$ can provide the $mono("DECREASE-KEY")$ $(k, k^')$ operation which decreases the original key value $k$ to a new key value $k^'$, where $k^' < k$. For each approach, please provide the time and space complexity.
]

#answer[
  Assume the priority queue stores distinct keys. Let $h$ be the height of the binary search tree $T$.

  #let opbox(title, body) = block(
    inset: 0pt,
    above: 8pt,
    below: 8pt,
    radius: 6pt,
    stroke: 0.8pt + gray.darken(20%),
  )[
    #block(fill: luma(225), inset: 8pt)[
      #text(fill: black, weight: "bold")[#title]
    ]
    #block(inset: 10pt, fill: luma(248))[
      #body
    ]
  ]

  #opbox([$mono("MINIMUM")$], [
    *1. Basic idea.* Since an inorder traversal of a BST lists the keys in sorted order, the minimum key is exactly the leftmost node. Therefore we only need to start from the root and keep following left-child pointers until no further left child exists.

    *2. Algorithm.*

    #algo(
      title: "BST-Minimum",
      parameters: ("x",),
    )[
      while $"left"(x) != "NIL"$:#i\
      $x <- "left"(x)$#d\
      return $x$
    ]

    *3. Correctness.*

    *Loop invariant:*

    $
      min(T) #sym.in "subtree"(x).
    $

    *Initialization:* Initially, $x = "root"(T)$, so $"subtree"(x) = T$. Hence the invariant holds.

    *Maintenance:* Suppose the invariant holds at the start of an iteration and $"left"(x) != "NIL"$. By the BST property,

    $
      "key"("left"(x)) < "key"(x),
    $

    so

    $
      min("subtree"(x)) #sym.in "subtree"("left"(x)).
    $

    After setting $x <- "left"(x)$, the invariant is preserved.

    *Termination:* The loop terminates when $"left"(x) = "NIL"$. Then every key in $"subtree"("right"(x))$ exceeds $"key"(x)$. By the invariant, $min(T) #sym.in "subtree"(x)$, so $x = min(T)$. Therefore the algorithm returns the minimum node of $T$. $qed$

    *4. Time and extra-space complexity.* The algorithm follows at most one root-to-leaf path, whose length is at most $h$. Thus $mono("MINIMUM")$ takes $O(h)$ time and $O(1)$ extra space.
  ])

  #opbox([$mono("INSERT")(k)$], [
    *1. Basic idea.* To preserve the BST property, the new key must be placed exactly where a BST search for $k$ would terminate. Starting from the root, compare $k$ with the current key, go left if $k$ is smaller, and go right otherwise. When a $"NIL"$ child is reached, attach the new node there.

    *2. Algorithm.*

    #algo(
      title: "BST-Insert",
      parameters: ("T", "z"),
    )[
      let $y <- "NIL"$\
      let $x <- "root"(T)$\
      while $x != "NIL"$:#i\
      $y <- x$\
      if $"key"(z) < "key"(x)$:#i\
      $x <- "left"(x)$#d\
      else:#i\
      $x <- "right"(x)$#d#d\
      $"parent"(z) <- y$\
      if $y = "NIL"$:#i\
      $"root"(T) <- z$#d\
      else if $"key"(z) < "key"(y)$:#i\
      $"left"(y) <- z$#d\
      else:#i\
      $"right"(y) <- z$#d
    ]

    *3. Correctness.*

    *Loop invariant:* the correct BST position for $"key"(z)$ lies in $"subtree"(x)$, and $y = "parent"(x)$.

    *Initialization:* Initially, $x = "root"(T)$ and $y = "NIL"$. Hence the invariant holds.

    *Maintenance:* Suppose the invariant holds at the start of an iteration. By the BST property, exactly one of the two children of $x$ can contain the correct position for $"key"(z)$: if $"key"(z) < "key"(x)$, it must lie in the left subtree; otherwise it must lie in the right subtree. The algorithm moves $x$ to that child and sets $y <- "parent"(x)$, so the invariant is preserved.

    *Termination:* The loop terminates when $x = "NIL"$. Then $y$ is the direct parent of the insertion position. Attaching $z$ as the left child of $y$ when $"key"(z) < "key"(y)$, and as the right child otherwise, preserves BST order. If $T$ was empty, then $y = "NIL"$ and $z$ becomes the root. Therefore the resulting tree is a BST containing all old keys plus the new key $k$. $qed$

    *4. Time and extra-space complexity.* The algorithm examines only one search path from the root to a leaf position, whose length is at most $h$. Hence $mono("INSERT")$ takes $O(h)$ time and $O(1)$ extra space.
  ])

  #opbox([$mono("DELETE-MIN")$], [
    *1. Basic idea.* First find the minimum node. Since the minimum node has no left child, deleting it is simpler than general BST deletion: we only need to replace it by its right child.

    *2. Algorithm.*

    #algo(
      title: "BST-Delete-Min",
      parameters: ("T",),
    )[
      let $x <- "BST-Minimum"("root"(T))$\
      let $r <- "right"(x)$\
      if $r != "NIL"$:#i\
      $"parent"(r) <- "parent"(x)$#d\
      if $x = "root"(T)$:#i\
      $"root"(T) <- r$#d\
      else:#i\
      $"left"("parent"(x)) <- r$#d\
      return $x$
    ]

    *3. Correctness.* Let

    $
      x = min(T), quad p = "parent"(x).
    $

    Since $x$ is minimum, $"left"(x) = "NIL"$.

    *Case 1:* $x = "root"(T)$. Since $"parent"(x) = "NIL"$, if $r = "right"(x) != "NIL"$ then setting $"parent"(r) <- "parent"(x)$ makes $"parent"(r) = "NIL"$. The algorithm then sets $"root"(T) <- r$. The BST order on $"subtree"(r)$ is unchanged, so the remaining tree is still a BST.

    *Case 2:* $x != "root"(T)$. Then $x = "left"(p)$, so

    $
      "key"(x) < "key"(p).
    $

    By the BST property, every key in $"subtree"("right"(x))$ lies in the interval

    $
      ("key"(x), "key"(p)).
    $

    Therefore replacing $"left"(p)$ by $r = "right"(x)$ preserves BST order. If $r != "NIL"$, setting $"parent"(r) <- p$ preserves the parent pointers as well.

    In both cases, the remaining tree is a BST with $min(T)$ removed. Thus the algorithm correctly implements $mono("DELETE-MIN")$. $qed$

    *4. Time and extra-space complexity.* Finding the minimum takes $O(h)$ time. After that, the pointer updates take $O(1)$ time. Hence $mono("DELETE-MIN")$ takes $O(h)$ time and $O(1)$ extra space.
  ])

  #opbox([$mono("DECREASE-KEY")(k, k^')$], [
    *1. Basic idea.* We assume $k' < k$ and that the key $k$ is present in $T$. A first idea is to find the node $x$ of key $k$ and simply replace its key by $k^'$. However, this may violate the BST property. Some node in the left subtree of $x$ may now have key at least $k^'$, or some ancestor $a$ for which $x$ lies in the right subtree of $a$ may satisfy $k^' <= "key"(a)$. Thus $x$ may no longer belong to its current position.

    Once the key changes, the node must be moved to the position determined by the new key. The clean way to do this is to decompose the operation into two standard BST operations: delete the node of key $k$, and then insert a node of key $k^'$.

    *2. Algorithm.*

    #algo(
      title: "BST-Decrease-Key",
      parameters: ("T", "k", "k'"),
    )[
      let $x <- "BST-Search"("root"(T), k)$\
      $"BST-Delete"(T, x)$\
      let $"new" <- "new-node"(k')$\
      $"BST-Insert"(T, "new")$\
      return $"new"$
    ]

    *3. Correctness.* Let $S$ be the original key set of $T$. By the distinct-key assumption, $"BST-Search"$ returns the unique node $x$ with $"key"(x) = k$. After $"BST-Delete"(T, x)$, the tree is a BST with key set

    $
      S #sym.without {k}.
    $

    After $"BST-Insert"$ with key $k^'$, the tree is again a BST with key set

    $
      (S #sym.without {k}) #sym.union {k'}.
    $

    Therefore the final tree is exactly the result of decreasing key $k$ to $k^'$. $qed$

    *4. Time and extra-space complexity.* $"BST-Search"$, $"BST-Delete"$, and $"BST-Insert"$ each take $O(h)$ time on a BST of height $h$. Therefore

    $
      T_("DECREASE-KEY") = O(h) + O(h) + O(h) = O(h).
    $

    The algorithm uses only a constant number of pointers and variables in addition to the tree itself, so the extra space is $O(1)$.
  ])

  Thus, all four operations take $O(h)$ time and $O(1)$ extra space, where $h$ is the height of $T$. For an unbalanced BST of $n$ nodes, such as one created by inserting the keys in sorted order, the tree becomes a chain and its height is $n-1$, so each operation costs $O(n)$. If the BST maintains a balance condition, such as in a red-black tree or an AVL tree, then $h = O(log n)$, and all four operations run in $O(log n)$ time.
]
