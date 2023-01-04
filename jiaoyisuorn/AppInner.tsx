import { Outlet } from "react-router-native";
import { View, Text } from "react-native";

export default function AppInner() {
  return (
    <>
      <Outlet />
    </>
  );
}
