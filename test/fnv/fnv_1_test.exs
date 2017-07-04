defmodule FNV_FNV1_Test do
  import FNVTestSetup
  use ExUnit.Case, async: true

  module_under_test = FNV.FNV1

  # We only need to test the hex strings as they can be calculated only if they pass through the integer step.
  @test_outputs_hex [
    # 32
    [
      "811c9dc5",
      "418f6079",
      "e604646e",
      "8b8e5bb9",
      "e964440f"
    ],
    # 64
    [
      "cbf29ce484222325",
      "d8cbc8186ba13779",
      "eb47374ce26689ce",
      "8d93b62b993bf999",
      "6a5a1cb7c6335ecf"
    ],
    # 128
    [
      "6c62272e07bb014262b821756295c58d",
      "a68bb298328b5822836dbc78c6a7b2a9",
      "f2dd810c0683d94f708038f53bbb8e36",
      "5cb41b27db45c4b35192cdb4ba4477a1",
      "d9f5ac715087a4e166f5b24b76f46cff"
    ],
    # 256
    [
      "dd268dbcaac550362d98c384c4e576ccc8b1536847b6bbb31023b4c8caee0535",
      "8b0e658c2f1c837edde9cde359de3a1784bd1d30340f770be97fd657c4b92f59",
      "366f691cc850bf6f4f79518bb803c3d04e05f6cc9133d7274564cddb7c838ade",
      "e988e94df70c43518b78ac4b57853db4e1c5206da0b2d83e5ed4d38ed26437c9",
      "6353e5096fb992789deacdc19690949e3b0938573c2ea1f75606b9706da5ae8f"
    ],
    # 512
    [
      "b86db0b1171f4416dca1e50f309990acac87d059c90000000000000000000d21e948f68a34c192f62ea79bc942dbe7ce182036415f56e34bac982aac4afe9fd9",
      "142433ed48a78bb429a7dba8911e8824dcd81cfa380000000000001f96475fbd69323ab91bbf83bd3e36fbfd7d0c038b1075dbff4f7a2150e9f28b6ec85f0171",
      "96b20c29347dfb41b5e3ebf2c34d267b6c6fa65ce30000000038b4561715d5e5a4bd279918adecbcd2f439c85e285847a4345f1bfde8f24a62609a0c8f336bf2",
      "fff75e5463a9a0b7f0952ccee9808abae0ef75116fb2d6f192803159a36afb4036552dd5700aa0354756a9782d1ab079973f4603a301beef3f41a77ab9e14445",
      "c881e3c138834c8e24243008475c3922a12942e00014d1817c58d8e09864fae71ecae2797cf707ee23912e87fe69df0eb871a70c14d0e76d88b50ffbdf9ee497"
    ],
    # 1024
    [
      "0000000000000000005f7a76758ecc4d32e56d5a591028b74b29fc4223fdada16c3bf34eda3674da9a21d9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c6d7eb6e73802734510a555f256cc005ae556bde8cc9c6a93b21aff4b16c71ee90b3",
      "000000000001868ce88bd2c7cdc5fa5e52ebb9925ff5ea668dff4576aa4ba65819176ce6b925a841271888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011d09af071cf00b53007a8e594c73348a3dbb339aead4953fdf93cfff54816f5e2d16f8f6541",
      "00000003e27f563b2ca82d6f6b22a35117ddfb386bab86b4e52a63e0aa457ba1b5d6c250528e2782ad791b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002ad7e6edea236c5abdff1bce07f9c3b45c98f798e3b69b8e2f946b142b391bbfdc37dd8c08fc2ad8",
      "e4546e0bc0d59b1c0dffc96b938355d7c74f53df2f5f12c6b7865db2bdf953a973fbf29c795384d525cdf609f96b9909ca24d6023f682ec9a06f644610c9a85ce27c808d9b235dfdc6adb3abd6714ac52e05de430e3118aa255170829c13ef70e10e9d88111f3cf607ea10843c8bebc130bec2a1fa4f8eb8f372be670e5fb823",
      "be1739f38fcd130b5a11c050d31895f9082e63ba58cf07ea05b4091d13ef6980836a8b4f7af012263b1651c4e82298f7e9e30dead516538ee45777a7f0553bfa90bb79d1ee8e2df6363651bf2a5bcb7c08a1251c25e2f48a22290b99b8ff12ca2c0d222d9d0d891bf66b65eccfbff48b28b9e6dd95366064337aad9324d06957"
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
