defmodule AdventOfCode.Day2.Hand do
  defstruct [:val, :points, :beats, :loses_to]

  def new(:rock) do
    %AdventOfCode.Day2.Hand{val: :rock, points: 1, beats: :scissors, loses_to: :paper}
  end

  def new(:paper) do
    %AdventOfCode.Day2.Hand{val: :paper, points: 2, beats: :rock, loses_to: :scissors}
  end

  def new(:scissors) do
    %AdventOfCode.Day2.Hand{val: :scissors, points: 3, beats: :paper, loses_to: :rock}
  end

  def from_character("A"), do: new(:rock)
  def from_character("B"), do: new(:paper)
  def from_character("C"), do: new(:scissors)
  def from_character("X"), do: new(:rock)
  def from_character("Y"), do: new(:paper)
  def from_character("Z"), do: new(:scissors)

  def from_strategy(%AdventOfCode.Day2.Hand{beats: loser}, "X"),     do: new(loser)
  def from_strategy(%AdventOfCode.Day2.Hand{val: draw}, "Y"),        do: new(draw)
  def from_strategy(%AdventOfCode.Day2.Hand{loses_to: winner}, "Z"), do: new(winner)
end

defmodule AdventOfCode.Day2 do
  alias AdventOfCode.Day2.Hand

  @loss 0
  @draw 3
  @win 6

  def read_input() do
    (__DIR__ <> "/input.txt")
    |> File.read!()
    |> String.split(~r/\r?\n/, trim: true)
  end

  def calculate_hand_score(line) do
    [their_hand, my_hand] = String.split(line, " ")

    compare_hands(
      Hand.from_character(their_hand),
      Hand.from_character(my_hand)
    )
  end

  def calculate_strategy_score(line) do
    [their_hand, strategy] = String.split(line, " ")
    their_hand = Hand.from_character(their_hand)

    compare_hands(
      their_hand,
      Hand.from_strategy(their_hand, strategy)
    )
  end

  def compare_hands(their_hand, my_hand) do
    cond do
      my_hand.val == their_hand.beats -> my_hand.points + @loss
      my_hand.val == their_hand.val -> my_hand.points + @draw
      my_hand.val == their_hand.loses_to -> my_hand.points + @win
    end
  end

  def solution1 do
    read_input()
    |> Stream.map(&calculate_hand_score/1)
    |> Enum.sum()
  end

  def solution2 do
    read_input()
    |> Stream.map(&calculate_strategy_score/1)
    |> Enum.sum()
  end
end
