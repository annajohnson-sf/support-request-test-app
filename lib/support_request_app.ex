defmodule SupportRequestApp do
  def initiate_slack_connection do
    headers = [
      {"Authorization", "Bearer #{Dotenv.get("SLACK_TOKEN")}"},
      {"Content-type", "application/x-www-form-urlencoded"}
    ]

    {:ok, response} =
      HTTPoison.post("https://slack.com/api/apps.connections.open", "", headers, [])

    Jason.decode!(response.body)
    |> Map.get("url")
    |> SlackSocket.start_link(response)
  end

  def post_to_slack(msg) do
    headers = [{"Content-type", "application/json --data"}]

    json_msg =
      Jason.encode!(%{
        text: msg
      })

    response = HTTPoison.post(Dotenv.get("SLACK_POST_URL"), json_msg, headers, [])
    response
  end
end
