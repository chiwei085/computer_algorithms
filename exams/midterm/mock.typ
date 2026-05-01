#import "../../templates/exam-paper.typ" as exam-paper
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: parallelogram, pill
#import "@preview/algo:0.3.4": algo, comment, d, i

#show: exam-paper.template.with(
  title: "Design and Analysis of Computer Algorithms Mock Midterm",
  subtitle: "Solution Version",
  course: "Design and Analysis of Computer Algorithms",
  exam: "Midterm",
  source: "Sample Midterm Exam",
  year: "2026",
  note: "Time: 120 minutes   Total: 120 pts",
)

#let question = exam-paper.question
#let answer = exam-paper.reference-answer
#let remark = exam-paper.remark

// Q1
#question[
  (20 pts)

  In all of the recurrences shown below, it is assumed that $T(n) = d$ for
  some constant $d$ for $n <= 2$. State, using the asymptotic notation, the
  solution to each of the recurrences shown below. Just state the answers
  and do not need to justify them.

  #enum(numbering: "(1)")[
    $T(n) = T(n - 1) + 1 / n$
  ][
    $T(n) = 2 T(n / 2) + frac(n, log n)$
  ][
    $T(n) = 4 T(n / 2) + n^2 sqrt(n)$
  ][
    $T(n) = 2 T(n / 4) + sqrt(n)$
  ]
]

#answer[
  #enum(numbering: "(1)")[
    $T(n) = Theta(log n)$
  ][
    $T(n) = Theta(n log log n)$
  ][
    $T(n) = Theta(n^(5 / 2))$
  ][
    $T(n) = Theta(sqrt(n) log n)$
  ]
]

#remark[
  *Master Theorem。* 對 $T(n) = a T(frac(n, b)) + f(n)$，$a >= 1, b > 1$：
  $
    T(n) = cases(
      Theta(n^(log_b a)) & "if " f(n) = O(n^(log_b a - epsilon)) " for some " epsilon > 0,
      Theta(n^(log_b a) log n) & "if " f(n) = Theta(n^(log_b a)),
      Theta(f(n)) & "if " f(n) = Omega(n^(log_b a + epsilon)) " for some " epsilon > 0 " and regularity holds",
    )
  $

  *Extended Master Theorem (Case 2 推廣)。* 若 $f(n) = Theta(n^(log_b a) log^k n)$：
  $
    T(n) = cases(
      Theta(n^(log_b a) log^(k + 1) n) & "if " k > -1,
      Theta(n^(log_b a) log log n) & "if " k = -1,
      Theta(n^(log_b a)) & "if " k < -1,
    )
  $

  各小題：

  #enum(numbering: "(1)")[
    展開得
    $
      T(n) = limits(sum)_(k=1)^n frac(1, k) = H_n = Theta(log n).
    $
  ][
    *Extended Master Theorem，$k = -1$。* $a = 2, b = 2$，故 $n^(log_b a) = n$。
    $f(n) = frac(n, log n) = n dot log^(-1) n$，符合 $f(n) = Theta(n^(log_b a) dot log^k n)$ 且 $k = -1$，故
    $T(n) = Theta(n log log n)$。
  ][
    *Master Theorem Case 3。* $a = 4, b = 2$，$n^(log_b a) = n^2$。
    $f(n) = n^(5 / 2) = Omega(n^(2 + epsilon))$ (取 $epsilon = 1 / 2$)。
    正規性驗證：
    $ a dot f(frac(n, b)) = 4 dot (n / 2)^(5 / 2) = frac(n^(5 / 2), sqrt(2)) <= frac(1, sqrt(2)) f(n). $
    故 $T(n) = Theta(n^(5 / 2))$。
  ][
    *Master Theorem Case 2 (標準)。* $a = 2, b = 4$，
    $n^(log_4 2) = n^(1 / 2) = f(n)$，兩者相等 ($k = 0$)，故
    $T(n) = Theta(sqrt(n) log n)$。
  ]
]

// Q2
#question[
  (30 pts)

  Please consider the following equalities. Mark by True or False each of the
  following statements. You don't need to prove it.

  #enum(numbering: "(1)")[
    $limits(sum)_(i=1)^n sqrt(i) = O(n^(3 / 2))$
  ][
    $n^n = O(2^n)$
  ][
    $n^2 / log n = Theta(n^2)$
  ][
    $33 n^3 + 4 n^2 = Omega(n^2)$
  ][
    $f(n) = Theta(g(n)) and (forall n in NN^+, f(n) >= 1 and g(n) >= 1)
    ==> lg f(n) = Theta(lg g(n))$
  ][
    $limits(sum)_(i=1)^n i lg i = Theta(n^2 lg n)$
  ]
]

#answer[
  #enum(numbering: "(1)")[
    True.
  ][
    False.
  ][
    False.
  ][
    True.
  ][
    True.
  ][
    True.
  ]
]

#remark[
  *比值極限判斷漸近關係。*
  設 $f, g : NN -> RR_(>0)$，且

  $
    L = lim_(n -> infinity) frac(f(n), g(n))
  $

  存在。則可依 $L$ 的值判斷：

  - *$0 < L < infinity => f(n) = Theta(g(n))$。*
    由極限定義，存在 $N$ 使得 $n > N$ 時

    $
      lr(|frac(f(n), g(n)) - L|) < frac(L, 2),
    $

    因此

    $
      frac(L, 2) g(n) < f(n) < frac(3L, 2) g(n).
    $

    取 $c_1 = L / 2$、$c_2 = 3L / 2$、$n_0 = N$，符合 $Theta$ 的定義。

  - *$L = 0 => f(n) = o(g(n))$，從而 $f(n) = O(g(n))$。*
    由極限定義，對任意 $epsilon > 0$，存在 $N$ 使得 $n > N$ 時

    $
      frac(f(n), g(n)) < epsilon.
    $

    這正是 $f(n) = o(g(n))$ 的定義。由於小 $o$ 蘊含大 $O$，
    且大 $O$ 只要求漸近上界存在、不要求 tight，因此也有 $f(n) = O(g(n))$。

  - *$L = infinity => f(n) = omega(g(n))$，從而 $f(n) = Omega(g(n))$。*
    對任意 $M > 0$，存在 $N$ 使得 $n > N$ 時

    $
      frac(f(n), g(n)) > M.
    $

    這正是 $f(n) = omega(g(n))$ 的定義。由於小 $omega$ 蘊含大 $Omega$，
    且大 $Omega$ 只要求漸近下界存在、不要求 tight，因此也有 $f(n) = Omega(g(n))$。

  若比值極限不存在 (如 $frac(f(n), g(n))$ 振盪)，上述規則不適用，
  需回到 $O, Omega, Theta$ 的常數界定義逐一驗證。

  #enum(numbering: "(1)")[
    用積分估算：
    $ limits(sum)_(i=1)^n sqrt(i) approx integral_1^n sqrt(x) dif x = [frac(2, 3) x^(3 / 2)]_1^n = Theta(n^(3 / 2)). $
    故為 $O(n^(3 / 2))$。
  ][
    用比值的 limit 檢查上界：
    $ lim_(n -> infinity) frac(n^n, 2^n) = lim_(n -> infinity) (frac(n, 2))^n = infinity. $
    若 $n^n = O(2^n)$，依定義必須存在正常數 $c$ 使 $n^n <= c dot 2^n$
    對充分大的 $n$ 成立，也就是比值 $n^n / 2^n$ 必須最終被常數上界住。
    但上述 limit 為 $infinity$，所以不是 $O(2^n)$。
  ][
    用比值的 limit 檢查下界：
    $ lim_(n -> infinity) frac(frac(n^2, log n), n^2) = lim_(n -> infinity) frac(1, log n) = 0. $
    因此 $n^2 / log n = o(n^2)$。若 $n^2 / log n = Theta(n^2)$，依定義必須存在正常數
    $c$ 使 $n^2 / log n >= c dot n^2$ 對充分大的 $n$ 成立，但上述 limit 為 $0$，
    所以 $Omega(n^2)$ 不成立，故不是 $Theta(n^2)$。
  ][
    $33n^3 + 4n^2 >= n^2$ 對所有 $n >= 1$ 成立，取 $c = 1, n_0 = 1$ 即符合 $Omega(n^2)$ 定義。 (事實上為 $Omega(n^3)$，$Omega$ 只是下界。)
  ][
    由 $f(n) = Theta(g(n))$ 得 $c_1 g(n) <= f(n) <= c_2 g(n)$，取對數：
    $ lg c_1 + lg g(n) <= lg f(n) <= lg c_2 + lg g(n). $
    因 $f, g >= 1$ 保證對數有意義且非負。當 $g(n) -> infinity$ 時，常數項 $lg c_1, lg c_2$ 可被吸收；若 $f, g = Theta(1)$，則 $lg f, lg g$ 均為有界正常數，$Theta$ 關係仍成立。
  ][
    積分估算：
    $ limits(sum)_(i=1)^n i lg i approx integral_1^n x lg x dif x = Theta(n^2 lg n). $
    (精確計算：$[frac(x^2 lg x, 2) - frac(x^2, 2 ln 2)]_1^n approx frac(n^2 lg n, 2)$。)

	    另一思路是用夾擠：
	    上界方面，對所有 $1 <= i <= n$，有 $lg i <= lg n$，所以

	    $
	      limits(sum)_(i=1)^n i lg i
	      <= limits(sum)_(i=1)^n i lg n
	      = lg n dot frac(n(n + 1), 2)
	      = O(n^2 lg n).
	    $

	    下界方面，只看後半段即可。當 $i >= ceil(n / 2)$ 時，
	    $i >= n / 2$ 且 $lg i >= lg(n / 2)$，因此

	    $
	      limits(sum)_(i=1)^n i lg i
	      >= limits(sum)_(i=ceil(n / 2))^n i lg i
	      >= limits(sum)_(i=ceil(n / 2))^n frac(n, 2) lg(frac(n, 2)).
	    $

	    後半段至少有 $n / 2$ 項，所以

	    $
	      limits(sum)_(i=ceil(n / 2))^n frac(n, 2) lg(frac(n, 2))
	      >= frac(n, 2) dot frac(n, 2) dot (lg n - 1)
	      = Omega(n^2 lg n).
	    $

	    由上下界可得

	    $
	      limits(sum)_(i=1)^n i lg i = Theta(n^2 lg n).
	    $
	  ]
	]

// Q3
#question[
  (20 pts)

  Suppose $A$ is a problem with a well-known lower bound $Omega(T(n))$ and $B$
  is a problem of which the lower bound is unknown. However, we can find a
  $O(n)$-time reduction from $A$ to $B$. Mark by True or False each of the
  following statements:

  #enum(numbering: "(1)")[
    If $B$ can be solved in $O(n^2)$, then $A$ can be solved in $O(n^2)$.
  ][
    If $A$ can be solved in $O(n^2)$, then $B$ can be solved in $O(n^2)$.
  ][
    If $T(n) = log n$, then $B$ has an $Omega(log n)$ time lower bound.
  ][
    If $B$ has an $Omega(log n)$ time lower bound, then $T(n) = log n$.
  ]
]

#answer[
  Since $A$ can be reduced to $B$ in $O(n)$ time:

  #enum(numbering: "(1)")[
    True.
  ][
    False.
  ][
    False.
  ][
    False.
  ]
]

#remark[
  Reduction 的核心邏輯：$A$ 可在 $O(n)$ 內 reduce 到 $B$，代表「任何能解 $B$ 的演算法，都能在 $O(n + t_B(n))$ 內解 $A$」。這讓我們可以把 $B$ 的*上界*傳給 $A$，或把 $A$ 的*下界*傳給 $B$，但方向和條件各有限制：

  #enum(numbering: "(1)")[
    *True。* $B$ 可在 $O(n^2)$ 解，則 $A$ 可在 $O(n + n^2) = O(n^2)$ 解。✓
  ][
    *False。* Reduction 方向是 $A -> B$，無法反推 $B$ 的上界。得知 $A$ 容易不代表 $B$ 容易。
  ][
    *False。* 下界傳遞的前提是 reduction 的代價*小於* $A$ 的下界，才能讓剩餘代價由 $B$ 承擔。此處 reduction 需要 $O(n)$，而 $A$ 的下界僅 $Omega(log n)$，$O(n) >> Omega(log n)$，reduction 本身已「覆蓋」整個下界，無法對 $B$ 推出任何非平凡結論。反例：若 $B$ 可在 $O(1)$ 解決，$A$ 仍可在 $O(n)$ 解，不違反 $A$ 的 $Omega(log n)$ 下界，故 $B$ 不需要有 $Omega(log n)$ 下界。
  ][
    *False。* $B$ 的下界是關於 $B$ 本身的性質，無法反推 $A$ 的下界 $T(n)$ 為何。
  ]
]

// Q4
#question[
  (15 pts)

  Suppose that we would like to construct a Max-heap $H$ using bottom-up fashion
  statically and all the keys are in a complete binary tree $T$ represented by
  an array in sequence:

  $7, 16, 42, 21, 37, 53, 18$

  #enum(numbering: "(1)")[
    (5 pts) Which key is the parent of key 37 in the given complete binary tree
    $T$?
  ][
    (5 pts) Mark by True or False the following statement:

    For key 37 in $H$, the key of its left child is smaller than the key of its
    right child.
  ][
    (5 pts) What is the time complexity of such a construction on $n$ keys?
  ]
]

#answer[
  #enum(numbering: "(1)")[
    The parent of key 37 in the original complete binary tree $T$ is 16.
  ][
    The bottom-up max-heap construction can produce
    $[53, 37, 42, 21, 16, 7, 18]$.
    In this heap, key 37 has left child 21 and right child 16, so the statement
    $21 < 16$ is false.
  ][
    The time complexity of bottom-up heap construction on $n$ keys is $Theta(n)$.
  ]
]

#remark[
  #enum(numbering: "(1)")[
    陣列表示法中，位置 $i$ 的 parent 在位置 $floor(i / 2)$。37 在位置 5，$floor(5 / 2) = 2$，位置 2 的 key 為 16。
  ][
    Bottom-up heapify 從最後一個 internal node (位置 $floor(n / 2) = 3$) 往前處理：

    #table(
      columns: (auto, 1fr),
      align: (center, left),
      [*步驟*], [*陣列狀態*],
      [初始], [$[7, 16, 42, 21, 37, 53, 18]$],
      [Heapify(3): 42 $<$ 53，swap], [$[7, 16, 53, 21, 37, 42, 18]$],
      [Heapify(2): 16 $<$ 37，swap], [$[7, 37, 53, 21, 16, 42, 18]$],
      [Heapify(1): 7 $<$ 53，swap], [$[53, 37, 7, 21, 16, 42, 18]$],
      [繼續 sift-down(3): 7 $<$ 42，swap], [$[53, 37, 42, 21, 16, 7, 18]$],
    )

    最終 37 在位置 2，左子 (位置 4) 為 21，右子 (位置 5) 為 16，$21 > 16$，故 False。
  ][
    直覺上看似 $O(n log n)$，但精確分析：高度 $h$ 的節點有 $O(n / 2^h)$ 個，每個 heapify 代價 $O(h)$，總代價
    $
      limits(sum)_(h=0)^(floor(log n)) O(n / 2^h) dot h
      = O(n limits(sum)_(h=0)^infinity h / 2^h) = O(n).
    $
  ]
]

// Q5
#question[
  (15 pts)

  Suppose the following is a divide-and-conquer algorithm for some problem:

  "Make the input of size $n$ into 3 subproblems of sizes $n / 2$, $n / 4$,
  $n / 8$, respectively with $O(n)$ time; Recursively call on these subproblems;
  and then combine the results in $O(n)$ time. The recursive call returns when
  the problems become of size 1 and the time in this case is constant."

  #enum(numbering: "(a)")[
    (5 pts) Let $T(n)$ denote the worst-case running time of this approach on
    the problem of size $n$. Please express the running time with the recurrence.
  ][
    (5 pts) Use a recursion tree to derive the asymptotic bound of $T(n)$ with
    Big Theta ($Theta$) notation.
  ][
    (5 pts) Please use the substitution method to verify the asymptotic bound
    you derive in (b).

    (Note: $T(n) = Theta(n) <==> T(n) = O(n)$ and $T(n) = Omega(n)$.)
  ]
]

#answer[
  #enum(numbering: "(a)")[
    The recurrence is

    $T(n) = T(n / 2) + T(n / 4) + T(n / 8) + c n$,

    where $c > 0$ and $T(1) = Theta(1)$.
  ][
    In the recursion tree, the total subproblem size at level 1 is

    $n / 2 + n / 4 + n / 8 = 7 n / 8$.

    Thus the work at level $i$ is at most $c n (7 / 8)^i$, and the total work is

    $c n (1 + 7 / 8 + (7 / 8)^2 + dots)$.

    This is a convergent geometric series, so $T(n) = Theta(n)$.
  ][
    First prove $O(n)$. Assume for every smaller $m < n$ that $T(m) <= C m$.
    Then

    $T(n) <= C(n / 2) + C(n / 4) + C(n / 8) + c n
    = C(7 n / 8) + c n$.

    If $C >= 8 c$, then $C(7 n / 8) + c n <= C n$, so $T(n) = O(n)$.

    For the lower bound,

    $T(n) = T(n / 2) + T(n / 4) + T(n / 8) + c n >= c n$,

    so $T(n) = Omega(n)$. Therefore, $T(n) = Theta(n)$.
  ]
]

#remark[
  *思路引導*

  #enum(numbering: "(a)")[
    注意「$O(n)$ to split」與「$O(n)$ to combine」合計仍是 $O(n)$，不需要相加兩次；三個子問題大小直接讀題目即可。
  ][
    Recursion tree 的重點在於*每一層的總工作量*，而非個別節點。三個子問題大小分別為 $n / 2, n / 4, n / 8$，同一層總和為 $7 n / 8$，形成公比 $7 / 8 < 1$ 的等比級數，故整棵樹的工作量收斂為 $O(n)$。注意此遞迴樹不是平衡的 (各子樹深度不同)，只需估算上界即可得 $Theta$，因為 $T(n) >= c n$ 顯然成立。
  ][
    Substitution 要明確寫出：猜測 $T(n) <= C n$，代入遞迴式，化簡後決定 $C$ 的條件 ($C >= 8 c$)，再補 $Omega(n)$ 的下界。下界的論證只需一行：$T(n) >= c n$ 因為題目本身的 $c n$ 項已是下界。
  ]
]

// Q6
#question[
  (10 pts)

  A sequence $chevron.l a_0, a_1, ..., a_(n - 1) chevron.r$ is called unimodal if
  there exists a $t$ such that
  $chevron.l a_t, a_(t + 1), ..., a_(t + n - 1) chevron.r$ strictly increases and
  then strictly decreases, where subscript calculations are performed modulo
  $n$.

  Thus, if the sequence $chevron.l a_0, a_1, ..., a_(n - 1) chevron.r$ is rotated to
  the left $t$ positions, it strictly increases to a maximum and then strictly
  decreases.

  Examples of unimodal sequences are:

  #list[
    $chevron.l 3, 5, 7, 10, 15, 8, 6, 4 chevron.r$
  ][
    $chevron.l 6, 3, 1, 5, 8, 10, 12, 15, 13, 11, 7 chevron.r$
  ]

  Design an efficient algorithm to find the maximum value in a unimodal
  sequence.

  (Hint: Use divide-and-conquer.)
]

#answer[
  Use a divide-and-conquer binary search. For a midpoint $"mid"$, define

  $"prev" = ("mid" - 1 + n) op("mod") n, quad "next" = ("mid" + 1) op("mod") n$.

  If $a["mid"]$ is greater than both neighbors, it is the maximum. If
  $a["mid"] < a["next"]$, the sequence is still increasing locally, so the maximum
  is in the right half. Otherwise, the maximum is in the left half.

  #algo(
    title: "Find-Max",
    parameters: ("a", "l", "r"),
  )[
    let $n <- |a|$\
    while $l <= r$:#i\
    let $"mid" <- floor((l + r) / 2)$\
    let $"prev" <- ("mid" - 1 + n) op("mod") n$\
    let $"next" <- ("mid" + 1) op("mod") n$\
    \
    if $a["mid"] > a["prev"]$ and $a["mid"] > a["next"]$:#i\
    return $a["mid"]$#d\
    else if $a["mid"] < a["next"]$:#i\
    $l <- "mid" + 1$#d\
    else:#i\
    $r <- "mid" - 1$#d#d
  ]

  Each iteration discards half of the search range, so the running time is
  $Theta(log n)$.
]

#remark[
  *思路引導*

  Binary search 能成立，依賴一個關鍵不變量：*比較 $a["mid"]$ 與相鄰元素，可以確定最大值在哪一側。*

  #enum(numbering: "(1)")[
    若 $a["mid"] > a["prev"]$ 且 $a["mid"] > a["next"]$：$a["mid"]$ 同時比左右鄰居大，符合局部最大值定義，即為全局最大值 (unimodal 只有一個峰)。
  ][
    若 $a["mid"] < a["next"]$：目前在上坡段，峰在右側，搜尋範圍縮至 $["mid" + 1, r]$。
  ][
    否則 ($a["mid"] > a["next"]$，且未滿足第一條)：目前在下坡段，峰在左側，搜尋範圍縮至 $[l, "mid" - 1]$。
  ]

  每次迭代搜尋範圍減半，故時間複雜度為 $Theta(log n)$。

  注意 prev/next 使用 $op("mod") n$ 處理環狀邊界，但 $l, r$ 仍是線性索引——這是因為 unimodal 的定義保證：不論從哪個位置開始，上述判斷都能正確指出峰的方向。
]

// Q7
#question[
  (10 pts)

  Show that to find the second largest one of a list of $n$ numbers, we need at least $n - 2 + ceil(log n)$ comparisons.
]

#answer[

  *Claim.* Any comparison-based algorithm finding the second largest of
  $n$ distinct elements requires at least $n - 2 + ceil(log n)$ comparisons in
  the worst case.

  *Proof.* Let $w$ be the maximum, $S(w)$ the set of elements directly defeated
  by $w$, and $t = |S(w)|$. Partition all comparisons into those involving $w$
  and those not involving $w$.

  *Comparisons involving $w$: at least $t$ and $t >= ceil(log n)$.*
  Each such comparison adds one element to $S(w)$, so the count is exactly $t$.
  To bound $t$: assign each element weight $1$ initially; when $w$ beats an
  element, merge weights. The adversary always makes the heavier element win, so
  $w$'s weight at most doubles per comparison. Since $w$ must accumulate weight $n$,

  $ n <= 2^t ==> t >= ceil(log n). $

  *Comparisons not involving $w$: at least $n - 2$.*
  The second largest must lie in $S(w)$: any element never directly beaten by $w$
  either lost to some non-$w$ element (hence provably not second-largest) or was
  never shown inferior to $w$ at all. Therefore the algorithm must identify
  $op("max") S(w)$. Two disjoint demands are placed on comparisons not involving $w$:

  - *Identify $op("max") S(w)$*: finding the best among $t$ candidates requires
    $>= t - 1$ comparisons, all within $S(w)$.
  - *Eliminate the $n - 1 - t$ remaining elements* (those beaten by non-$w$ elements):
    each must lose at least once in a comparison involving at least one non-$S(w)$
    element, giving $>= n - 1 - t$ such comparisons.

  These two sets of comparisons are disjoint—the first involves only $S(w)$
  elements, the second involves at least one element outside $S(w)$—so

  $ "comparisons not involving" w >= (t - 1) + (n - 1 - t) = n - 2. $

  *Total:* $t + (n - 2) >= ceil(log n) + n - 2 = n - 2 + ceil(log n)$. $square.filled$
]

#remark[
  *思路引導*

  *整體框架*：以「是否涉及 $w$」為主要分割，對兩側各給下界再相加。

  #enum(numbering: "(1)")[
    *涉及 $w$ 的比較* (恰好 $t = |S(w)|$ 次)：用 adversary argument 得 $t >= ceil(log n)$。對手策略：每次讓「積分較高」者獲勝並合併積分，積分代表曾擊敗 (含間接) 的元素數。$w$ 最終積分須達 $n$，每勝至多翻倍，故 $t >= ceil(log n)$。
  ][
    *不涉及 $w$ 的比較* (至少 $n - 2$ 次)：這批比較同時肩負兩個獨立任務：

    #enum(numbering: "(i)")[
      在 $S(w)$ 內找出最大值：$t$ 個候選需要 $t - 1$ 次；
    ][
      淘汰 $n - 1 - t$ 個「其他」元素：各需至少輸一次。
    ]

    兩個任務涉及的元素集合不重疊 (前者純 $S(w)$，後者含 non-$S(w)$ 元素)，故下界直接相加得 $n - 2$。
  ]

  *合計* $>= ceil(log n) + (n - 2) = n - 2 + ceil(log n)$。
]
