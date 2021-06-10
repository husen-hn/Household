defmodule HouseholdWeb.ServiceController do
  use HouseholdWeb, :controller

  def new_device(conn, _params) do
    render(conn, "new_device.html")
  end
end
