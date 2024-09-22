import "@typespec/http";
import "@typespec/openapi";

import "./endpoints/settings.tsp";
import "./endpoints/pictures.tsp";
import "./endpoints/time.tsp";
import "./endpoints/weather.tsp";
import "./endpoints/network.tsp";
import "./lib/shared-responses.tsp";
import "./lib/shared-models.tsp";

using TypeSpec.Http;

@service({
  title: "GeekMagic API",
})
@doc("GeekMagic API for customizable clock devices")
@TypeSpec.OpenAPI.info({
  version: "1.0.0",
})
@server("http://192.168.0.0", "GeekMagic API")

namespace GeekMagicApi;

@tag("shared")
@doc("api endpoints used in all pages")
namespace SharedRoute {
  @summary("Update Device config (shared)")
  @doc("""
  Update something option of a device.
  You should specify only one query in a request, if multiple queries are specified it processes only first parameter.
  But exceptionally, some endpoints wants multiple queries in one request. Please read below sheet carefully.

  - Settings page options:
    - brt: brightness value between -10 to 255 (seems it has no validation)
    - theme: device theme value
    - theme_list: list of theme enabled statuses separated by comma (must be called with sw_en and theme_interval)
    - sw_en: auto switch enabled status (must be called with theme_list and theme_interval)
    - theme_interval: interval in seconds (must be called with sw_en and theme_list)
    - t1: night mode schedule start time (must be called with t2, b1, b2, and en)"
    - t2: night mode schedule end time (must be called with t1, b1, b2, and en)"
    - b1: night mode schedule default brightness value (must be called with t1, t2, b2, and en)"
    - b2: night mode schedule night brightness value (must be called with t1, t2, b1, and en)"
    - en: night mode enabled status (must be called with t1, t2, b1, and b2)"
  - Image page options:
    - img: new image path want to show
    - i_i: image interval in seconds (must be called with autoplay)
    - autoplay: 1 if auto switch is enabled, 0 if auto switch is disabled (must be called with i_i)
  - Time page options:
    - tc: time color for hours in clock (must be called with mc and sc)
    - mc: time color for minutes in clock (must be called with tc and sc)
    - sc: time color for seconds in clock (must be called with tc and mc)
    - hour: clock hour format (Ex. 12 or 24)
    - day: clock day format (Ex. YYYY_MM_DD)
    - colon: 1 if colon blinking is enabled, 0 if colon blinking is disabled
    - font: time font (1: default big font, 2: digital font)
    - ntp: ntp server address
    - dst: 1 when summer time enabled, otherwise 0
  - Weather page options:
    - w_i: weather interval in minutes
    - gif: file path for bottom right mini animation (only works for weather clocks)
  - Network page options:
    - delay: delay in seconds before try to connect network at startup (default: 0)
  """)
  @route("/set")
  @get
  op updateDevice(
    // settings
    @query brt?: Settings.BrightnessValue;
    @query theme?: Settings.DeviceDesignTheme;
    @query theme_list?: Settings.DeviceAutoSwitchThemeStatusList;
    @query sw_en?: Settings.DeviceAutoSwitchThemeStatusList;
    @query theme_interval?: SharedModels.IntervalSecondValue;
    @query t1?: Settings.HourValue;
    @query t2?: Settings.HourValue;
    @query b1?: Settings.BrightnessValue;
    @query b2?: Settings.BrightnessValue;
    @query en?: SharedModels.BooleanLikeNumberValue;
    // pictures
    @query img?: SharedModels.ImagePathValue;
    @query i_i?: SharedModels.IntervalSecondValue;
    @query autoplay?: SharedModels.BooleanLikeNumberValue;
    // time
    @query tc?: SharedModels.HtmlColorValue;
    @query mc?: SharedModels.HtmlColorValue;
    @query sc?: SharedModels.HtmlColorValue;
    @query hour?: Time.TimeHourFormat;
    @query day?: Time.DateFormat;
    @query colon?: SharedModels.BooleanLikeNumberValue;
    @query font?: Time.TimeFont;
    @query ntp?: string;
    @query dst?: SharedModels.BooleanLikeNumberValue;
    // weather
    @query w_i?: SharedModels.IntervalMinuteValue;
    @query gif?: SharedModels.ImagePathValue;
    // network
    @query delay?: SharedModels.IntervalSecondValue
  ): SharedResponses.SuccessResponse | SharedResponses.FailureResponse;

  @summary("Get device storage info")
  @doc("Get device total and free storage size in bytes")
  @route("/space.json")
  @get
  op getDeviceStorageInfo(): SharedModels.GetDeviceStorageInfoResponse;

  @summary("Get file list")
  @doc("Get uploaded file list for specified directory in html table")
  @route("/filelist")
  @get
  op getFileList(
    @query dir: "/image/" | "/gif"
  ): SharedModels.GetFileListResponse;

  @summary("Upload file")
  @doc("""
  Upload file to specified directory
  The file format recommendation is different for each directory.

  - "/image"
    - Extension must be JPG or GIF
    - Resolusion must be 240x240px
  - "/gif"
    - Extension must be GIF
    - Resolusion must be 80x80px or lower
  """)
  @route("/upload")
  @post
  op uploadFile(
    @query dir: "/image" | "/gif",
    ...SharedModels.UploadFileRequest,
  ): SharedModels.GetFileListResponse | SharedResponses.FailureResponse;

  @summary("Delete file")
  @doc("Delete specified file (this endpoint always returns 'FAIL' <- WHAT)")
  @route("/delete")
  @get
  op deleteFile(
    @query file: SharedModels.ImagePathValue
  ):SharedResponses.FailureResponse;
}

@tag("settings")
@doc("api endpoints made for settings page")
namespace SettingsRoute {
  @summary("Get Device information")
  @doc("Get device name and version")
  @route("/v.json")
  @get
  op getDeviceInfo(): Settings.GetDeviceInfoResponse;

  @summary("Get Device brightness")
  @doc("Get current device brightness value between -10 to 255")
  @route("/brt.json")
  @get
  op getDeviceBrightness(): Settings.GetDeviceBrightnessResponse | SharedResponses.NoDataResponse;

  @summary("Get Device brightness schedule (night mode config)")
  @doc("Get current device brightness schedule (night mode config)")
  @route("/timebrt.json")
  @get
  op getDeviceBrightnessSchedule(): Settings.GetDeviceBrightnessScheduleResponse | SharedResponses.NoDataResponse;


  @summary("Get Device Theme")
  @doc("Get current device theme value")
  @route("/app.json")
  @get
  op getDeviceTheme(): Settings.GetDeviceThemeResponse | SharedResponses.NoDataResponse;

  @summary("Get Device Auto Switch Theme")
  @doc("Get current device auto switch theme value")
  @route("/auto.json")
  @get
  op getDeviceAutoSwitchTheme(): Settings.GetDeviceAutoSwitchThemeResponse | SharedResponses.NoDataResponse;
}

@tag("pictures")
@doc("api endpoints made for pictures page")
namespace PicturesRoute {
  @summary("Get Device Auto Display")
  @doc("Get image carousel config status")
  @route("/album.json")
  @get
  op getAutoDisplay(): Pictures.GetAutoDisplayResponse | SharedResponses.NoDataResponse;
}

@tag("time")
namespace TimeRoute {
  @summary("Get time number color configuration")
  @doc("Get current time number color configuration (seems not working?)")
  @route("/timecolor.json")
  @get
  op getTimeNumberColorConfig(): Time.GetTimeNumberColorConfigResponse | SharedResponses.NoDataResponse;

  @summary("Get clock hour format (12 or 24) configuration")
  @doc("Get current clock hour format configuration")
  @route("/hour12.json")
  @get
  op getTimeHourFormatConfig(): Time.GetTimeHourFormatConfigResponse | SharedResponses.NoDataResponse;

  @summary("Get date format configuration")
  @doc("Get current date format configuration")
  @route("/day.json")
  @get
  op getDateFormatConfig(): Time.GetDateFormatConfigResponse | SharedResponses.NoDataResponse;

  @summary("Get colon blinking in clock configuration")
  @doc("Get current colon blinking status in clock configuration")
  @route("/colon.json")
  @get
  op getColonBlinkingConfig(): Time.GetColonBlinkingConfigResponse | SharedResponses.NoDataResponse;

  @summary("Get font configuration")
  @doc("Get current font configuration")
  @route("/font.json")
  @get
  op getFontConfig(): Time.GetFontConfigResponse | SharedResponses.NoDataResponse;

  @summary("Get ntp server configuration")
  @doc("Get current ntp server configuration")
  @route("/ntp.json")
  @get
  op getNtpConfig(): Time.GetNtpConfigResponse | SharedResponses.NoDataResponse;

  @summary("Get summer time configuration")
  @doc("Get current summer time configuration")
  @route("/dst.json")
  @get
  op getSummerTimeConfig(): Time.GetSummerTimeConfigResponse | SharedResponses.NoDataResponse;
}

@tag("weather")
namespace WeatherRoute {
  @summary("Get current city code for weather forecast")
  @doc("Get current city code for weather forecast")
  @route("/city.json")
  @get
  op getCurrentCityCode(): Weather.GetCurrentCityCodeResponse | SharedResponses.NoDataResponse;

  @summary("Get weather unit format configuration")
  @doc("Get current weather unit format configuration")
  @route("/unit.json")
  @get
  op getWeatherUnitFormatConfig(): Weather.GetWeatherUnitFormatConfigResponse | SharedResponses.NoDataResponse;

  @summary("Get weather update interval configuration")
  @doc("Get current weather update interval configuration")
  @route("/w_i.json")
  @get
  op getWeatherUpdateIntervalConfig(): Weather.GetWeatherUpdateIntervalConfigResponse | SharedResponses.NoDataResponse;

  @summary("Get weather forecast api key configuration")
  @doc("Get current weather forecast api key (untested)")
  @route("/key.json")
  @get
  op getWeatherForecastApiKey(): Weather.GetWeatherForecastApiKeyResponse | SharedResponses.NoDataResponse;
}

@tag("network")
namespace NetworkRoute {
  @summary("Update network configuration")
  @doc("Update network SSID and PASSWORD")
  @route("/wifisave")
  @post
  op updateNetworkConfig(
    @doc("new network SSID")
    @query s: string;
    @doc("new network PASSWORD (PLAIN TEXT)")
    @query p: string
  ): SharedResponses.SuccessResponse | SharedResponses.FailureResponse;

  @summary("Get network configuration")
  @doc("Get current network SSID and PASSWORD")
  @route("/config.json")
  @get
  op getNetworkConfig(): Network.GetNetworkConfigResponse | SharedResponses.NoDataResponse;

  @summary("Get network delay configuration")
  @doc("Get network connection delay in seconds")
  @route("/delay.json")
  @get
  op getNetworkDelayConfig(): Network.GetNetworkDelayConfigResponse | SharedResponses.NoDataResponse;
}