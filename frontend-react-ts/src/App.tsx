import { Toaster } from "react-hot-toast";
import GlobalRouter from "./routes";
const App = () => {
  return (
    <div>
      <GlobalRouter />

      {/* Enviar Notificaciones emergentes, Ej. toast.success('Operación exitosa');*/}
      <Toaster position="top-right" reverseOrder={false} />
    </div>
  );
};

export default App;
