app "aoc-2022"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.1.1/zAoiC9xtQPHywYk350_b7ust04BmWLW00sjb9ZPtSQk.tar.br" }
    imports [pf.Stdout, pf.File, pf.Path, pf.Task]
    provides [main] to pf

main =
    inputTask =
        Task.await (File.readUtf8 (Path.fromStr "input/2022/day1.txt")) \input ->
            res1 = Num.toStr (part1 input)
            res2 = Num.toStr (part2 input)

            Stdout.line "Part 1: \(res1)\nPart 2: \(res2)"

    Task.mapFail inputTask \_ -> crash "could not read input file"

parseNum : Str -> I64
parseNum = \str ->
    when Str.toI64 (Str.trim str) is
        Ok num -> num
        Err _ -> crash "failed to parse number \(str)"

part1 : Str -> I64
part1 = \input ->
    elfes = Str.split (Str.trim input) "\n\n"
    elfesSum = List.map elfes \elf -> List.sum (List.map (Str.split elf "\n") parseNum)

    Result.withDefault (List.max elfesSum) 0

part2 : Str -> I64
part2 = \input ->
    elfes = Str.split (Str.trim input) "\n\n"
    elfesSum = List.map elfes \elf -> List.sum (List.map (Str.split elf "\n") parseNum)
    topThree = List.takeFirst (List.sortDesc elfesSum) 3

    List.sum topThree
