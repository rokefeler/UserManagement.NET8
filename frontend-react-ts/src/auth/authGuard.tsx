import { Navigate, Outlet } from "react-router-dom";
import useAuth from "../hooks/useAuth.hook";
import AuthSpinner from "../components/general/AuthSpinner";
import { PATH_PUBLIC } from "../routes/paths";

//we need an interface for our props
interface IProps {
  roles: string[];
};
/** 
 *  proteger rutas en una aplicación, permitiendo solo a los usuarios 
 * autenticados con roles específicos acceder a ciertas áreas
*/
const AuthGuard = ({ roles }: IProps) => {
  const { isAuthenticated, isAuthLoading, user } = useAuth();
  // DO we have access to the request page (page will be rendered in <Outlet/>)
  const hasAccess = isAuthenticated && user?.roles?.find((q)=> roles.includes(q));
  if (isAuthLoading) {
    return <AuthSpinner />;
  }
  return hasAccess ? <Outlet /> : <Navigate to={PATH_PUBLIC.unauthorized} />;
};
export default AuthGuard;