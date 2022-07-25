defmodule MetaWorldServerWeb.HubChannelTest do
  use MetaWorldServerWeb.ChannelCase

  alias MetaWorldServerWeb.{SessionSocket}

  setup do
    {:ok, socket} = connect(SessionSocket, %{})
    {:ok, _, socket} = subscribe_and_join(socket, MetaWorldServerWeb.HubChannel, "hub:lobby")
    %{socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "naf broadcasts to hub:test ", %{socket: socket} do
    push(socket, "naf", %{"hello" => "all"})
    assert_broadcast "naf", %{"hello" => "all"}
  end

  test "shout broadcasts to hub:lobby", %{socket: socket} do
    push(socket, "shout", %{"hello" => "all"})
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end
end
