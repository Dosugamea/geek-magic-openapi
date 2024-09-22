import "../lib/shared-models.tsp";
import "@typespec/openapi3";
import "@typespec/http";

using TypeSpec.Http;

namespace Pictures;

model GetAutoDisplayResponse {
    @doc("1 if auto switch is enabled, 0 if auto switch is disabled")
    @example(0)
    autoplay: 0 | 1;

    @doc("interval in seconds (default: 10)")
    @example(10)
    i_i: SharedModels.IntervalSecondValue;
}