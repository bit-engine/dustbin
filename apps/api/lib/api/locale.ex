defmodule Dustbin.API.Locale do
  @moduledoc false
  import Plug.Conn

  @locales ["en", "fr"]

  def init(_opts), do: nil

  def call(conn, _opts) do
    case get_req_header(conn, "accept-language") do
      [locale] when locale in @locales -> Gettext.put_locale(Dustbin.APIWeb.Gettext, locale)
      _ -> Gettext.put_locale(Dustbin.APIWeb.Gettext, "en")
    end
    conn
  end
end
