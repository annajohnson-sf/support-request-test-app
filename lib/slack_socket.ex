defmodule SlackSocket do
  use WebSockex

  @spec start_link(binary() | WebSockex.Conn.t(), any()) :: {:error, any()} | {:ok, pid()}
  def start_link(url, state) do
    WebSockex.start_link(url, __MODULE__, state)
  end

  def handle_frame({type, msg}, state) do
    data = Jason.decode!(msg)

    if Map.has_key?(data, "payload") do
      DataCanonicalization.read_payload(data)
      {:ok, state}
    else
      IO.puts("Process #{msg} started.")
      {:ok, state}
    end
  end
end
