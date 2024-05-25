defmodule MessageBuilderTest do
  use ExUnit.Case

  test "should build a valid message given a hostname" do
    given_hostname = "www.google.com"

    message = MessageBuilder.build(given_hostname)

    assert <<
             _id::16,
             qr::1,
             opcode::4,
             _aa::1,
             _tc::1,
             rd::1,
             _ra::1,
             _z::3,
             _rcode::4,
             qdcount::16,
             ancount::16,
            nscount::16,
            arcount::16
           >> = message

    assert qr == 1
    assert opcode == 0
    assert rd == 1
    assert qdcount == 1
    assert ancount == 0
    assert nscount == 0
    assert arcount == 0
  end
end
