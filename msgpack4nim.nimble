# Package
version       = "0.3.1"
author        = "Andri Lim"
description   = "MessagePack serializer/deserializer implementation in nim"
license       = "MIT"

# Dependencies
requires "nim >= 0.18.0"

installFiles = @["msgpack4nim.nim", "msgpack4collection.nim", "msgpack2any.nim", "msgpack2json.nim"]

# Examples and Tests
skipDirs = @["examples", "tests"]

task test, "Run all tests":
  exec "nim c -r examples/test"
  exec "nim c -r -d:msgpack_obj_to_map tests/test_any"
  exec "nim c -r tests/test_json"
  exec "nim c -r tests/test_codec"
  exec "nim c -r tests/test_spec"

  exec "nim c -d:release -r examples/test"
  exec "nim c -d:release -r -d:msgpack_obj_to_map tests/test_any"

  # because uses `getAppDir()`, see https://github.com/nim-lang/Nim/pull/13382
  exec "nim c -d:release tests/test_json"
  when defined(windows): exec r"tests\test_json.exe"
  else: exec r"tests/test_json"

  exec "nim c -d:release -r tests/test_codec"
  exec "nim c -d:release -r tests/test_spec"
