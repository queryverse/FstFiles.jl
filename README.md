# FstFiles

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/davidanthoff/FstFiles.jl.svg?branch=master)](https://travis-ci.org/davidanthoff/FstFiles.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/vipuru7kaepv5f5o/branch/master?svg=true)](https://ci.appveyor.com/project/davidanthoff/fstfiles-jl/branch/master)
[![FstFiles](http://pkg.julialang.org/badges/FstFiles_0.6.svg)](http://pkg.julialang.org/?pkg=FstFiles)
[![codecov.io](http://codecov.io/github/davidanthoff/FstFiles.jl/coverage.svg?branch=master)](http://codecov.io/github/davidanthoff/FstFiles.jl?branch=master)

## Overview

This package provides load support for [fst](http://www.fstpackage.org/)
files under the [FileIO.jl](https://github.com/JuliaIO/FileIO.jl) package.

## Installation

Use ``Pkg.add("FstFiles")`` in Julia to install FstFiles and its dependencies.

## Usage

### Load a fst file

To read a fst file into a ``DataFrame``, use the following julia code:

````julia
using FileIO, FstFiles, DataFrames

df = DataFrame(load("data.fst"))
````

The call to ``load`` returns a ``struct`` that is an [IterableTable.jl](https://github.com/davidanthoff/IterableTables.jl), so it can be passed to any function that can handle iterable tables, i.e. all the sinks in [IterableTable.jl](https://github.com/davidanthoff/IterableTables.jl). Here are some examples of materializing a fst file into data structures that are not a ``DataFrame``:

````julia
using FileIO, FstFiles, DataTables, IndexedTables, TimeSeries, Temporal, Gadfly

# Load into a DataTable
dt = DataTable(load("data.fst"))

# Load into an IndexedTable
it = IndexedTable(load("data.fst"))

# Load into a TimeArray
ta = TimeArray(load("data.fst"))

# Load into a TS
ts = TS(load("data.fst"))

# Plot directly with Gadfly
plot(load("data.fst"), x=:a, y=:b, Geom.line)
````

### Save a fst file

The following code saves any iterable table as a fst file:
````julia
using FileIO, FstFiles

save("output.fst", it)
````
This will work as long as ``it`` is any of the types supported as sources in [IterableTables.jl](https://github.com/davidanthoff/IterableTables.jl).

### Using the pipe syntax

Both ``load`` and ``save`` also support the pipe syntax. For example, to load a fst file into a ``DataFrame``, one can use the following code:

````julia
using FileIO, FstFiles, DataFrame

df = load("data.fst") |> DataFrame
````

To save an iterable table, one can use the following form:

````julia
using FileIO, FstFiles, DataFrame

df = # Aquire a DataFrame somehow

df |> save("output.fst")
````

The pipe syntax is especially useful when combining it with [Query.jl](https://github.com/davidanthoff/Query.jl) queries, for example one can easily load a fst file, pipe it into a query, then pipe it to the ``save`` function to store the results in a new file.
