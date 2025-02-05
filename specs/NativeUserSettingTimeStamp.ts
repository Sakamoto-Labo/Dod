import { TurboModule, TurboModuleRegistry } from "react-native";

export interface Spec extends TurboModule {
  getSystemTimeInfo(): string;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  "NativeUserSettingTimeStamp"
);
