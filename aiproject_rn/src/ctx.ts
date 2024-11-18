import { createContext } from "react";
import { ScrollView } from "react-native";

interface IContext {
  bigScrollView?: ScrollView;
}

const context = createContext<IContext>({});

export default context;
