import "@typespec/openapi3";
import "../lib/shared-models.tsp";

namespace Settings;

alias ModelName = string;
alias ModelVersion = string;

model GetDeviceInfoResponse {
    @doc("model name")
    @example("SmallTV-Ultra")
    m: ModelName;

    @doc("model version")
    @example("Ultra-V9.0.26")
    v: ModelVersion;
}

@doc("brightness value between -10 to 255")
@minValue(-10)
@maxValue(255)
scalar BrightnessValue extends numeric;

model GetDeviceBrightnessResponse {
    @example(128)
    brt: BrightnessValue;
}

@minValue(0)
@maxValue(23)
scalar HourValue extends numeric;

model GetDeviceBrightnessScheduleResponse {
    @doc("1 if brightness schedule is enabled, 0 if brightness schedule is disabled")
    en: SharedModels.BooleanLikeNumberValue;
    @doc("start time (hours from 0 to 23)")
    t1: HourValue;
    @doc("end time (hours from 0 to 23)")
    t2: HourValue;
    @doc("brightness value while in specified time range (b1 doesn't exist in this response, you need to get it from /brt.json)")
    b2: BrightnessValue;
}

@doc("""
Display design of the device

- 1: WEATHER_CLOCK_TODAY
- 2: WEAHTER_FORECAST
- 3: PHOTO_ALBUM
- 4: TIME_STYLE_1
- 5: TIME_STYLE_2
- 6: TIME_STYLE_3
- 7: SIMPLE_WEATHER_CLOCK
""")
enum DeviceDesignTheme {
    WEATHER_CLOCK_TODAY: 1,
    WEAHTER_FORECAST: 2,
    PHOTO_ALBUM: 3,
    TIME_STYLE_1: 4,
    TIME_STYLE_2: 5,
    TIME_STYLE_3: 6,
    SIMPLE_WEATHER_CLOCK: 7,
}

model GetDeviceThemeResponse {
    theme: DeviceDesignTheme;
}

enum DeviceAutoSwitchThemeStatus {
    ON: "1",
    OFF: "0",
}

#suppress "non-literal-string-template" ""
alias DeviceAutoSwitchThemeStatusList = "${DeviceAutoSwitchThemeStatus},${DeviceAutoSwitchThemeStatus},${DeviceAutoSwitchThemeStatus},${DeviceAutoSwitchThemeStatus},${DeviceAutoSwitchThemeStatus},${DeviceAutoSwitchThemeStatus},${DeviceAutoSwitchThemeStatus}";

model GetDeviceAutoSwitchThemeResponse {
    @doc("1 if auto switch is enabled, 0 if auto switch is disabled")
    sw_en: SharedModels.BooleanLikeNumberValue;
    @doc("list of theme enabled statuses separated by comma (the order is same as DeviceDesignTheme)")
    theme: DeviceAutoSwitchThemeStatusList;
    @doc("interval in seconds (default: 10)")
    sw_i: SharedModels.IntervalSecondValue;
}