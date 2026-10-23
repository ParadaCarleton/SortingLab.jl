@testset "non-Vector AbstractVector inputs" begin
    x = rand(Int, 1000)
    xv = view(copy(x), 1:2:1000)
    @test fsort(xv) == sort(collect(xv))
    @test issorted(fsort!(view(copy(x), 1:2:1000)))

    s = [randstring(rand(1:20)) for _ in 1:1000]
    sv = view(s, 1:2:1000)
    @test permute!(collect(sv), fsortperm(sv)) == sort(collect(sv))

    f = rand(Float64, 1000)
    fv = view(copy(f), 1:2:1000)
    @test SortingLab.uint_hist(fv) == SortingLab.uint_hist(collect(fv))
    sorted_values, permutation = SortingLab.sorttwo!(fv, collect(1:500))
    @test issorted(sorted_values)
    @test permute!(f[1:2:1000], permutation) == sorted_values
end
