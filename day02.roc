app "aoc-2022"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.1.1/zAoiC9xtQPHywYk350_b7ust04BmWLW00sjb9ZPtSQk.tar.br" }
    imports [pf.Stdout, pf.File, pf.Path, pf.Task]
    provides [main] to pf

main =
    inputTask =
        Task.await (File.readUtf8 (Path.fromStr "input/2022/day2.txt")) \input ->
            res1 = Num.toStr (part1 input)
            res2 = Num.toStr (part2 input)
            Stdout.line "Part 1: \(res1)\nPart 2: \(res2)"

    Task.mapFail inputTask \_ -> crash "could not read input file"

part1 : Str -> I64
part1 = \input ->
  rounds = Str.split (Str.trim input) "\n" 
  roundSum: Str -> I64
  roundSum = \line ->
    when (Str.split(Str.trim line) " ") is
      ["A", "X"] -> 3+1
      ["A", "Y"] -> 6+2
      ["A", "Z"] -> 0+3
      ["B", "X"] -> 0+1
      ["B", "Y"] -> 3+2
      ["B", "Z"] -> 6+3
      ["C", "X"] -> 6+1
      ["C", "Y"] -> 0+2
      ["C", "Z"] -> 3+3
      _ -> crash "line has invalid number of elements"
  List.sum( List.map rounds roundSum)
  

part2 : Str -> I64
part2 = \input ->
  rounds = Str.split (Str.trim input) "\n" 
  roundSum: Str -> I64
  roundSum = \line ->
    when (Str.split(Str.trim line) " ") is
      ["A", "X"] -> 0+3
      ["A", "Y"] -> 3+1
      ["A", "Z"] -> 6+2
      ["B", "X"] -> 0+1
      ["B", "Y"] -> 3+2
      ["B", "Z"] -> 6+3
      ["C", "X"] -> 0+2
      ["C", "Y"] -> 3+3
      ["C", "Z"] -> 6+1
      _ -> crash "line has invalid number of elements"
  List.sum( List.map rounds roundSum)
