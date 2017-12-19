defmodule Dustbin.Data.SupportedLocation do
  @moduledoc false
  @locations [
    %{:slug => "chambly", :city => "Chambly", :province => "Quebec", :country_code => "CA", :timezone => "America/Montreal"}
  ]

  for location <- @locations do
    %{:slug => slug} = location
    def location_for_slug(unquote(slug)), do: unquote(Macro.escape(location))
  end
  
  def location_for_slug(_slug), do: nil

  def all, do: @locations
end
