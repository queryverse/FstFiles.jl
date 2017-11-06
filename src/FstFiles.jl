module FstFiles

using fstformat, TableTraits, IteratorInterfaceExtensions
import FileIO
import IterableTables

struct FstFile
    filename::String
    keywords
end

function load(f::FileIO.File{FileIO.format"Fst"}; keywords...)
    return FstFile(f.filename, keywords)
end

TableTraits.isiterable(x::FstFile) = true
TableTraits.isiterabletable(x::FstFile) = true

function IteratorInterfaceExtensions.getiterator(file::FstFile)
    df = fstformat.read(file.filename; file.keywords...)

    it = getiterator(df)

    return it
end

function save(f::FileIO.File{FileIO.format"Fst"}, data)
    isiterabletable(data) || error("Can't write this data to a fst file.")

    it = getiterator(data)

    fstformat.write(it, f.filename)
end


end # module
