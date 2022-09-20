defmodule MetaWorldServerWeb.RoomChannelTest do
  use MetaWorldServerWeb.ChannelCase

  alias MetaWorldServerWeb.{SessionSocket}

  @default_join_params %{"profile" => %{}}

  setup do
    {:ok, socket} = connect(SessionSocket, %{})
    {:ok, _, socket} = subscribe_and_join(socket, "room:lobby", @default_join_params)
    %{socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "networkedData broadcasts to room:test ", %{socket: socket} do
    push(socket, "networkedData", %{
      "sessionId" => "session_id",
      "positionX" => "position_x",
      "positionY" => "position_y",
      "positionZ" => "position_z",
      "animation" => "animation",
      "orientationX" => "orientation_x",
      "orientationY" => "orientation_y",
      "orientationZ" => "orientation_z"
    })

    assert_broadcast "networkedData", %{
      "sessionId" => "session_id",
      "positionX" => "position_x",
      "positionY" => "position_y",
      "positionZ" => "position_z",
      "animation" => "animation",
      "orientationX" => "orientation_x",
      "orientationY" => "orientation_y",
      "orientationZ" => "orientation_z"
    }
  end

  test "networkedDataChair broadcasts to room:test ", %{socket: socket} do
    push(socket, "networkedDataInChair", %{
      "sessionId" => "session_id",
      "positionX" => "position_x",
      "positionY" => "position_y",
      "positionZ" => "position_z",
      "animation" => "animation",
      "orientationX" => "orientation_x",
      "orientationY" => "orientation_y",
      "orientationZ" => "orientation_z"
    })

    assert_broadcast "networkedDataInChair", %{
      "sessionId" => "session_id",
      "positionX" => "position_x",
      "positionY" => "position_y",
      "positionZ" => "position_z",
      "animation" => "animation",
      "orientationX" => "orientation_x",
      "orientationY" => "orientation_y",
      "orientationZ" => "orientation_z"
    }
  end

  test "shout broadcasts to room:lobby", %{socket: socket} do
    push(socket, "shout", %{"hello" => "all"})
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end
end
