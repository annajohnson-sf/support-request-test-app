defmodule DataCanonicalization do
  @spec read_payload(map()) :: %{
          optional(:acceptance) => binary(),
          optional(:description) => binary(),
          optional(:summary) => binary(),
          optional(:team) => binary(),
          optional(:urgency) => binary(),
          optional(:user) => binary()
        }
  def read_payload(%{"payload" => %{"event" => %{"blocks" => [block | _]}}}) do
    block
    |> Map.get("elements")
    |> List.first()
    |> Map.get("elements")
    |> canonicalize_data()
  end

  @spec canonicalize_data(list(map())) :: map()
  def canonicalize_data(payload) when is_list(payload) do
    canonicalize_data(payload, %{})
  end

  defp canonicalize_data(
         [
           %{"text" => "Urgency: ", "type" => "text"},
           %{"text" => urgency_level, "type" => "text"} | rest
         ],
         acc
       )
       when is_binary(urgency_level) do
    canonicalize_data(rest, Map.put(acc, :urgency, urgency_level))
  end

  defp canonicalize_data(
         [
           %{"text" => ", Impacted Team: ", "type" => "text"},
           %{"text" => team_name, "type" => "text"} | rest
         ],
         acc
       )
       when is_binary(team_name) do
    canonicalize_data(rest, Map.put(acc, :team, team_name))
  end

  defp canonicalize_data(
         [
           %{"text" => ", Summary: ", "type" => "text"},
           %{"text" => request_summary, "type" => "text"} | rest
         ],
         acc
       )
       when is_binary(request_summary) do
    canonicalize_data(rest, Map.put(acc, :summary, request_summary))
  end

  defp canonicalize_data(
         [
           %{"text" => ", Submitted by: ", "type" => "text"},
           %{"user_id" => user_name, "type" => "user"} | rest
         ],
         acc
       )
       when is_binary(user_name) do
    canonicalize_data(rest, Map.put(acc, :user, user_name))
  end

  defp canonicalize_data(
         [
           %{"text" => ", Description: ", "type" => "text"},
           %{"text" => request_description, "type" => "text"} | rest
         ],
         acc
       )
       when is_binary(request_description) do
    canonicalize_data(rest, Map.put(acc, :description, request_description))
  end

  defp canonicalize_data(
         [
           %{"text" => ", Acceptance: ", "type" => "text"},
           %{"text" => request_acceptance, "type" => "text"} | rest
         ],
         acc
       )
       when is_binary(request_acceptance) do
    canonicalize_data(rest, Map.put(acc, :acceptance, request_acceptance))
  end

  defp canonicalize_data(ignored_items, acc) when is_list(ignored_items) do
    acc
  end
end
