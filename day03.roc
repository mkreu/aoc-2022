app "aoc-2022"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.1.1/zAoiC9xtQPHywYk350_b7ust04BmWLW00sjb9ZPtSQk.tar.br" }
    imports [pf.Stdout, pf.File, pf.Path, pf.Task]
    provides [main] to pf

main =
    inputTask =
        Task.await (File.readUtf8 (Path.fromStr "input/2022/day3.txt")) \input ->
            res1 = Num.toStr (part1 input)
            res2 = Num.toStr (part2 input)

            Stdout.line "Part 1: \(res1)\nPart 2: \(res2)"

    Task.mapFail inputTask \_ -> crash "could not read input file"

parseInput = \input ->
    List.map (Str.split (Str.trim input) "\n") lineToPrios

lineToPrios = \line ->
    List.map (Str.toScalars line) \i -> if i < 97 then i - 38 else i - 96

part1 : Str -> U32
part1 = \input ->
    rucksacks = parseInput input

    prios = List.map rucksacks \rucksack ->
        left = List.takeFirst rucksack (List.len rucksack // 2)
        right = List.takeLast rucksack (List.len rucksack // 2)

        Result.withDefault (List.findFirst left \i -> List.contains right i) 0

    List.sum prios

part2 : Str -> U32
part2 = \input ->
    rucksacks = parseInput input

    filterList = \list, mod ->
        List.map
            (
                List.keepIf (List.mapWithIndex list \el, idx -> { el, idx }) \rec ->
                    rec.idx % 3 == mod
            )
            \rec -> rec.el

    list0 = filterList rucksacks 0
    list1 = filterList rucksacks 1
    list2 = filterList rucksacks 2

    prios = List.map3 list0 list1 list2 \r0, r1, r2 ->
        Result.withDefault (List.findFirst r0 \i -> List.contains r1 i && List.contains r2 i) 0

    List.sum prios
