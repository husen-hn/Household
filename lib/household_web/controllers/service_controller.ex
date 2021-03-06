defmodule HouseholdWeb.ServiceController do
  use HouseholdWeb, :controller
  alias Household.HtmlApi.Device.DeviceSchema
  alias Household.HtmlApi.Device.DeviceQuery

  alias Household.HtmlApi.Device.BrandSchema
  alias Household.HtmlApi.Device.BrandQuery

  # Device
  def devices(conn, _params) do
    render(conn, "devices.html", devices: DeviceQuery.devices())
  end

  def new_device(conn, _params) do
    changeset = DeviceSchema.changeset(%DeviceSchema{})
    render(conn, "new_device.html", changeset: changeset)
  end

  def add_device(conn, %{"device_schema" => device}) do
    case DeviceQuery.add_device(device) do
      {:ok, _device_info} ->
        conn
        |> put_flash(:success, "ذخیره شما با موفقیت انجام گردید.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :devices)}")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        render(conn, "new_device.html", changeset: changeset)
    end
  end

  def delete_device(conn, %{"id" => id}) do
    with {:ok, device_id} <- Ecto.UUID.cast(id),
      {:ok, _device_info} <- DeviceQuery.delete_device(device_id) do
        conn
        |> put_flash(:success, "دستگاه مورد نظر شما حذف گردید.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :devices)}")
    else
      _ ->
        conn
        |> put_flash(:danger, "مشکلی در حذف اتفاق افتاده است.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :devices)}")
    end
  end

  def edit_device(conn, %{"id" => id}) do
    case DeviceQuery.get_device_with_id(id) do
       nil ->
        conn
        |> put_flash(:success, "چنین صفحه ای وجود ندارد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :devices)}")
       device_info ->
        changeset = DeviceSchema.changeset(device_info)
        render(conn, "edit_device.html", changeset: changeset)
    end
  end

  def update_device(conn, %{"device_schema" => device}) do
    case DeviceQuery.edit_device(device["id"], device) do
      {:ok, _device_info} ->
        conn
        |> put_flash(:success, "دستگاه مورد نظر بروز رسانی شد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :devices)}")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        render(conn, "edit_device.html", changeset: changeset)
    end
  end

  # Brand

  def brands(conn, _params) do
    render(conn, "brands.html", brands: BrandQuery.brands())
  end

  def new_brand(conn, _params) do
    changeset = DeviceSchema.changeset(%BrandSchema{})
    render(conn, "new_brand.html", changeset: changeset)
  end

  def add_brand(conn, %{"brand_schema" => brand}) do
    case BrandQuery.add_brand(brand) do
      {:ok, _device_info} ->
        conn
        |> put_flash(:success, "ذخیره شما با موفقیت انجام گردید.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        render(conn, "new_brand.html", changeset: changeset)
    end
  end

  def delete_brand(conn, %{"id" => id}) do
    with {:ok, brand_id} <- Ecto.UUID.cast(id),
      {:ok, _device_info} <- BrandQuery.delete_brand(brand_id) do
        conn
        |> put_flash(:success, "دستگاه مورد نظر شما حذف گردید.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")
    else
      _ ->
        conn
        |> put_flash(:danger, "مشکلی در حذف اتفاق افتاده است.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")
    end
  end

  def edit_brand(conn, %{"id" => id}) do
    case BrandQuery.get_brand_with_id(id) do
       nil ->
        conn
        |> put_flash(:success, "چنین صفحه ای وجود ندارد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")
       brand_info ->
        changeset = BrandSchema.changeset(brand_info)
        render(conn, "edit_brand.html", changeset: changeset)
    end
  end

  def update_brand(conn, %{"brand_schema" => brand}) do
    case BrandQuery.edit_brand(brand["id"], brand) do
      {:ok, _brand_info} ->
        conn
        |> put_flash(:success, "دستگاه مورد نظر بروز رسانی شد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        render(conn, "edit_brand.html", changeset: changeset)
    end
  end
end
