defmodule MessageBuilder do
  @spec build(binary()) :: bitstring()
  def build(_hostname) do
    header()
  end

  defp header() do
    id = :rand.uniform(65536)

    <<id::16, 1::1, 0::4, 0::1, 0::1, 1::1, 0::1, 0::3, 0::4, 1::16, 0::16, 0::16, 0::16>>
  end
end
