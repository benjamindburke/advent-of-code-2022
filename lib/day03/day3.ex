defmodule AdventOfCode.Day3 do
  def read_input() do
    (__DIR__ <> "/input.txt")
    |> File.read!()
    |> String.split(~r/(\r?\n)/, trim: true)
  end

  def priority(c) when c in ?a..?z, do: c - ?a + 1
  def priority(c) when c in ?A..?Z, do: c - ?A + 27

  def count(list) do
    list
    |> Stream.map(fn v -> Enum.reduce(v, &MapSet.intersection/2) end)
    |> Enum.flat_map(&Enum.to_list/1)
    |> Stream.map(&priority/1)
    |> Enum.sum()
  end

  def get_compartment_duplicates(line) do
    size = byte_size(line)
    half = div(size, 2)

    {b1, b2} = String.split_at(line, half)

    [MapSet.new(to_charlist(b1)), MapSet.new(to_charlist(b2))]
  end

  def solution1 do
    read_input()
    |> Stream.map(&get_compartment_duplicates/1)
    |> count()
  end

  def solution2 do
    read_input()
    |> Stream.map(&MapSet.new(to_charlist(&1)))
    |> Enum.chunk_every(3)
    |> count()
  end
end
