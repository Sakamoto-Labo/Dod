#pragma once

#include <dodsdkJSI.h>

#include <string>
#include <chrono>
#include <ctime>

namespace facebook::react {

class NativeUserSettingTimeStamp : public NativeUserSettingTimeStampCxxSpec<NativeUserSettingTimeStamp> {
public:
    NativeUserSettingTimeStamp(std::shared_ptr<CallInvoker> jsInvoker): NativeUserSettingTimeStampCxxSpec(std::move(jsInvoker)){};

    std::string getSystemTimeInfo(jsi::Runtime& rt); 
};

} // namespace facebook::react