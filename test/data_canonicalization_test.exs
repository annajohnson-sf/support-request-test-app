defmodule DataCanonicalizationTest do
  use ExUnit.Case
  doctest DataCanonicalization

  describe "canonicalizing list from Slack's API" do
    setup(_) do
      list = [
        %{"text" => ", Impacted Team: ", "type" => "text"},
        %{"text" => "Biz Ops", "type" => "text"},
        %{"text" => "Urgency: ", "type" => "text"},
        %{"text" => "Urgent", "type" => "text"},
        %{"text" => ", Summary: ", "type" => "text"},
        %{"text" => "Test Summary!!", "type" => "text"},
        %{"text" => ", Submitted by: ", "type" => "text"},
        %{"type" => "user", "user_id" => "U064EBNCKDX"},
        %{"text" => ", Description: ", "type" => "text"},
        %{"text" => "Here is a test description.", "type" => "text"},
        %{"text" => ", Acceptance: ", "type" => "text"},
        %{"text" => "Here is a test acceptance criteria.", "type" => "text"},
        %{"text" => ", ", "type" => "text"},
        %{"type" => "user", "user_id" => "U06526MDMJ7"}
      ]
      {:ok, %{list: list}}
    end
    test "extracts the user", %{list: list} do
      output = SlackSocket.canonicalize_support_request_data(list)
      assert output[:user] == "U064EBNCKDX"
    end
    test "extracts the team", %{list: list} do
      output = SlackSocket.canonicalize_support_request_data(list)
      assert output[:team] == "Biz Ops"
    end

    test "extracts the summary", %{list: list} do
      output = SlackSocket.canonicalize_support_request_data(list)
      assert output[:summary] == "Test Summary!!"
    end

    test "extracts the urgency", %{list: list} do
      output = SlackSocket.canonicalize_support_request_data(list)
      assert output[:urgency] == "Urgent"
    end

    test "extracts the description", %{list: list} do
      output = SlackSocket.canonicalize_support_request_data(list)
      assert output[:description] == "Here is a test description."
    end

    test "extracts the acceptance", %{list: list} do
      output = SlackSocket.canonicalize_support_request_data(list)
      assert output[:acceptance] == "Here is a test acceptance criteria."
    end
  end
end
