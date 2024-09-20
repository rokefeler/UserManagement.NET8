import axios from "axios";
import { HOST_API_KEY } from "./globalConfig";

const axiosInstance = axios.create({ baseURL: HOST_API_KEY });
//baseURL: Define una URL base (HOST_API_KEY), lo que significa que no necesitas repetir
//la URL de la URL en cada solicitud, simplificando tu código.

axiosInstance.interceptors.response.use(
  (response) => response,
  (error) =>
    Promise.reject(
      (error.response && error.response.data.message) ||
        error.message ||
        "An unexpected error occurred"
    )
);

export default axiosInstance;
