defmodule Dustbin.Schedule do

  defmacro __using__ (_options) do
    quote do
      Module.register_attribute __MODULE__, :schedules, accumulate: true, persist: false
      import unquote(__MODULE__), only: [schedule: 1]
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(env) do
    compile(Module.get_attribute(env.module, :schedules))
  end

  def compile(schedules) do
    ast = for {location_name, path} <- schedules do
      defschedules(location_name, path)
    end

    quote do
      def schedule(location_name, date)
      unquote(ast)
      def schedule(_location_name, _date), do: {:error, :not_found}
    end
  end

  defp defschedules(location_name, path) do
    contents =
      Path.join(:code.priv_dir(:dustbin), "#{location_name}/#{path}")
      |> File.read!

    for entry <- Jason.decode!(contents) do
      [{date, occurrences}] = Map.to_list(entry)
      escaped = Macro.escape(occurrences)
      quote do
        def find(unquote(location_name), unquote(date)), do: unquote(escaped)
      end
    end
  end
  
  defmacro schedule(opts) do
    location_name = Keyword.get(opts, :location_name)
    path = Keyword.get(opts, :path)
    quote bind_quoted: [location_name: location_name, path: path] do
      @schedules {location_name, path}
    end
  end
end
