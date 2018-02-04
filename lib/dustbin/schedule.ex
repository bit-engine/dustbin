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
    ast = for {location_name, type, element} <- schedules do
      defschedules(location_name, type, element)
    end

    quote do
      def find(location_name, date)
      unquote(ast)
      def find(_location_name, _date), do: {:error, :not_found}
    end
  end

  defp defschedules(location_name, :file, path) do
    contents =
      Path.join(:code.priv_dir(:dustbin), "#{location_name}/#{path}")
      |> File.read!

    for entry <- Jason.decode!(contents) do
      [{date, occurrences}] = Map.to_list(entry)
      escaped = Macro.escape(occurrences)

      deffind(location_name, date, escaped)
    end
  end

  defp defschedules(location_name, :inline, array) do
    for entry <- array do
      [{date, occurrences}] = Map.to_list(entry)
      escaped = Macro.escape(occurrences)
      
      deffind(location_name, date, escaped)
    end
  end

  defp deffind(location_name, date, body) do
    quote do
      def find(unquote(location_name), unquote(date)), do: {:ok, unquote(body)}
    end   
  end
  
  defmacro schedule(opts) do
    location_name = Keyword.get(opts, :location_name)
    
    {type, element} =
      cond do
        path = Keyword.get(opts, :path) ->
          {:file, path}
        inline = Keyword.get(opts, :inline) ->
          {:inline, inline}
      end
        
    quote bind_quoted: [location_name: location_name, type: type, element: element] do
      @schedules {location_name, type, element}
    end
  end
end
