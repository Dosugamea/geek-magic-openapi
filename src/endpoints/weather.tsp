import "../lib/shared-models.tsp";
import "@typespec/openapi3";
import "@typespec/http";

using TypeSpec.Http;

namespace Weather;

model GetCurrentCityCodeResponse {
    @doc("current city code in number string")
    @example("1850147")
    cd: string;

    @doc("current city name (short)")
    @example("Tokyo")
    ct: string;

    @doc("current city name (full)")
    @example("Tokyo,JP")
    loc: string;

    @doc("unknown")
    @example("0")
    mt: string;

    @doc("timezone offset in hours")
    @example("9")
    t: string;
}

model GetWeatherUnitFormatConfigResponse {
    @doc("wind speed unit")
    @example("m/s")
    w_u: "m/s" | "km/h" | "mile/h";

    @doc("temperature unit (default: Â°C) (charset is buggy but working)")
    @example("Â°C")
    t_u: "Â°C" | "Â°F";

    @doc("pressure unit")
    @example("hPa")
    p_u: "hPa" | "kPa" | "mmHg" | "inHg"
}

model GetWeatherUpdateIntervalConfigResponse {
    @doc("weather update interval in minutes")
    @example(20)
    w_i: SharedModels.IntervalMinuteValue;
}

model GetWeatherForecastApiKeyResponse {
    @doc("weather forecast api key")
    @example("1234567890")
    key: string;
}