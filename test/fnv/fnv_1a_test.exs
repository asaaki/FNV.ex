defmodule FNV_FNV1a_Test do
  import FNVTestSetup
  use ExUnit.Case, async: true

  module_under_test = FNV.FNV1a

  # We only need to test the hex strings as they can be calculated only if they pass through the integer step.
  @test_outputs_hex [
    # 32
    [
      "811c9dc5",
      "b2f5cb99",
      "956cf6b0",
      "fcf255d1",
      "2802ea0b"
    ],
    # 64
    [
      "cbf29ce484222325",
      "dcb57e18fedc1a99",
      "8954a2146bf22870",
      "fafe46d7c7b79d31",
      "50f232542687b30b"
    ],
    # 128module_under_test
    [
      "6c62272e07bb014262b821756295c58d",
      "a68d5ed3788b5822836dbc79768e89e9",
      "32d645e1c783d94f7080c6e0dd865930",
      "e90ce0727cca909ee34be40208db67a9",
      "15332d4db78a7df4034c5791d5556b4b"
    ],
    # 256
    [
      "dd268dbcaac550362d98c384c4e576ccc8b1536847b6bbb31023b4c8caee0535",
      "8b0e658c2f1c837f8d1b63e359de3a1784bd1d30340f770be97fd65816326079",
      "366f691cc84d6d0b39b2a28bb803c3d04e05f6cc9133d7274563e203d8dff150",
      "9855432fb16f0424c6ba3cece39312eef455288d2a8b68749fe3d17c08efb8c1",
      "ea5c47d84667b0839e7c2dc9ffb5f7b123e03efaa3cb4d0178f42500d5e2060b"
    ],
    # 512
    [
      "b86db0b1171f4416dca1e50f309990acac87d059c90000000000000000000d21e948f68a34c192f62ea79bc942dbe7ce182036415f56e34bac982aac4afe9fd9",
      "142433ed48a78bb429a7dba8911e8824dcd78fa7660000000000001f96475fbd69323ab91bbf83bd3e36fbfd7d0c038b1075dbff4f7a2150e9f28b6e88f67e51",
      "96b20c29347dfb41b5e3ebf2c34d267c90fee164fc0000000038b4561715d5e5a4bd279918adecbcd2f439c85e285847a4345f1bfde8f24a6260e89d5aec41c8",
      "9a206b383e0ac4e275357474814e05d54eb27eae23deba039b730d6ae5eb7cdc9ab58787cd0a8fb88a193bf150f7b4f096d3143c933923777860a075fccbcbfd",
      "0484194f9af7f345106abfb052ebf59e85bfd1763dbb8eb8fa2ccf659067a4782b1dc231a632518a6f03efde72e558d011fd27fab260d1c066ee71877b2acce3"
    ],
    # 1024
    [
      "0000000000000000005f7a76758ecc4d32e56d5a591028b74b29fc4223fdada16c3bf34eda3674da9a21d9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c6d7eb6e73802734510a555f256cc005ae556bde8cc9c6a93b21aff4b16c71ee90b3",
      "000000000001868ce88bd2c7cdc5fa5e52ebb9925ff5ea668dff4576aa4ba65819176ce6b925a8421b16e2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011d09af071cf00b53007a8e594c73348a3dbb339aead4953fdf93cfff54816f5e2d1ed594881",
      "00000003e27f563b2ca82d6f6b22a35117ddfb386bab86b4e52a63e0aa457ba1b5d6c250528883a2f4afc80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002ad7e6edea236c5abdff1bce07f9c3b45c98f798e3b69b8e2f946b142b391bbfdc361de0e85e2b64",
      "9de5b3513f2e637297e278e3c8c5585de667905c91647fea57067ad851ee04269bae3ace1fbffb472d9b8e09f96b9909ca24d6023f682ec9a06f644610c9a85ce27c808d9b235e520a69f4ca5d9ccf4104c3bd5c6612296b69a23b3a8bd78fb6ea2a9031e635eeefe1649672e83fe2508878b18ccf7b957fd75b460e377560d3",
      "057bd76dcc19d25b031f49dcae412fbb02d368f695054ef6c166f8133cd3bb8d9f600f7ea0fe890eace2d624f8dd86dd16e672c7685f22ba8c755af52bb02bcc020a83b9bdb2466fe84b116210c91d261338ba05fe9fda5c6daa9534417646a6a3f30bff640905c379566bea78b990da67244464e114258a24c9803187fee4a7"
    ]
  ]

  for { bits, output_list } <- List.zip([outputs_bits(), @test_outputs_hex]) do
    test_cases = List.zip([input_data(), output_list]) |> Enum.with_index
    for { { input, output }, index } <- test_cases do
      test "#{module_under_test}.hex/2 with #{bits} bits, example #{index + 1}" do
        assert unquote(module_under_test).hex(unquote(input), unquote(bits)) == unquote(output)
      end
    end
  end

  for { bits, output_list } <- List.zip([outputs_bits(), @test_outputs_hex]) do
    test_cases = List.zip([input_data(), output_list]) |> Enum.with_index
    function_call = :"hex#{bits}"
    for { { input, output }, index } <- test_cases do
      test "#{module_under_test}.#{function_call}/1 with #{bits} bits, example #{index + 1}" do
        assert unquote(module_under_test).unquote(function_call)(unquote(input)) == unquote(output)
      end
    end
  end
end
