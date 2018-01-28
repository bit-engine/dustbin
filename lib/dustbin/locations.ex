defmodule Dustbin.Locations do
  @supported_locations [
    %{
      name: "Chambly, Canada",
      slug: :chambly,
      timezone: "America/Montreal"
    }
  ]

  def supported do
    @supported_locations
  end
end
