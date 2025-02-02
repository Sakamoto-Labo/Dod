#include "NativeUserSettingTimeStamp.h"

namespace facebook::react {

std::string NativeUserSettingTimeStamp::getSystemTimeInfo(jsi::Runtime& rt)
{
    auto now = std::chrono::system_clock::now();
    auto in_time_t = std::chrono::system_clock::to_time_t(now);

    std::string s(30, '\0');
    std::strftime(&s[0], s.size(), "%Y-%m-%d %H:%M:%S", std::localtime(&in_time_t));

    return s;
}

}