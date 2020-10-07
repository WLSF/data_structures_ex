defmodule Stack do
  use GenServer

  def init(state), do: {:ok, state}
  def handle_call(:pop, _from, [value | state]), do: {:reply, value, state}
  def handle_call(:pop, _from, []), do: {:reply, nil, []}
  def handle_cast({:push, value}, state), do: {:noreply, [value | state]}

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def push(value), do: GenServer.cast(__MODULE__, {:push, value})
  def pop, do: GenServer.call(__MODULE__, :pop)
end

