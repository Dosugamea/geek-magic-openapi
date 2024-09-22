import "../lib/shared-models.tsp";
import "@typespec/openapi3";
import "@typespec/http";

using TypeSpec.Http;

namespace Time;

model GetTimeNumberColorConfigResponse {
    @doc("current time color for hours")
    @example("#ffffff")
    hc: SharedModels.HtmlColorValue;

    @doc("current time color for minutes")
    @example("#feba01")
    mc: SharedModels.HtmlColorValue;

    @doc("current time color for seconds")
    @example("#ff5900")
    sc: SharedModels.HtmlColorValue;
}

enum TimeHourFormat {
    @doc("24 hours format")
    H24: 0,
    @doc("12 hours format")
    H12: 1,
}

model GetTimeHourFormatConfigResponse {
    @doc("""
    current time hour format

    - 0: 24 hours format
    - 1: 12 hours format
    """)
    @example(TimeHourFormat.H24)
    h: TimeHourFormat;
}

enum DateFormat {
    DD_MM_YYYY: 1,
    YYYY_MM_DD: 2,
    MM_DD_YYYY: 3,
    MM_DD: 4,
    DD_MM: 5,
}

model GetDateFormatConfigResponse {
    @doc("""
    current date format

    - 1: DD_MM_YYYY
    - 2: YYYY_MM_DD
    - 3: MM_DD_YYYY
    - 4: MM_DD
    - 5: DD_MM
    """)
    @example(DateFormat.DD_MM_YYYY)
    day_fmt: DateFormat;
}

model GetColonBlinkingConfigResponse {
    @doc("1 when colon blinking enabled, otherwise 0")
    @example(SharedModels.BooleanLikeNumberValue.DISABLED)
    colon: SharedModels.BooleanLikeNumberValue;
}

enum TimeFont {
    DEFAULT_BIG_FONT: 1,
    DIGITAL_FONT: 2,
}

model GetFontConfigResponse {
    @doc("""
    current time font

    - 1: default big font
    - 2: digital font
    """)
    @example(TimeFont.DEFAULT_BIG_FONT)
    font: TimeFont;
}

model GetNtpConfigResponse {
    @doc("ntp server address")
    @example("pool.ntp.org")
    ntp: string;
}

model GetSummerTimeConfigResponse {
    @doc("1 when summer time enabled, otherwise 0")
    @example(SharedModels.BooleanLikeNumberValue.DISABLED)
    dst: SharedModels.BooleanLikeNumberValue;
}