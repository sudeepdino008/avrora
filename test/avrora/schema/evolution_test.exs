defmodule Avrora.Schema.EvolutionTest do
  use ExUnit.Case, async: true

  import Support.Config

  setup :support_config

  describe "from_json/2" do

    test "schema evolution" do
      {:ok, oldschema2} = Avrora.Schema.Encoder.from_json(~s({ "type": "record", "name": "Payment2", "namespace": "io", "fields": [{  "name": "id",  "type": "string"},{  "name": "amount",  "type": "double"} ]  }  ))
      oldschema = %{oldschema2 | id: nil, version: nil}
      payload = %{"id" => "123", "amount" => 123.45}




      {:ok, epayload} = Avrora.Codec.Plain.encode(payload, schema: oldschema)

      {:ok, dpayload} = Avrora.Codec.Plain.decode(epayload, schema: oldschema)

      assert dpayload == payload

      {:ok, newschema2} = Avrora.Schema.Encoder.from_json(~s({"type": "record","name": "Payment2","namespace": "io","fields": [  {"name": "id","type": "string"  },  {"name": "amount","type": "double"  },  {"name": "tags","type": "string","default": "sometag"  }]  }  ))
      newschema = %{newschema2 | id: nil, version: nil}

      {:ok, dpayload} = Avrora.Codec.Plain.decode(epayload, schema: newschema)
      assert dpayload == payload
    end
  end

end
