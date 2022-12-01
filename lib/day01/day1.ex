defmodule AdventOfCode.Day1 do
  def solution1 do
    [count | []] =
      chunk_input()
      |> count_calories()
      |> get_from_top(1)

    count
  end

  def solution2 do
    chunk_input()
    |> count_calories()
    |> get_from_top(3)
    |> Enum.sum()
  end

  def chunk_input do
    (__DIR__ <> "/input.txt")
    |> File.read!()
    |> String.split(~r/(\r?\n){2}/)
    |> Enum.map(&String.split(&1, ~r/(\r?\n)/, trim: true))
  end

  def count_calories(elf_calories, elf_sums \\ [])
  def count_calories([], elf_sums), do: elf_sums

  def count_calories([elf | elf_calories], elf_sums) do
    elf_sum =
      elf
      |> Stream.map(&String.to_integer/1)
      |> Enum.sum()

    count_calories(elf_calories, [elf_sum | elf_sums])
  end

  def get_from_top(elf_sums, count \\ 1) do
    elf_sums
    |> Enum.sort(&(&2 < &1))
    |> Enum.take(count)
  end
end
