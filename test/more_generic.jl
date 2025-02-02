B = Array{Int}(undef, 2, 3, 4, 5, 6)

n = 0
for i5 in 1:6, i4 in 1:5, i3 in 1:4
    global n += 1
    B[.., i3, i4, i5] .= n
end
# B => 2×3×4×5×6 Array{Int64,5}:
# [:, :, 1, 1, 1] =
#  1  1  1
#  1  1  1
#
# [:, :, 2, 1, 1] =
#  2  2  2
#  2  2  2
#
#  :
#
# [:, :, 4, 5, 6] =
#  120  120  120
#  120  120  120

@test B[1, 1, ..] == B[1, 1, :, :, :] == reshape(1:120, 4, 5, 6)
@test B[1, 1, .., 1] == B[1, 1, :, :, 1] == reshape(1:20, 4, 5)

C = Array{Int}(undef, 2, 3, 4, 5, 6)

n = 0
for i3 in 1:4, i2 in 1:3, i1 in 1:2
    global n += 1
    C[i1, i2, i3, ..] .= n
end
# C => 2×3×4×5×6 Array{Int64,5}:
# [:, :, 1, 1, 1] =
#  1  3  5
#  2  4  6
#
# [:, :, 2, 1, 1] =
#  7   9  11
#  8  10  12
#
#  :
#
# [:, :, 4, 5, 6] =
#  19  21  23
#  20  22  24

@test C[.., 1, 1] == C[:, :, :, 1, 1] == reshape(1:24, 2, 3, 4)
@test C[1, .., 1, 1] == C[1, :, :, 1, 1] == reshape(1:2:24, 3, 4)

D = ones(Int, 1, 2, 3, 4)
D[1, .., 2] .= 2
@test D == [i1 == 1 && i4 == 2 ? 2 : 1 for i1 in 1:1, i2 in 1:2, i3 in 1:3, i4 in 1:4]
