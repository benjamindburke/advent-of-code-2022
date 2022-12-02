defmodule AdventOfCode.Day2 do

  @score_per_win 6
  @score_per_loss 0
  @score_per_draw 3
  @rock_score 1
  @paper_score 2
  @scissors_score 3

  def read_input() do
    (__DIR__ <> "/input.txt")
    |> File.read!()
  end

  def solution do
    read_input()
    |> String.split("\n", trim: true)
    |> Enum.map(&get_score/1)
    |> IO.inspect()
    |> Enum.sum()
  end

  # lose
  def get_score("A X"), do: @score_per_loss + @scissors_score
  def get_score("B X"), do: @score_per_loss + @rock_score
  def get_score("C X"), do: @score_per_loss + @paper_score

  # draw
  def get_score("A Y"), do: @score_per_draw + @rock_score
  def get_score("B Y"), do: @score_per_draw + @paper_score
  def get_score("C Y"), do: @score_per_draw + @scissors_score

  # win
  def get_score("A Z"), do: @score_per_win + @paper_score
  def get_score("B Z"), do: @score_per_win + @scissors_score
  def get_score("C Z"), do: @score_per_win + @rock_score
end
