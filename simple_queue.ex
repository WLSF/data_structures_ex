defmodule SimpleQueue do
  use GenServer

  def init(state), do: {:ok, state}

  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  def handle_cast({:enqueue, value}, state), do: {:noreply, state ++ [value]}

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def run({method, value}), do: GenServer.cast(__MODULE__, {method, value})
  def run(method), do: GenServer.call(__MODULE__, method)

  def queue, do: run(:queue)
  def dequeue, do: run(:dequeue)
  def enqueue(value), do: run({:enqueue, value})
end
