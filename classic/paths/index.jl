using IterTools
using Printf

function Bn(n)
  B = (0, 1)
  axes = fill(B, n)

  return IterTools.product(axes...)
end

function adjacencyMatrixOf(edges)
  A, B, C, D, E, F, G, H, I, J, K, L = edges
  a, b, c, d, e, f, g, h, i, j, k, l = 1 .- edges

  A = [
    0 A 0 C 0 0 0 0 0;
    a 0 B 0 D 0 0 0 0;
    0 b 0 0 0 E 0 0 0;
    c 0 0 0 F 0 H 0 0;
    0 d 0 f 0 G 0 I 0;
    0 0 e 0 g 0 0 0 J;
    0 0 0 h 0 0 0 K 0;
    0 0 0 0 i 0 k 0 L;
    0 0 0 0 0 j 0 l 0;
  ]
end

function main()
  possible = 0
  impossible = 0
  edge_count = 12

  for permutation in Bn(edge_count)
    A = adjacencyMatrixOf(permutation)
    walk_counts = A
    length = 1

    while walk_counts[1, 9] == 0 && length < edge_count
      walk_counts = A * walk_counts
      length += 1
    end

    if walk_counts[1, 9] != 0
      possible += 1
    else
      impossible += 1
    end
  end

  @printf("There were %d out of %d walks possible\n", possible, impossible)
  @printf("This is roughly %%%f", 100 * possible/impossible)
end

main()
