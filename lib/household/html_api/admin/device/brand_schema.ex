defmodule Household.HtmlApi.Device.BrandSchema do
  use Ecto.Schema

  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "brands" do
    field :name, :string, size: 150, null: false
    timestamps()
  end

  def changeset(brand, params \\ %{}) do
    brand
    |> cast(params, [:name])
    |> validate_required([:name], message: "تمامی فیلدهای موردنظر باید وارد شود." )
    |> validate_length(:name, max: 150, message: "حداکثر مجاز ۱۵۰ کاراکتر می باشد.")
  end
end
