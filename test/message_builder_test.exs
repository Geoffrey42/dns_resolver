defmodule MessageBuilderTest do
  use ExUnit.Case

  describe "should build a valid message given a hostname" do
    test "notably a header" do
      given_hostname = "www.google.com"

      message = MessageBuilder.build(given_hostname)

      assert <<header::binary-size(12), _rest::binary>> = message

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
             >> = header

      assert qr == 1
      assert opcode == 0
      assert rd == 1
      assert qdcount == 1
      assert ancount == 0
      assert nscount == 0
      assert arcount == 0
    end

    test "notably the question section" do
      given_hostname = "www.google.com"

      message = MessageBuilder.build(given_hostname)

      assert <<_header::binary-size(12), qname::binary-size(16), qtype::16, qclass::16, _rest::binary>> = message


      assert qname == << 3, "www", 6, "google", 3, "com", 0 >>
      assert qtype == 1
      assert qclass == 1
    end

  end
end
