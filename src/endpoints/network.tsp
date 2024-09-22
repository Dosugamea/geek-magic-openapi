import "../lib/shared-models.tsp";
import "@typespec/openapi3";
import "@typespec/http";

using TypeSpec.Http;

namespace Network;

model GetNetworkConfigResponse {
    @doc("stored network ssid")
    @example("SSID")
    a: string;

    @doc("stored network password (PLAIN TEXT)")
    @example("password")
    p: string;
}

model GetNetworkDelayConfigResponse {
    @doc("stored network connection delay in seconds")
    @example(0)
    d: 0 | SharedModels.IntervalSecondValue;
}