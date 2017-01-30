defmodule Bitzy do
  use Application

  def start(_type, _args) do
    Bitzy.Supervisor.start_link(:ok)
  end

  def run(n_workers, url) when n_workers > 0 do
    worker_func = fn -> Bitzy.Worker.start(url) end
    1..n_workers
    |> Enum.map(fn _ -> Task.async(worker_func) end)
    |> Enum.map(&Task.await(&1, :infinity))
  end

  # defp parse_resuts(results) do
  #   {succeses, _failures} =
  #     results|> Enum.partition(fn x ->
  #       case x do
  #         {:ok, _} -> true
  #         _ -> false
  #       end
  #     end)
  #
  #     total_workers = Enum.count(results)
  #     total_success = Enum.count(successes)
  #     total_failures = total_workers - total_success
  #
  #     data = succeses |> Enum.map(fn {:ok, time} -> time end)
  #     average_time = average(data)
  #     longest_time = Enum.max(data)
  #     shortest_time = Enum.min(data)
  #
  #     IO.puts """
  #     Total workers : #{total_workers}
  #     Successful reqs : #{total_success}
  #     Failed res : #{total_failure}
  #     Average(msecs) :#{longest_time}
  #     Shorted(msecs) : #{shortes_time}
  #     """
  # end
  #
  # defp average(list) do
  #   sum = Enum.sum(list)
  #   if sum > 0 do
  #     sum / Enum.count(list)
  #   else
  #     0
  #   end
  # end
end
