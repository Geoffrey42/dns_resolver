defmodule MessageBuilder do
  @spec build(binary()) :: bitstring()
  def build(hostname) do
    header() <> question_section(hostname)
  end

  defp header() do
    id = :rand.uniform(65536)

    <<id::16, 1::1, 0::4, 0::1, 0::1, 1::1, 0::1, 0::3, 0::4, 1::16, 0::16, 0::16, 0::16>>
  end

  defp question_section(hostname) do
    qname =
      String.split(hostname, ".")
      |> Enum.map(fn label -> <<String.length(label)>> <> label end)
      |> Enum.join()
      |> Kernel.<>(<<0>>)
    

    qname <> <<1::16>> <> <<1::16>>
  end
end
