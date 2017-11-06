using FstFiles
using FileIO
using DataFrames
using IterableTables
using Base.Test

@testset "FstFiles" begin

df = DataFrame(a=[1,2,3], b=[1.,2.,3.], c=["A", "B", "C"])

filename = joinpath(@__DIR__, "test.fst")

save(filename, df)

try

    fstfile = load(filename)

    df2 = DataFrame(fstfile)

    @test df == df2

finally
    rm(filename)
end

end
