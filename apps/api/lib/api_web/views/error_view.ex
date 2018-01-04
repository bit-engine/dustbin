defmodule Dustbin.APIWeb.ErrorView do
  use Dustbin.APIWeb, :view

  def render("400.json", %{details: details}) do
    %{
      error: "Bad Request",
      details: details,
    }
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
