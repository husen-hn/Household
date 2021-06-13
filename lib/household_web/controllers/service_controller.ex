defmodule HouseholdWeb.ServiceController do
  use HouseholdWeb, :controller
  alias Household.HtmlApi.Device.DeviceSchema
  alias Household.HtmlApi.Device.DeviceQuery

  def new_device(conn, _params) do
    changeset = DeviceSchema.changeset(%DeviceSchema{})
    render(conn, "new_device.html", changeset: changeset)
  end

  def add_device(conn, %{"device_schema" => device}) do
    case DeviceQuery.add_device(device) do
      {:ok, device_info} ->
        conn
        |> redirect(to: "/new-device")
      {:error, changeset} ->
        render(conn, "new_device.html", changeset: changeset)
    end


  end
end
