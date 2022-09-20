defmodule MetaWorldServerWeb.RoomChannel do
  @moduledoc false
  use MetaWorldServerWeb, :channel
  alias MetaWorldServerWeb.Presence

  @impl true
  def join("room:" <> room_sid, %{"profile" => profile}, socket) do
    # if authorized?(payload) do

    socket =
      socket
      |> assign(:profile, profile)

    send(self(), {:begin_tracking, socket.assigns.session_id, room_sid})

    {:ok, socket.assigns.session_id, socket}
    # else
    #  {:error, %{reason: "unauthorized"}}
    # end
  end

  @impl true
  def handle_info({:begin_tracking, session_id, _room_sid}, socket) do
    {:ok, _} = Presence.track(socket, session_id, socket.assigns)

    push(socket, "presence_state", socket |> Presence.list())

    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  @impl true
  def handle_in(
        "networkedData" = event,
        payload,
        socket
      ) do
    broadcast_from!(socket, event, payload)

    {:noreply, socket}
  end

  @impl true
  def handle_in(
        "networkedDataInChair" = event,
        payload,
        socket
      ) do
    broadcast_from!(socket, event, payload)

    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  # defp authorized?(_payload) do
  #  true
  # end
end
