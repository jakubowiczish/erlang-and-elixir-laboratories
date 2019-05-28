defmodule PollutionData do
  @moduledoc """
  Documentation for ModuleLab5.
  """

  @doc """
  PollutionData

  ## Examples

      iex> ModuleLab5.hello()
      :world

  """
  ## PollutionData.importFilesFromCSV

  def importFilesFromCSV do
    data = File.read!("pollution.csv")
           |> String.split("\r\n")
    line_zero = Enum.at(data, 0)
    parseSingleLine(line_zero)
  end


  def parseSingleLine(line) do
    [date, time, latitude, longitude, pollutionLevel] = line
                                                        |> String.split  (",")
    date_list = date
                |> String.split("-")
                |> Enum.reverse()

    reversed_date_tuple = :erlang.list_to_tuple(date_list)
    time_list = String.split(time, ":")
    time_tuple = :erlang.list_to_tuple(time_list)

    {reversed_date_tuple, time_tuple}
  end


  def hello do
    :world
  end
end
